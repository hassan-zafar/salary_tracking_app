import 'dart:convert';
class AppUserModel {
  final String? id;
  final String? name;
  final String? phoneNo;
  final String? password;
  final String? timestamp;
  final String? imageUrl;
  final bool? isAdmin;
  final String? email;
  final String? androidNotificationToken;
  final String? subscriptionEndTIme;
  final String? companyName;
  final String? jobTitle;
  final String? wage;

  AppUserModel(
      {this.id,
      this.name,
      this.phoneNo,
      this.password,
      this.imageUrl,
      this.timestamp,
      this.isAdmin,
      this.subscriptionEndTIme,
      this.email,
      this.androidNotificationToken,
      this.wage,
      this.companyName,
      this.jobTitle});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNo': phoneNo,
      'password': password,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
      'subscriptionEndTIme': subscriptionEndTIme,
      'isAdmin': isAdmin,
      'companyName': companyName,
      'wage': wage,
      'email': email,
      'androidNotificationToken': androidNotificationToken,
      'jobTitle': jobTitle
    };
  }

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
        id: map['id'],
        name: map['name'],
        phoneNo: map['phoneNo'],
        password: map['password'],
        timestamp: map['timestamp'],
        imageUrl: map['imageUrl'],
        isAdmin: map['isAdmin'],
        subscriptionEndTIme: map['subscriptionEndTIme'],
        wage: map['wage'],
        companyName: map['companyName'],
        email: map['email'],
        androidNotificationToken: map['androidNotificationToken'],
        jobTitle: map['jobTitle']);

  }

  factory AppUserModel.fromDocument(doc) {
    return AppUserModel(
      id: doc.data()["id"],
      password: doc.data()["password"],
      name: doc.data()["name"],
      timestamp: doc.data()["timestamp"],
      imageUrl: doc.data()["imageUrl"],
      email: doc.data()["email"],
      isAdmin: doc.data()["isAdmin"],
      subscriptionEndTIme: doc.data()["subscriptionEndTIme"],
      phoneNo: doc.data()["phoneNo"],
      androidNotificationToken: doc.data()["androidNotificationToken"],
      companyName: doc.data()["companyName"],
      wage: doc.data()["wage"],
      jobTitle: doc.data()["jobTitle"],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUserModel.fromJson(String source) =>
      AppUserModel.fromMap(json.decode(source));
}
