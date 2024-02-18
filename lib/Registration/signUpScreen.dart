import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/LogIn_UI/LoginPage.dart';
import 'package:digi_pharma_app_test/style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void showSnackBar(String message) {
    var snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(name);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'email': email,
        'full_name': name,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return LogInScreen();
        }),
      );
      showSnackBar('Registration Successfull');
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      print('FirebaseAuthException: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Registration Failed"),
            content: Text(e.message ?? "An error occurred."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1000,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 70, 320, 0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  color: Color.fromRGBO(13, 44, 82, 1.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(33, 80, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 50,
                    width: 50,
                    child: SvgPicture.asset(
                      'assets/images/digi-pharma-prussian.svg',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(33.0, 10, 30, 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text(
                        "Registration",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        ' In password section use combination of Lowercase, Uppercase, Number and Special characters',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
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
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Full Name',
                          floatingLabelStyle: TextStyle(
                            color: Color.fromRGBO(147, 18, 18, 1.0),
                          ),
                          hintText: '',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Eneter your First Name';
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
                          bool passwordRegex = RegExp(
                              r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$&*~]).{6,}$'
                          )
                              .hasMatch(value);
                          if (passwordRegex == false) {
                            return 'Enter Strong Password';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signUpWithEmailAndPassword(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            nameController.text.trim(),
                          );
                        }
                      },
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Register",
                              style: size20White(),
                            ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4.0,
                        backgroundColor: Color(0xff008081),
                        fixedSize: Size(355.0, 60.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Text(
                'Or Register with',
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
                      radius: 13.5,
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        "assets/images/google.png",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 14,
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
        ),
      ),
    );
  }
}
