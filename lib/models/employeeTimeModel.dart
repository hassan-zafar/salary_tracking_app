import 'dart:convert';

class EmployeeTimeModel {
  final String? uid;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? timestamp;
  final DateTime? date;
  final String? employeeName;
  final String? employeeId;
  final String? companyName;
  final String? jobTitle;
  final double? wage;
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
    this.wage,
    this.jobTitle,
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
      'wage': wage,
      'jobTitle': jobTitle,
      
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
      wage: map['wage'],
      jobTitle: map['jobTitle'],
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
      wage: doc.data()["wage"],
      jobTitle: doc.data()["jobTitle"],

    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeTimeModel.fromJson(String source) =>
      EmployeeTimeModel.fromMap(json.decode(source));
}
