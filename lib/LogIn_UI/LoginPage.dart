import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/ForgotPassword/ForgotPassword.dart';
import 'package:digi_pharma_app_test/common_background.dart';
import 'package:digi_pharma_app_test/dasboard/dashboard.dart';
import 'package:digi_pharma_app_test/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/Registration/signUpScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';



class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  Future loginUser() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));
      showSnackBar("Login Successfull");
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Failed: $e");
      showSnackBar("Invalid email or password");
    }
  }

  void showSnackBar(String message) {
    var snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                  'WELCOME TO',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Text(
                  'DigiPharma',
                  style: TextStyle(
                    fontFamily: 'FontMain',
                    fontSize: 28,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(28, 10, 28, 10),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Email',
                            floatingLabelStyle: TextStyle(
                              color: Color.fromRGBO(147, 18, 18, 1.0),
                            ),
                            hintText: '',
                          ),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Eneter an email';
                            }

                            bool emailValid = RegExp(
                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                .hasMatch(value!);
                            if (emailValid == false) {
                              return 'Enter valid Email';
                            }

                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(28, 10, 28, 10),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Passwords',
                            floatingLabelStyle: TextStyle(
                              color: Color.fromRGBO(147, 18, 18, 1.0),
                            ),
                            hintText: '',
                          ),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Eneter a Password';
                            }
                            if (value!.length < 6) {
                              return 'Enter Password more than 6 letters';
                            }
                         //    bool passwordRegex =
                         //    RegExp(r'^(?!.*(.).*\1)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$&*~]).{6,}$')
                         // .hasMatch(value);
                         //    if(passwordRegex==false){
                         //      return 'Enter Strong Password';
                         //    }

                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
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
                                  color: Color.fromRGBO(131, 136, 138, 1.0),
                                  fontSize: 11.1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              loginUser();
                            }
                          },
                          child: isLoading
                              ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            "Sign In",
                            style: size20White(),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 4.0,
                            backgroundColor: Color(0xff008081),
                            fixedSize: Size(350.0,
                                60.0), // Set the width and height as desired
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
                              style: TextStyle(
                                color: Colors.teal.shade600,
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Or continue with',
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
                              radius: 13.7,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                "assets/images/google.png",
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
                              radius: 15.3,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                "assets/images/facebook.png",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
