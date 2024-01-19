import 'package:flutter/material.dart';

void showSnackBar(String message, Duration duration, bool flag) {
  var snackbar = SnackBar(
    content: Text(message),
    duration: duration,
    backgroundColor: flag==false? Colors.red : Colors.green,
  );
}