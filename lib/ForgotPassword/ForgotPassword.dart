import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/Registration/signUpScreen.dart';

import 'Verification.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Forgot Password", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.arrow_back), color: Colors.blue,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            child: Text("Enter your Email Address", style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'email',
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
                  onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Verification();
                    }),
                  );},
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
                    fixedSize:
                    Size(350.0, 60.0),
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

