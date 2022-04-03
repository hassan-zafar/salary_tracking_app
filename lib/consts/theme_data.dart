import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme ? Color(0xFF1E2429) : Colors.white,
      primaryColor: isDarkTheme ? Colors.black
       : Color(0xffC28A6C),
      accentColor: Color(0xffC28A6C),
      backgroundColor: isDarkTheme ? Colors.grey.shade700 : Colors.white,
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      hintColor: isDarkTheme ? Colors.grey.shade300 : Colors.grey.shade800,
      // highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Color(0xffC28A6C),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      dividerColor: isDarkTheme ? Colors.white : Colors.black,
      textTheme: TextTheme(
          bodyText1:
              TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(elevation: 0.0, color: Color(0xffC28A6C)),
    );
  }
}
