import 'dart:convert';

class EmployeeTimeModel {
  final String? uid;
  final String? startTime;
  final String? endTime;
  final String? timestamp;
  final String? date;
  final String? employeeName;
  final String? employeeId;
  final String? companyName;
  final int? totalTime;

  EmployeeTimeModel({
    this.uid,
    this.startTime,
    this.endTime,
    this.timestamp,
    this.date,
    this.employeeName,
    this.employeeId,
    this.companyName,
    this.totalTime,
  });
//Katy,Laporte,Houston
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'startTime': startTime,
      'endTime': endTime,
      'timestamp': timestamp,
      'date': date,
      'employeeName': employeeName,
      'employeeId': employeeId,
      'companyName': companyName,
      'totalTime': totalTime,
    };
  }

  factory EmployeeTimeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeTimeModel(
      uid: map['uid'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      timestamp: map['timestamp'],
      date: map['date'],
      employeeName: map['employeeName'],
      employeeId: map['employeeId'],
      companyName: map['companyName'],
      totalTime: map['totalTime'],
    );
  }

  factory EmployeeTimeModel.fromDocument(doc) {
    return EmployeeTimeModel(
      uid: doc.data()["uid"],
      startTime: doc.data()["startTime"],
      endTime: doc.data()["endTime"],
      timestamp: doc.data()["timestamp"],
      date: doc.data()["date"],
      employeeName: doc.data()["employeeName"],
      employeeId: doc.data()["employeeId"],
      companyName: doc.data()["companyName"],
      totalTime: doc.data()["totalTime"],
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeTimeModel.fromJson(String source) =>
      EmployeeTimeModel.fromMap(json.decode(source));
}
