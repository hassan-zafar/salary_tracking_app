import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salary_tracking_app/consts/collections.dart';
import 'package:salary_tracking_app/widgets/pause_button.dart';
import 'package:table_calendar/table_calendar.dart';
import '../helpers.dart';
import '../models/timed_event.dart';
import '../services/timer_service.dart';
import '../widgets/clock_widget.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  CalendarFormat _format = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  DateTime startTimeOfDay = DateTime.now();
  DateTime endTimeOfDay = DateTime.now();
  bool startTimeSelected = false;
  bool endTimeSelected = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  int difference = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool timerActive = context.watch<TimerService>().timerActive;
    TimedEvent? event;
    if (timerActive) event = context.watch<TimerService>().activeEvent;
    return SafeArea(
      child: Scaffold(
          // floatingActionButton: FloatingActionButton.extended(
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          //   isExtended: true,
          //   label: _isLoading
          //       ? const CircularProgressIndicator()
          //       : const Text('Submit'),
          //   onPressed: () async {
          //     if (_formKey.currentState!.validate()) {
          //       setState(() {
          //         _isLoading = true;
          //       });
          //       final now = DateTime.now();
          //       DateTime _startTime = DateTime(now.month, now.month, now.day,
          //           startTimeOfDay.hour, startTimeOfDay.minute);
          //       DateTime _endTime = DateTime(now.month, now.month, now.day,
          //           endTimeOfDay.hour, endTimeOfDay.minute);
          //       difference = _endTime.difference(_startTime).inSeconds;
          //       print(difference);
          //       double _doubleStartTime = startTimeOfDay.hour.toDouble() +
          //           (startTimeOfDay.minute.toDouble() / 60);
          //       double _doubleEndTime = endTimeOfDay.hour.toDouble() +
          //           (endTimeOfDay.minute.toDouble() / 60);
          //       double _timeDiff = _doubleEndTime - _doubleStartTime;
          //       int _hr = _timeDiff.truncate();
          //       double totalTime = (_timeDiff - _timeDiff.truncate()) * 60;
          //       await FirebaseApi().submitEmployeeTime(
          //           startTime: _startTime,
          //           endTime: _endTime,
          //           totalTime: difference,
          //           uid: currentUser!.id!);
          //       setState(() {
          //         _isLoading = false;
          //       });
          //     } else {
          //       CustomToast.errorToast(message: 'Please fill all the fields');
          //     }
          //   },

          // ),

          body: SingleChildScrollView(
        child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TableCalendar(
                    //   lastDay: DateTime.now(),
                    //   firstDay: DateTime(2022),
                    //   focusedDay: _focusedDay,
                    //   currentDay: DateTime.now(),
                    //   selectedDayPredicate: (asd) {
                    //     return asd.day == _selectedDay?.day;
                    //   },
                    //   onFormatChanged: (asd) {
                    //     setState(() {
                    //       _format = asd;
                    //     });
                    //   },
                    //   calendarFormat: _format,
                    //   holidayPredicate: (asd) {
                    //     return false;
                    //   },
                    //   onDaySelected: (selectedDate, focusedDay) {
                    //     setState(() {
                    //       _selectedDay = selectedDate;
                    //       _focusedDay = focusedDay;
                    //     });
                    //   },
                    //   availableCalendarFormats: const {
                    //     CalendarFormat.month: 'Month',
                    //     CalendarFormat.twoWeeks: '2 weeks',
                    //     CalendarFormat.week: 'Week',
                    //   },
                    // ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BlurryContainer(
                        height: 350,
                        width: double.maxFinite,
                        blur: 8,
                        bgColor: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 200,
                                width: 200,
                                child: Clock(time: DateTime.now())),
                            // GestureDetector(
                            //   onTap: () {
                            //     startTimeOfDay = DateTime.now();
                            //     setState(() {
                            //       startTimeSelected = true;
                            //     });
                            //   },
                            //   child: Container(
                            //       decoration: BoxDecoration(
                            //           color: startTimeSelected
                            //               ? Colors.red
                            //               : Colors.grey,
                            //           borderRadius: BorderRadius.circular(16)),
                            //       padding: const EdgeInsets.all(16),
                            //       child: Text(startTimeSelected
                            //           ? 'Your Log Time: ${TimeOfDay.fromDateTime(startTimeOfDay).format(context)}'
                            //           : 'Start Logging Time')),
                            // ),

                            // Opacity(
                            //   opacity: endTimeSelected ? 1 : 0.1,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       endTimeOfDay = DateTime.now();
                            //       setState(() {
                            //         endTimeSelected = true;
                            //         difference = endTimeOfDay
                            //             .difference(startTimeOfDay)
                            //             .inSeconds;
                            //         dailyWage =
                            //             (currentUser!.wage! / 3600) * difference;
                            //       });
                            //     },
                            //     child: Container(
                            //         decoration: BoxDecoration(
                            //             color: Colors.grey,
                            //             borderRadius: BorderRadius.circular(16)),
                            //         padding: const EdgeInsets.all(16),
                            //         child: Text(endTimeSelected
                            //             ? 'Your End Time: ${TimeOfDay.fromDateTime(endTimeOfDay).format(context)}'
                            //             : 'End Logging Time')),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.all(5),
                        height: 80,
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const PauseButton(),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (timerActive) ...[
                                  Builder(builder: (context) {
                                    DateTime startTime =
                                        DateTime.parse(event!.startTime);
                                    String h = padNumber(startTime.hour);
                                    String m = padNumber(startTime.minute);
                                    String s = padNumber(startTime.second);
                                    String startTimeString = "$h:$m:$s";

                                    return Text(
                                        'CLOCK STARTED AT $startTimeString');
                                  })
                                ] else ...[
                                  const Text('NO ACTIVE TIMER'),
                                ],
                                const SizedBox(height: 5),
                                Expanded(
                                  child: Text(
                                    timerActive
                                        ? context
                                            .watch<TimerService>()
                                            .currentTime
                                        : '00:00:00',
                                    style: const TextStyle(
                                      fontSize: 55,
                                      fontWeight: FontWeight.w200,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    event != null
                        ? BlurryContainer(
                            height: 150,
                            width: 300,
                            bgColor: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                        'Total Time: ${DateTime.now().difference(DateTime.parse(event.startTime)).inMinutes} min')),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                        currentUser==null?'':"Today's  Wage: \$ ${(double.parse(currentUser!.wage!) * DateTime.now().difference(DateTime.parse(event.startTime)).inHours).toStringAsFixed(2)}")),
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
      )),
    );
  }
}
