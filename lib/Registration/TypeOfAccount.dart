import 'package:digi_pharma_app_test/LogIn_UI/Auth_Page.dart';
import 'package:digi_pharma_app_test/common_background.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/LogIn_UI/LoginPage.dart';

class TypeOfAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Color.fromRGBO(
              12, 57, 93, 1.0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CommonBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Type of Account",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Choose the type of your account',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 90),
            buildAccountCard(
              context,
              title: 'I am a Patient',
              description:
                  'Find Medicine, access Medical records, schedule medicine reminders',
              imageUrl: 'assets/images/patient.png',
            ),
            SizedBox(height: 20),
            buildAccountCard(
              context,
              title: 'I am a Doctor',
              description: 'The easiest way to reach your patients',
              imageUrl: 'assets/images/doctor.png',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildAccountCard(
    BuildContext context, {
    required String title,
    required String description,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return AuthPage();
            }),
          );
        },
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        splashColor: Color.fromRGBO(110, 10, 161, 1.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 90,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 40,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: Image.asset(imageUrl),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
