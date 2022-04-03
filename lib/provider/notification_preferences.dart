import 'package:flutter/material.dart';
import 'package:salary_tracking_app/models/preferencesFile.dart';

class NotificationSetProvider with ChangeNotifier {
  NotificationPreferences notificationPreferences = NotificationPreferences();
  bool _setNotification = true;
  bool get notificationSet => _setNotification;

  set notificationSet(bool value) {
    _setNotification = value;
    notificationPreferences.setNotification(value);
    notifyListeners();
  }
}
