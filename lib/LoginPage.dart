import 'package:digi_pharma_app_test/ForgotPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/signUpScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,  //
            children: [
              Padding(

                padding: const EdgeInsets.only(top:90),
                child: SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                        'assets/images/digi-pharma-prussian.svg'),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text('Welcome',style: TextStyle(fontFamily:'FontMain',fontSize: 30, fontWeight: FontWeight.bold),),
              Text('to MedApp',style: TextStyle(fontFamily:'FontMain',fontSize: 28, fontWeight: FontWeight.w100),),
              SizedBox(height: 20,) ,
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextField(
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
                            'forgot password?',
                            style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
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
                        elevation: 10.0,
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
                      Text('New user?'),
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
                          'Sign Up',
                          style: TextStyle(color: Colors.blue),
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
                          backgroundColor: Colors.white,
                          child: Image.network(
                            "https://cdn-teams-slug.flaticon.com/google.jpg",
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Image.network(
                                "https://cdn-icons-png.flaticon.com/512/5968/5968764.png")),
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