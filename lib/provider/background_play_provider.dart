import 'package:flutter/material.dart';
import 'package:salary_tracking_app/models/preferencesFile.dart';

class BackgroundPlayProvider with ChangeNotifier {
  BackgroundPlayPreferences backgroundPlayPreferences =
      BackgroundPlayPreferences();
  bool _setBackgroundPlay = true;
  bool get backgroundPlaySet => _setBackgroundPlay;

  set backgroundPlaySet(bool value) {
    _setBackgroundPlay = value;
    backgroundPlayPreferences.setBackgroundPlay(value);
    notifyListeners();
  }
}
