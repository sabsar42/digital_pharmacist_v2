import 'package:digi_pharma_app_test/SignUpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        toolbarHeight: 180.0, // Increase the height of the AppBar
        title: Container(
          padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
          child: SizedBox(
            width: 180.0, // Set the width
            height: 180.0, // Set the height
            child: Align(
              alignment: Alignment.center,
              child: Image.asset('assets/images/logo-one.jpeg'),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'User Name',
                floatingLabelStyle: TextStyle(
                  color: Color.fromRGBO(147, 18, 18, 1.0),
                ),
                hintText: 'Enter username',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'Password',
                hintText: 'Enter your secure password',
                floatingLabelStyle: TextStyle(
                  color: Color.fromRGBO(147, 18, 18, 1.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Add some spacing between text fields and button
          ElevatedButton(
            onPressed: () {
              // Add your login logic he
            },
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 10.0,
              backgroundColor: Color.fromRGBO(3, 74, 166, 1.0),
              fixedSize:
                  Size(200.0, 60.0), // Set the width and height as desired
            ),
          ),
          SizedBox(height: 50),
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return  SignUpScreen();
                  }),
                );
              },
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }
}
