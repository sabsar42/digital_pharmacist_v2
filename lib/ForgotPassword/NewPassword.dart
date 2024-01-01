import 'package:digi_pharma_app_test/LogIn_UI/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/Registration/signUpScreen.dart';

import 'Verification.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Change your Password",
          style: TextStyle(color: Colors.black),
        ),
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
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'New password',
                floatingLabelStyle: TextStyle(
                  color: Color.fromRGBO(147, 18, 18, 1.0),
                ),
                hintText: '',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'Confirm Password',
                floatingLabelStyle: TextStyle(
                  color: Color.fromRGBO(147, 18, 18, 1.0),
                ),
                hintText: '',
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return LogInScreen();
                      }),
                    );
                  },
                  child: Text(
                    'Continue',
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
                    fixedSize: Size(350.0, 60.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
