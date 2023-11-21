import 'package:digi_pharma_app_test/BloodGroup.dart';
import 'package:digi_pharma_app_test/ForgotPassword.dart';
import 'package:digi_pharma_app_test/LoginPage.dart';
import 'package:digi_pharma_app_test/UserProfile.dart';
import 'package:digi_pharma_app_test/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Age.dart';
import 'DashBoard.dart';
import 'OnBoard.dart';
////

void main(){
  runApp(MyApp());

}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Medicine App",
      home: OnBoard(),
      debugShowCheckedModeBanner: false,
    );
  }

}
