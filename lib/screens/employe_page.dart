import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salary_tracking_app/consts/collections.dart';
import 'package:salary_tracking_app/services/firebase_api.dart';
import 'package:salary_tracking_app/widgets/slide_countdown_clock.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/employeeTimeModel.dart';
import '../widgets/clock_widget.dart';
import '../widgets/custom_toast copy.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  CalendarFormat _format = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  TimeOfDay startTimeOfDay = TimeOfDay.now();
  TimeOfDay endTimeOfDay = TimeOfDay.now();
  bool startTimeSelected = false;
  bool endTimeSelected = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            isExtended: true,
            label: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Submit'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _isLoading = true;
                });
                final now = DateTime.now();
                DateTime _startTime = DateTime(now.month, now.month, now.day,
                    startTimeOfDay.hour, startTimeOfDay.minute);
                DateTime _endTime = DateTime(now.month, now.month, now.day,
                    endTimeOfDay.hour, endTimeOfDay.minute);
                final difference = _endTime.difference(_startTime).inSeconds;
                print(difference);
                double _doubleStartTime = startTimeOfDay.hour.toDouble() +
                    (startTimeOfDay.minute.toDouble() / 60);
                double _doubleEndTime = endTimeOfDay.hour.toDouble() +
                    (endTimeOfDay.minute.toDouble() / 60);
                double _timeDiff = _doubleEndTime - _doubleStartTime;
                int _hr = _timeDiff.truncate();
                double totalTime = (_timeDiff - _timeDiff.truncate()) * 60;

                await FirebaseApi().submitEmployeeTime(
                    startTime: _startTime,
                    endTime: _endTime,
                    totalTime: difference,
                    uid: currentUser!.id!);
                setState(() {
                  _isLoading = false;
                });
              } else {
                CustomToast.errorToast(message: 'Please fill all the fields');
              }
            },
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TableCalendar(
                    lastDay: DateTime.now(),
                    firstDay: DateTime(2022),
                    focusedDay: _focusedDay,
                    currentDay: DateTime.now(),
                    selectedDayPredicate: (asd) {
                      return asd.day == _selectedDay?.day;
                    },
                    onFormatChanged: (asd) {
                      setState(() {
                        _format = asd;
                      });
                    },
                    calendarFormat: _format,
                    holidayPredicate: (asd) {
                      return false;
                    },
                    onDaySelected: (selectedDate, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDate;
                        _focusedDay = focusedDay;
                      });
                    },
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.twoWeeks: '2 weeks',
                      CalendarFormat.week: 'Week',
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      startTimeOfDay = TimeOfDay.now();
                      setState(() {
                        startTimeSelected = true;
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: startTimeSelected ? Colors.red : Colors.grey,
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(16),
                        child: Text(startTimeSelected
                            ? startTimeOfDay.format(context)
                            : 'Start Logging Time')),
                  ),
                  Container(
                      height: 200,
                      width: 200,
                      child: Clock(time: DateTime.now())),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: SlideCountdownClock(
                  //     duration: const Duration(seconds: 10),
                  //     slideDirection: SlideDirection.Up,
                  //     separator: "-",
                  //     textStyle: const TextStyle(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white,
                  //     ),
                  //     separatorTextStyle: const TextStyle(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.blue,
                  //     ),
                  //     padding: const EdgeInsets.all(10),
                  //     decoration: const BoxDecoration(
                  //         color: Colors.blue, shape: BoxShape.circle),
                  //     onDone: () {
                  //       // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
                  //     },
                  //   ),
                  // ),

                  Opacity(
                    opacity: endTimeSelected ? 1 : 0.1,
                    child: GestureDetector(
                      onTap: () {
                        endTimeOfDay = TimeOfDay.now();
                        setState(() {
                          endTimeSelected = true;
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.all(16),
                          child: Text(endTimeSelected
                              ? endTimeOfDay.format(context)
                              : 'End Logging Time')),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
