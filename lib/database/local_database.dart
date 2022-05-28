import 'package:shared_preferences/shared_preferences.dart';

class UserLocalData {
  String s = 'sd';
  SharedPreferences? _preferences;

  Future init() async => _preferences = await SharedPreferences.getInstance();

  Future<bool> logOut() => _preferences!.clear();

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
  final _activeEvents = 'ACTIVEEVENTS';

  //
  // Setters
  //

  Future set1stOpen() async {
    _preferences!.setBool(_isAutoPlay, true);
    _preferences!.setBool(_notificationSet, true);
  }


  Future setEvents(String events) async =>
      _preferences!.setString(_events, events);



  Future setActiveEvent(String activeEvents) async =>
      _preferences!.setString(_activeEvents, activeEvents);

  //
  // Getters
  //

  String getEvents() => _preferences!.getString(_events) ?? "";
  String getActiveEvent() => _preferences!.getString(_activeEvents) ?? "";

  // void storeAppUserData({required AppUserModel appUser, String token = ''}) {
  //   setUserUID(appUser.id!);
  //   setUserEmail(appUser.email!);
  // }
}
