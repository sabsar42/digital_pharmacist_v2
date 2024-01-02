import 'package:digi_pharma_app_test/LogIn_UI/Auth_Page.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/LogIn_UI/LoginPage.dart';

class TypeOfAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
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
          SizedBox(height: 20),
          buildAccountCard(
            context,
            title: 'I am a Patient',
            description:
            'Find doctors, access medical records, and get medicine delivery',
            imageUrl:
            'https://cdn-icons-png.flaticon.com/512/1430/1430453.png',
          ),
          SizedBox(height: 20),
          buildAccountCard(
            context,
            title: 'I am a Doctor',
            description: 'The easiest way to reach your patients',
            imageUrl:
            'https://cdn-icons-png.flaticon.com/512/3774/3774299.png',
          ),
        ],
      ),
    );
  }

  @override
  Widget buildAccountCard(BuildContext context,{
    required String title,
    required String description,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return AuthPage();
            }),
          );
        },

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
                  child: Image.network(imageUrl),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
