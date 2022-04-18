import 'package:flutter/material.dart';
import 'package:salary_tracking_app/services/firebase_api.dart';
import 'package:salary_tracking_app/widgets/custom_toast.dart';
import 'package:table_calendar/table_calendar.dart';

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
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TimeOfDay startTimeOfDay;
  late TimeOfDay endTimeOfDay;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
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
                    startTimeOfDay.format(context),
                    endTimeOfDay.format(context),
                    _selectedDay!,
                    difference);
                setState(() {
                  _isLoading = false;
                  _endTimeController.clear();
                  _startTimeController.clear();
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
                  Opacity(
                    opacity: _endTimeController.text.isEmpty ? 1 : 0.1,
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text(
                          'Log Starting Time:',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        )),
                        Expanded(
                          child: Card(
                            margin: const EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                enabled: _endTimeController.text.isEmpty,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter starting time';
                                  }
                                  return null;
                                },
                                controller: _startTimeController,
                                onTap: () async {
                                  var asd = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now());
                                  setState(() {
                                    _startTimeController.text =
                                        asd!.format(context);
                                    startTimeOfDay = asd;
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Opacity(
                    opacity: _startTimeController.text.isEmpty ? 0.1 : 1,
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text(
                          'Log Ending Time:',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        )),
                        Expanded(
                          child: Card(
                            margin: const EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _endTimeController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter ending time';
                                  }
                                  return null;
                                },
                                enabled: _startTimeController.text.isNotEmpty,
                                onTap: () async {
                                  if (_startTimeController.text.isNotEmpty) {
                                    var asd = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now());
                                    setState(() {
                                      _endTimeController.text =
                                          asd!.format(context);
                                      endTimeOfDay = asd;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
