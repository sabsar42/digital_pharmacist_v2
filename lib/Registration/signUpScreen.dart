import 'package:digi_pharma_app_test/LogIn_UI/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(name);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return LogInScreen();
        }),
      );
    } on FirebaseAuthException catch (e) {
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1000,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/270/270013.png",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Registration",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Please enter your email id, phone and your full name, then we will send you an OTP",
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(73, 73, 73, 1),
                            fontWeight: FontWeight.bold),
                        hintText: 'Enter your email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(73, 73, 73, 1),
                            fontWeight: FontWeight.bold),
                        labelText: 'Full name',
                        hintText: 'Enter your name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(73, 73, 73, 1),
                            fontWeight: FontWeight.bold),
                        hintText: 'Enter your secure password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      signUpWithEmailAndPassword(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        nameController.text.trim(),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10.0,
                      backgroundColor: Color.fromRGBO(19, 68, 130, 1.0),
                      fixedSize: Size(
                          350.0, 60.0), // Set the width and height as desired
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                child: Text(
                  'Or Continue with',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                alignment: Alignment.bottomCenter,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black12,
                          shape: BoxShape.rectangle,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                  "https://cdn-icons-png.flaticon.com/512/2504/2504739.png"),
                            ),
                            Text("Google"),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black12,
                          shape: BoxShape.rectangle,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                  "https://cdn-icons-png.flaticon.com/512/5968/5968764.png"),
                            ),
                            Text("Facebook"),
                          ],
                        )),
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
