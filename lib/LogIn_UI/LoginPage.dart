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

import '../style.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
      print("Successs");

    }).onError((error, stackTrace) {
      print("Failed");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/digi-pharma-prussian.svg',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Welcome',
                style: TextStyle(
                  fontFamily: 'FontMain',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'to MedApp',
                style: TextStyle(
                  fontFamily: 'FontMain',
                  fontSize: 28,
                  fontWeight: FontWeight.w100,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'username/email',
                        floatingLabelStyle: TextStyle(
                          color: Color.fromRGBO(147, 18, 18, 1.0),
                        ),
                        hintText: '',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Password',
                        hintText: '',
                        floatingLabelStyle: TextStyle(
                          color: Color.fromRGBO(147, 18, 18, 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ForgotPassword();
                            }),
                          );
                        },
                        child: const Text(
                          'FORGOT PASSWORD ?',
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 13
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(

                      onPressed: () {
                        loginUser();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4.0,
                        backgroundColor: Color.fromRGBO(19, 68, 130, 1.0),
                        fixedSize: Size(
                            350.0, 60.0), // Set the width and height as desired
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('NEW USER ?',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      )),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SignUpScreen();
                            }),
                          );
                        },
                        child: Text(
                          'Regsiter Here',
                          style: TextStyle(color: Colors.blue,
                            fontWeight: FontWeight.normal,
                            fontSize: 13,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Or Continue with',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.transparent,
                          child: Image.network(
                            "https://cdn-teams-slug.flaticon.com/google.jpg",
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.transparent,
                          child: Image.network(
                            "https://cdn-icons-png.flaticon.com/512/5968/5968764.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
