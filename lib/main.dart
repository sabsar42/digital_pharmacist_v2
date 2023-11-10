import 'package:digi_pharma_app_test/Scheduler/Screen/SchedulerScreen.dart';
import 'package:digi_pharma_app_test/Scheduler/Screen/SchedulerSettingsScreen.dart';
import 'package:digi_pharma_app_test/dashboard/dashbaord_appbar.dart';

import 'dashboard/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
