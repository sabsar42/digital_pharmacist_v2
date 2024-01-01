import 'package:digi_pharma_app_test/Registration/BloodGroup.dart';
import 'package:digi_pharma_app_test/ForgotPassword/ForgotPassword.dart';
import 'package:digi_pharma_app_test/LogIn_UI/LoginPage.dart';
import 'package:digi_pharma_app_test/User_Profile/UserProfile.dart';
import 'package:digi_pharma_app_test/Registration/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Registration/Age.dart';
import 'DashBoard.dart';
import 'OnBoard/OnBoard.dart';
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
