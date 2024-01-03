import 'package:digi_pharma_app_test/ForgotPassword/ForgotPassword.dart';
import 'package:digi_pharma_app_test/dasboard/dasboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/Registration/signUpScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digi_pharma_app_test/OnBoard/OnBoard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:digi_pharma_app_test/ForgotPassword/ForgotPassword.dart';
import 'package:digi_pharma_app_test/dasboard/dasboard.dart';
import 'package:digi_pharma_app_test/Registration/signUpScreen.dart';

import 'LoginPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return DashboardScreen();
          }

          // user is NOT logged in
          else {
            return LogInScreen();
          }
        },
      ),
    );
  }
}
