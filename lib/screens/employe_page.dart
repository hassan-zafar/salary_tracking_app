import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  CalendarFormat _format = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
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
            label: const Text('Submit'),
            onPressed: () {},
          ),
          body: SingleChildScrollView(
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
                    print('selectedDate $selectedDate');
                    print('focusedDay $focusedDay');
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
                          margin: EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              enabled: _endTimeController.text.isEmpty,
                              controller: _startTimeController,
                              onTap: () async {
                                var asd = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                                setState(() {
                                  _startTimeController.text =
                                      asd!.format(context);
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
                          margin: EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _endTimeController,
                              enabled: _startTimeController.text.isNotEmpty,
                              onTap: () async {
                                if (_startTimeController.text.isNotEmpty) {
                                  var asd = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now());
                                  setState(() {
                                    _endTimeController.text =
                                        asd!.format(context);
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
          )),
    );
  }
}
