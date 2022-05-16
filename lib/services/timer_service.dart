import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salary_tracking_app/database/local_database.dart';
import 'package:salary_tracking_app/helpers.dart';
import 'package:salary_tracking_app/models/timed_event.dart';

class TimerService with ChangeNotifier {
  List<TimedEvent> _timedEvents = [];
  List<TimedEvent> get timedEvents => _timedEvents.reversed.toList();

  Timer? timer;

  bool get timerActive => _timedEvents.any((e) => e.active);
  TimedEvent get activeEvent => _timedEvents.firstWhere((e) => e.active);

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
    String data = jsonEncode(
        _timedEvents.map((event) => TimedEvent.toMap(event)).toList());

    GetStorage().write('events', data);
  }

  void load() {
    String data = UserLocalData().getEvents();
        print('data : $data');
if (data != null && data.isNotEmpty) {
      _timedEvents = jsonDecode(data)
          .map<TimedEvent>((item) => TimedEvent.fromJson(item))
          .toList();
    }

    if (timerActive) {
      DateTime startTime = DateTime.parse(activeEvent.startTime);
      _seconds = DateTime.now().difference(startTime).inSeconds;
      startTimer();
    }

    notifyListeners();
  }

  void addNew() {
    if (timerActive) return;

    DateTime startTime = DateTime.now();

    TimedEvent newEvent = TimedEvent(
        id: startTime.millisecondsSinceEpoch,
        title: 'New Event',
        time: '00:00:00',
        active: true,
        startTime: startTime.toIso8601String());

    _timedEvents.add(newEvent);
    notifyListeners();

    _seconds = 0;
    startTimer();

    save();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;
      notifyListeners();
    });
  }

  void stop() {
    if (timer != null && !timer!.isActive) return;

    timer!.cancel();
    TimedEvent event = activeEvent.copyWith(
      active: false,
      time: currentTime,
    );

    int currentIndex = _timedEvents.indexWhere((e) => e.active);
    _timedEvents[currentIndex] = event;
    save();
    notifyListeners();
  }

  void delete(int id) {
    _timedEvents.removeWhere((e) => e.id == id && e.active == false);
    notifyListeners();
    save();
  }

  void edit(int id, String title) {
    TimedEvent updatedEvent =
        _timedEvents.firstWhere((e) => e.id == id).copyWith(title: title);
    int index = _timedEvents.indexWhere((e) => e.id == id);
    _timedEvents[index] = updatedEvent;
    notifyListeners();
    save();
  }

  void clearAllData() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    _timedEvents = [];
    save();
    notifyListeners();
  }
}
