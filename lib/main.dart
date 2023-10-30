import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dasboard/dasboard.dart';
import 'medical_history/Health_Record_Screen.dart';
import 'signUp_logIn/LogInScreen.dart';
import 'package:device_preview/device_preview.dart';

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:Color.fromRGBO(3, 74, 166, 1.0)),
        useMaterial3: true,
      ),
      home:  DashboardScreen(),
    );
  }
}


