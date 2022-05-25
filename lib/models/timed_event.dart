import 'package:cloud_firestore/cloud_firestore.dart';

class TimedEvent {
  final String id;
  final String title;
  final String time;
  final bool active;
  final String startTime;
  final String companyName;
  final String employName;
  final String imageUrl;
  final double wage;
  final bool isAdmin;
  // final Timestamp date;
  final int totalSecondsPerSession;
  TimedEvent(
      {required this.id,
      required this.title,
      required this.time,
      required this.active,
      required this.startTime,
      required this.totalSecondsPerSession,
      required this.companyName,
      required this.employName,
      required this.wage,
      required this.isAdmin,
      required this.imageUrl
      // required this.date,
      });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'time': time,
        'active': active,
        'startTime': startTime,
        'totalSecondsPerSession': totalSecondsPerSession,
        'companyName': companyName,
        'employName': employName,
        'wage': wage,
        'isAdmin': isAdmin,
        'imageUrl': imageUrl,
        // 'date': event.date,
      };

  factory TimedEvent.fromJson(jsonData) {
    return TimedEvent(
      id: jsonData['id'],
      title: jsonData['title'],
      time: jsonData['time'],
      active: jsonData['active'],
      startTime: jsonData['startTime'],
      totalSecondsPerSession: jsonData['totalSecondsPerSession'],
      companyName: jsonData['companyName'],
      employName: jsonData['employName'],
      wage: jsonData['wage'],
      isAdmin: jsonData['isAdmin'],
      imageUrl: jsonData['imageUrl'],
      // date: jsonData['date'],
    );
  }

  TimedEvent copyWith(
      {String? title,
      bool? active,
      String? time,
      String? companyName,
      String? employName,
      Timestamp? date,
      bool? isAdmin,
      double? wage,
      String? imageUrl,
      int? totalSecondsPerSession}) {
    return TimedEvent(
      id: id,
      title: title ?? this.title,
      time: time ?? this.time,
      active: active ?? this.active,
      startTime: startTime,
      companyName: companyName ?? this.companyName,
      employName: employName ?? this.employName,
      wage: wage ?? this.wage,
      isAdmin: isAdmin ?? this.isAdmin,
      imageUrl: imageUrl ?? this.imageUrl,
      // date: date ?? this.date,
      totalSecondsPerSession:
          this.totalSecondsPerSession,
    );
  }

  factory TimedEvent.fromDocument(doc) {
    return TimedEvent(
      active: doc.data()["active"],
      id: doc.data()["id"],
      startTime: doc.data()["startTime"],
      time: doc.data()["time"],
      title: doc.data()["title"],
      companyName: doc.data()["companyName"],
      employName: doc.data()["employName"],
      totalSecondsPerSession: doc.data()["totalSecondsPerSession"],
      wage: doc.data()["wage"],
      isAdmin: doc.data()["isAdmin"],
      imageUrl: doc.data()["imageUrl"],
    );
  }
}
