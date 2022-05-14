import 'package:get_storage/get_storage.dart';
import 'package:salary_tracking_app/models/users.dart';

class UserLocalData {
  String s = 'sd';
  final getStorageProference = GetStorage();

  // Future init() async => _preferences = await SharedPreferences.getInstance();

  // Future<bool> logOut() => _preferences.clear();

  Future logOut() => getStorageProference.erase();
  final _userModelString = 'USERMODELSTRING';
  final _uidKey = 'UIDKEY';
  final _isLoggedIn = "ISLOGGEDIN";
  final _emailKey = 'EMAILKEY';
  final _nameKey = 'nameKEY';
  // final _phoneNumberKey = 'PhoneNumber';
  // final _imageUrlKey = 'IMAGEURLKEY';
  // final _password = 'PASSWORD';
  final _isAdmin = 'ISADMIN';
  final _notificationSet = 'NOTIFICATION';
  final _isAutoPlay = 'AUTOPLAY';
  final _token = 'TOKEN';
  final _events = 'EVENTS';

  //
  // Setters
  //

  Future set1stOpen() async {
    getStorageProference.write(_isAutoPlay, true);
    getStorageProference.write(_notificationSet, true);
  }

  Future setNotification(bool? notificationSet) async =>
      getStorageProference.write(_notificationSet, notificationSet);
  Future setIsAutoPlay(bool? isAutoPlay) async =>
      getStorageProference.write(_isAutoPlay, isAutoPlay);

  Future setUserModel(String userModel) async =>
      getStorageProference.write(_userModelString, userModel);
  Future setUserEmail(String? email) async =>
      getStorageProference.write(_emailKey, email);
  Future setname(String? name) async =>
      getStorageProference.write(_nameKey, name);
  Future setToken(String token) async =>
      getStorageProference.write(_token, token);

  Future setEvents(String events) async =>
      getStorageProference.write(_events, events);

  Future setIsAdmin(bool? isAdmin) async =>
      getStorageProference.write(_isAdmin, isAdmin);

  Future setUserUID(String? uid) async =>
      getStorageProference.write(_uidKey, uid);

  Future setNotLoggedIn() async =>
      getStorageProference.write(_isLoggedIn, false);

  Future setLoggedIn(bool isLoggedIn) async =>
      getStorageProference.write(_isLoggedIn, isLoggedIn);

  //
  // Getters
  //

  bool? getIsAutoPlay() => getStorageProference.read(_isAutoPlay);
  bool? getNotification() => getStorageProference.read(_notificationSet);

  bool? getIsAdmin() => getStorageProference.read(_isAdmin);
  String getUserData() => getStorageProference.read(_userModelString) ?? '';
  String getEvents() => getStorageProference.read(_events) ?? "";
  String getUserUIDGet() => getStorageProference.read(_uidKey) ?? '';
  bool? isLoggedIn() => getStorageProference.read(_uidKey);
  String getUserEmail() => getStorageProference.read(_emailKey) ?? '';
  String getname() => getStorageProference.read(_nameKey) ?? '';

  void storeAppUserData({required AppUserModel appUser, String token = ''}) {
    setUserUID(appUser.id!);
    setUserEmail(appUser.email!);
  }
}
