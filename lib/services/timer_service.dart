import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:salary_tracking_app/consts/collections.dart';
import 'package:salary_tracking_app/database/local_database.dart';
import 'package:salary_tracking_app/helpers.dart';
import 'package:salary_tracking_app/models/timed_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerService with ChangeNotifier {
  TimedEvent? _timedEvents;
  // = TimedEvent(
  //     id: currentUser!=null?int.parse(currentUser!.id!):0,
  //     title: 'New Event',
  //     time: '00:00:00',
  //     companyName:'asd',
  //     employName: 'asd',
  //     imageUrl: 'asd',
  //     // date: Timestamp.now(),
  //     active: true,
  //     totalSecondsPerSession: 0,
  //     startTime: '00:00:00',
  //     wage: currentUser!.wage!,
  //     isAdmin: currentUser!.isAdmin!);
  TimedEvent get timedEvents => _timedEvents!;
  // List<TimedEvent> _timedEventsList = [];
  // List<TimedEvent> get timedEventsList => _timedEventsList.reversed.toList();

  Timer? timer;

  bool get timerActive =>
      _timedEvents != null && _timedEvents!.active ? true : false;
  // TimedEvent get activeEvent => _timedEventsList.firstWhere((e) => e.active);
  TimedEvent get activeEvent => _timedEvents!;

  int _seconds = 0;
  String get currentTime {
    Duration current = Duration(seconds: _seconds);
    String hours = padNumber(current.inHours);
    String minutes = padNumber(current.inMinutes.remainder(60));
    String seconds = padNumber(current.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  // TimedEvent(title: 'My Event 1', time: '01:24:17'),
  // TimedEvent(title: 'My Event 2', time: '01:24:18'),
  // TimedEvent(title: 'My Event 3', time: '01:24:19'),
  // TimedEvent(title: 'My Event 4', time: '01:24:20'),

  TimerService() {
    load();
  }

  void save() {
    String data = jsonEncode(_timedEvents!.toMap());
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('EVENTS', data);
    });
  }

  void load() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('EVENTS')) {
        String data = prefs.getString('EVENTS')!;
        var asd = jsonDecode(data);
        print(asd);
        _timedEvents = TimedEvent.fromJson(asd);
        if (timerActive) {
          DateTime startTime = DateTime.parse(activeEvent.startTime);
          _seconds = DateTime.now().difference(startTime).inSeconds;
          startTimer();
        }

        notifyListeners();
      }
    });
  }

  void addNew() {
    if (timerActive) return;

    DateTime startTime = DateTime.now();

    TimedEvent newEvent = TimedEvent(
        id: currentUser!.id!,
        title: 'New Event',
        time: '00:00:00',
        companyName: currentUser!.companyName!,
        employName: currentUser!.name!,
        imageUrl: currentUser!.imageUrl!,
        // date: Timestamp.now(),
        active: true,
        totalSecondsPerSession: _seconds,
        startTime: startTime.toIso8601String(),
        wage: currentUser == null ? '0.0' : currentUser!.wage!,
        isAdmin: currentUser!.isAdmin!);
    // _timedEventsList.add(newEvent);

    _timedEvents = newEvent;
    notifyListeners();

    _seconds = 0;
    startTimer();

    save();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
      notifyListeners();
    });
  }

  void stop() {
    if (timer != null && !timer!.isActive) return;

    timer!.cancel();
    TimedEvent event = activeEvent.copyWith(
        active: false, time: currentTime, totalSecondsPerSession: _seconds);

    // int currentIndex = _timedEventsList.indexWhere((e) => e.active);
    // _timedEventsList[currentIndex] = event;
    _timedEvents = event;
    save();
    print(_timedEvents!.id);
    print(currentUser!.id);
    timerRef.doc(currentUser!.id).get().then((value) {
      if (value.exists) {
        TimedEvent event = TimedEvent.fromDocument(value);
        timerRef.doc(currentUser!.id).update({
          'totalSecondsPerSession': event.totalSecondsPerSession +
              _timedEvents!.totalSecondsPerSession,
          'wage': currentUser!.wage
        });
      } else {
        timerRef.doc(currentUser!.id).set(_timedEvents!.toMap());
      }
    });
    notifyListeners();
  }

  // void delete(int id) {
  //   _timedEventsList.removeWhere((e) => e.id == id && e.active == false);
  //   notifyListeners();
  //   save();
  // }

  // void edit(int id, String title) {
  //   TimedEvent updatedEvent =
  //       _timedEventsList.firstWhere((e) => e.id == id).copyWith(title: title);
  //   int index = _timedEventsList.indexWhere((e) => e.id == id);
  //   _timedEventsList[index] = updatedEvent;
  //   notifyListeners();
  //   save();
  // }

  // void clearAllData() {
  //   if (timer != null && timer!.isActive) {
  //     timer!.cancel();
  //   }
  //   _timedEventsList = [];
  //   save();
  //   notifyListeners();
  // }
}
