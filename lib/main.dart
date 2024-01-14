import 'package:digi_pharma_app_test/OnBoard/first_Onboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dasboard/dashboard.dart';
import 'medical_history/Health Record/screens/Health_Record_Screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
        primaryColor:  Colors.deepPurple,
        primarySwatch: Colors.deepPurple,
       // colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(3, 74, 166, 1.0)),
        useMaterial3: true,
      ),
      home: OnBoard(),
    );
  }
}
// monthlymed,uploadscreeprev,heatlhrecord,bardAi,