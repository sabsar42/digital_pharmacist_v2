import 'package:digi_pharma_app_test/OnBoard/OnBoard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dasboard/dasboard.dart';
import 'medical_history/Health_Record_Screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}
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
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromRGBO(3, 74, 166, 1.0)),
        useMaterial3: true,
      ),
      home: OnBoard(),
    );
  }
}
// monthlymed,uploadscreeprev,heatlhrecord,bardAi,