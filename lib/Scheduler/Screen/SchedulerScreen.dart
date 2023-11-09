import 'package:digi_pharma_app_test/Scheduler/SchedulerAppBar.dart';
import 'package:flutter/material.dart';

import '../../dashboard/dashbaord_appbar.dart';

class SchedulerScreen extends StatefulWidget {
  const SchedulerScreen({super.key});

  @override
  State<SchedulerScreen> createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends State<SchedulerScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   appBar: AppBar(

      toolbarHeight: 200,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: SchedulerAppBar(),
    ),


    );
  }
}
