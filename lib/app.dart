import 'package:digi_pharma_app_test/OnBoard/first_Onboard.dart';
import 'package:flutter/material.dart';
import 'controller_bindings.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get/get.dart';

class DigiPharmaApp extends StatelessWidget {
  const DigiPharmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      initialBinding: ControllerBinder(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        primarySwatch: Colors.deepPurple,
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromRGBO(3, 74, 166, 1.0)),
        useMaterial3: true,
      ),
      home: OnBoard(),
    );
  }
}
// monthlymed,uploadscreeprev,heatlhrecord,bardAi,
