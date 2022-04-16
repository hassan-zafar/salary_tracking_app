import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salary_tracking_app/models/users.dart';

final userRef = FirebaseFirestore.instance.collection('users');
final commentsRef = FirebaseFirestore.instance.collection('comments');
final chatRoomRef = FirebaseFirestore.instance.collection('chatRoom');
final chatListRef = FirebaseFirestore.instance.collection('chatLists');
final calenderRef = FirebaseFirestore.instance.collection('calenderMeetings');
final activityFeedRef = FirebaseFirestore.instance.collection('activityFeed');
final employeeTimeRef = FirebaseFirestore.instance.collection('employeeTime');

AppUserModel? currentUser;
String ?uid;
bool? isAdmin;
bool? isNotificationSetGlobal;
bool? isAutoPlayGlobal;
