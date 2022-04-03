import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void successToast({
  required String message,
  int duration = 3,
}) {
  BotToast.showText(
    text: message,
    backgroundColor: Colors.green,
  );
}

void showToast({
  required String message,
  int duration = 3,
}) {
  BotToast.showText(
    text: message,
    backgroundColor: Colors.green,
  );
}

void errorToast({
  required String message,
  int duration = 4,
}) {
  BotToast.showText(text: message);
}
