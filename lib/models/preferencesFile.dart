import 'package:get_storage/get_storage.dart';

class DarkThemePreferences {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    GetStorage prefs = GetStorage();
    prefs.write(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    GetStorage prefs = GetStorage();
    return prefs.read(
          THEME_STATUS,
        ) ??
        true;
  }
}

class NotificationPreferences {
  static const NOTIFICATION_STATUS = "Notification";

  setNotification(bool value) async {
    GetStorage prefs = GetStorage();
    prefs.write(NOTIFICATION_STATUS, value);
  }

  Future<bool> getNotification() async {
    GetStorage prefs = GetStorage();
    return prefs.read(
          NOTIFICATION_STATUS,
        ) ??
        true;
  }
}

class AutoPlayPreferences {
  static const AUTOPLAY_STATUS = "AUTOPLAY";

  setAutoPlay(bool value) async {
    GetStorage prefs = GetStorage();
    prefs.write(AUTOPLAY_STATUS, value);
  }

  Future<bool> getAutoPlay() async {
    GetStorage prefs = GetStorage();
    return prefs.read(
          AUTOPLAY_STATUS,
        ) ??
        true;
  }
}

class BackgroundPlayPreferences {
  static const BACKGROUND_PLAY = "BACKGROUND_PLAY";

  setBackgroundPlay(bool value) async {
    GetStorage prefs = GetStorage();
    prefs.write(BACKGROUND_PLAY, value);
  }

  Future<bool> getBackgroundPlay() async {
    GetStorage prefs = GetStorage();
    return prefs.read(
          BACKGROUND_PLAY,
        ) ??
        true;
  }
}
