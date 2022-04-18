import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:salary_tracking_app/models/employeeTimeModel.dart';

import '../consts/collections.dart';
import '../models/users.dart';

class EmployeeTimeProvider with ChangeNotifier {
  // List<EmployeeTimeModel>? _employeeTimeList;

  // List<EmployeeTimeModel> get employeeTimeList => _employeeTimeList!;

  // set employeeTimeList(List<EmployeeTimeModel> employeeTimeModel){
  //   _employeeTimeList = employeeTimeModel;
  //   notifyListeners();
  // }
  List<EmployeeTimeModel> _employeeTimeList = [];
  List<EmployeeTimeModel> get employeeTimeList {
    return [..._employeeTimeList];
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
    _employeeTimeList = [];
    final allEmployees = await getAllEmployess();
    allEmployees.forEach((employee) async {
      final employeeTime = await getEmployeeTime(employee.id!, date);
      if (employeeTime != null ) {
        print('employeeTime: $employeeTime');
        _employeeTimeList.add(employeeTime);
      }
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
}
