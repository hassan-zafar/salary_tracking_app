import 'package:flutter/material.dart';

String logo = "assets/images/logo.png";

TextStyle titleTextStyle(
    {double fontSize = 25,
    Color color = Colors.black,
    required BuildContext context}) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.bodyText1!.color,
      letterSpacing: 1.8);
}

bool playInBackground = true;
bool downloadOnlyOverWifi = false;
