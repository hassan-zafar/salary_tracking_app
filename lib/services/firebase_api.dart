import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:salary_tracking_app/consts/collections.dart';
import 'package:salary_tracking_app/models/employeeTimeModel.dart';
import 'package:salary_tracking_app/models/firebase_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salary_tracking_app/models/users.dart';
import 'package:salary_tracking_app/widgets/custom_toast.dart';
import 'package:uuid/uuid.dart';

import '../widgets/custom_toast copy.dart';

class FirebaseApi {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }



  submitEmployeeTime(
      String startTime, String endTime, DateTime seletedDay,int totalTime) async
      
       {
    try {
      employeeTimeRef
          .doc('${seletedDay.day}-${seletedDay.month}-${seletedDay.year}')
          .collection('employeeDayData')
          .doc(currentUser!.id)
          .set({
        'startTime': startTime,
        'uid': currentUser!.id,
        'endTime': endTime,
        'employeeId': currentUser!.id,
        'companyName': currentUser!.companyName,
        'employeeName': '${currentUser!.name}',
        'totalTime': totalTime,
        'wage': currentUser!.wage,
        'date': '${seletedDay.day}-${seletedDay.month}-${seletedDay.year}',
        'timeStamp': Timestamp.now(),
      }).then((value) => CustomToast.successToast(
              message: 'Time Submitted Successfully', duration: 2));
    } on FirebaseException catch (e) {
      CustomToast.errorToast(message: e.message.toString());
    }
  }

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();
    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  static Future downloadFile(
      {required String fileName,
      // required
      String? path}) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    print(appDocDir.path);
    File downloadToFile = File('${appDocDir.path}/$fileName.mp4');
    path = 'videos/Movement/tesitng 1';
    try {
      TaskSnapshot downloadTask =
          await FirebaseStorage.instance.ref(path).writeToFile(downloadToFile);
      print(downloadTask.state);
      print(downloadToFile.path);
    } on FirebaseException catch (e) {
      print(e);
      // e.g, e.code == 'canceled'
    }
    //   final dir = await getApplicationDocumentsDirectory();
    //   final file = File('${dir.path}/${ref.name}');
    //   print(file.path);
    //   await ref.writeToFile(file).then((p0) {
    //     print(p0.totalBytes);
    //     print(p0.state);
    //     print(p0.bytesTransferred);
    //   });
    // }
  }
}
