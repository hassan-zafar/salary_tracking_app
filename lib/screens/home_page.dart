import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salary_tracking_app/Extensions/integer_extensions.dart';
import 'package:salary_tracking_app/consts/consants.dart';
import 'package:salary_tracking_app/models/employeeTimeModel.dart';
import 'package:salary_tracking_app/widgets/loadingWidget.dart';
import 'package:table_calendar/table_calendar.dart';
import '../consts/collections.dart';
import '../models/users.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String date =
      '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
  bool isLoading = false;
  List<EmployeeTimeModel> employeeTimeList = [];
  CalendarFormat _format = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  getDate(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }

  @override
  // void initState() {
  //   super.initState();
  //   getEmployeeTime();
  // }

  // getEmployeeTime() async {
  //   Provider.of<EmployeeTimeProvider>(context, listen: false)
  //       .getAllEmployeeTime(date);
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllEmployeeTime(date);
  }

  Future<List<AppUserModel>> getAllEmployess() async {
    QuerySnapshot users =
        await userRef.where("isAdmin", isNotEqualTo: true).get();
    List<AppUserModel> usersList = [];
    users.docs.forEach((element) {
      usersList.add(AppUserModel.fromDocument(element));
    });
    return usersList;
  }

  getAllEmployeeTime(String date) async {
    setState(() {
      isLoading = true;
    });
    final List<EmployeeTimeModel> employeeTimeListTemp = [];
    final snaphot =
        await employeeTimeRef.doc(date).collection('employeeDayData').get();
    snaphot.docs.forEach((element) {
      employeeTimeListTemp.add(EmployeeTimeModel.fromDocument(element));
    });
    setState(() {
      employeeTimeList = employeeTimeListTemp;
      isLoading = false;
    });
  }

  getEmployeeTime(String employeeId, String date) async {
    final snapshot = await employeeTimeRef
        .doc(date)
        .collection('employeeDayData')
        .doc(employeeId)
        .get();
    if (snapshot.data() != null) {
      print(snapshot.data());

      final asd = EmployeeTimeModel.fromDocument(snapshot);

      return asd;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
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
                date = getDate(_selectedDay!);
                getAllEmployeeTime(date);
              });
            },
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
              CalendarFormat.twoWeeks: '2 weeks',
              CalendarFormat.week: 'Week',
            },
          ),
          isLoading
              ? LoadingIndicator()
              : Expanded(
                  child: ListView.builder(
                      itemCount: employeeTimeList.length,
                      itemBuilder: (context, index) {
                        EmployeeTimeModel employeeData =
                            employeeTimeList[index];
                        return InkWell(
                          onDoubleTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title:
                                        const Text('Edit Employee Hourly Rate'),
                                    content: TextField(
                                      controller: TextEditingController(
                                          text: employeeData.wage.toString()),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'Employee Rate',
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: const Text('Save'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          // setState(() {
                                          //   employeeData.rate =
                                          //       int.parse(
                                          //           (context as BuildContext).
                                          //               findRenderObject().
                                          //               debugSemantics.
                                          //               semanticsOwner.
                                          //               semantics.
                                          //               firstWhere((element) =>
                                          //                   element.label ==
                                          //                       'Employee Time')
                                          //                   .value);
                                          // });
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(employeeData.companyName!=null?'${employeeData.companyName!}':'',
                                        style:
                                            titleTextStyle(context: context)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Name:",
                                          style: titleTextStyle(
                                              context: context, fontSize: 16),
                                        ),
                                        Text(employeeData.employeeName!),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Job Title:",
                                          style: titleTextStyle(
                                              context: context, fontSize: 16),
                                        ),
                                        Text(employeeData.jobTitle ?? '-'),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hourly Rate:",
                                          style: titleTextStyle(
                                              context: context, fontSize: 16),
                                        ),
                                        Text('${employeeData.wage}'),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.timer),
                                            Text(
                                              'Total Time:',
                                              style: titleTextStyle(
                                                  context: context,
                                                  fontSize: 16),
                                            ),
                                            Text(employeeData.totalTime!
                                                .formatSecondsToTimeWithFormat),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                                Icons.monetization_on_outlined),
                                            Text(
                                              '30 \$',
                                              style: titleTextStyle(
                                                  context: context,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
        ]),
      ),
    );
  }
}
