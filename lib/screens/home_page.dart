import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salary_tracking_app/Extensions/integer_extensions.dart';
import 'package:salary_tracking_app/consts/consants.dart';
import 'package:salary_tracking_app/models/employeeTimeModel.dart';
import 'package:salary_tracking_app/widgets/loadingWidget.dart';
import '../consts/collections.dart';
import '../models/users.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final date =
      '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
  bool isLoading = false;
  List<EmployeeTimeModel> employeeTimeList = [];

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

  // getAllEmployees() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //    getAllEmployeeTime(date);

  //   setState(() {
  //     isLoading = false;
  //   });
  // }
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
    // final allEmployees = await getAllEmployess();

    // allEmployees.forEach((employee) async {
    //   final employeeTime = await getEmployeeTime(employee.id!, date);
    //   if (employeeTime != null) {
    //     print('employeeTime: $employeeTime');
    //     employeeTimeListTemp.add(employeeTime);
    //   }
    // });
    setState(() {
      employeeTimeList = employeeTimeListTemp;
      print('employeeTimeList $employeeTimeList');
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
        body: isLoading
            ? LoadingIndicator()
            : ListView.builder(
                itemCount: employeeTimeList.length,
                itemBuilder: (context, index) {
                  EmployeeTimeModel employeeData = employeeTimeList[index];
                  return InkWell(
                    onDoubleTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Edit Employee Hourly Rate'),
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
                              child: Text('${employeeData.companyName!}',
                                  style: titleTextStyle(context: context)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hourly Rate:",
                                    style: titleTextStyle(
                                        context: context, fontSize: 16),
                                  ),
                                  Text(employeeData.wage!.toString()),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.timer),
                                      Text(
                                        'Total Time:',
                                        style: titleTextStyle(
                                            context: context, fontSize: 16),
                                      ),
                                      Text(employeeData.totalTime!
                                          .formatSecondsToTimeWithFormat),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.monetization_on_outlined),
                                      Text(
                                        '30 \$',
                                        style: titleTextStyle(
                                            context: context, fontSize: 16),
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
    );
  }
}
