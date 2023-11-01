import 'package:digi_pharma_app_test/BloodGroup.dart';
import 'package:digi_pharma_app_test/ForgotPassword.dart';
import 'package:digi_pharma_app_test/LoginPage.dart';
import 'package:flutter/material.dart';

import 'Age.dart';
import 'OnBoard.dart';


void main(){
  runApp(MyApp());

}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Medicine App",
      home: LogInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

}
//