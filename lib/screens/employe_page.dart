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
  TextEditingController _startTimecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            isExtended: true,
            label: Text('Submit'),
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
                Row(
                  children: [
                    const Expanded(
                        child: Text(
                      'Log Starting Time:',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    )),
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _startTimecontroller,
                            onTap: () async {
                              var asd = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              _startTimecontroller.text = asd!.format(context);
                              print(asd);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Opacity(
                  opacity: 0.4,
                  child: Column(
                    children: [
                      const Text('Log End Time'),
                      TimePickerDialog(initialTime: TimeOfDay.now())
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
