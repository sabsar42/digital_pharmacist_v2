
import 'package:firebase_auth/firebase_auth.dart';

import '../widget/PopBup_Menu_Three_Button_Functions_Screen.dart';
import 'EHR_Detailed_View.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'EHR_First_Screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:digi_pharma_app_test/medical_history/Health%20Record/screens/Health_Record_Detailed.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/medical_history/Health%20Record/screens/Health_Record_Detailed.dart';
import 'package:flutter/material.dart';


class EHRScreen extends StatefulWidget {
  final String diagnosisNumberfromPrev;

  EHRScreen({required this.diagnosisNumberfromPrev});

  @override
  State<EHRScreen> createState() => _EHRScreenState();
}

class _EHRScreenState extends State<EHRScreen> {






  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
          crossAxisCount: 2, // Number of columns in the grid
          children: <Widget>[
            _buildEHRFolder(context, "Blood"),
            _buildEHRFolder(context, "X-ray"),
            _buildEHRFolder(context, "Medication"),
            _buildEHRFolder(context, "Diagnostic Report"),
            _buildEHRFolder(context, "Urine Report"),
            _buildEHRFolder(context, "Diabetics Report"),
            _buildEHRFolder(context, "SonoGram Report"),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          backgroundColor: Colors.purple.shade300,
          child: Container(
            width: 100,
            child: Icon(Icons.upload_outlined, size: 30, color: Colors.white),
          ),
        )

    );
  }

  Widget _buildEHRFolder(BuildContext context, String folderName) {
    return Card(
      color: Color.fromRGBO(250, 248, 255, 1.0),
      elevation: 6.0,
      shadowColor: Color.fromRGBO(199, 126, 252, 1.0),
      margin: EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EHRArticleDetailScreen(folderName: folderName),
            ),
          );
        },
        child: Stack(
          children: [
            const Positioned(
                top: 9.0,
                right: 5.0,
                child: Row(
                  children: [
                    PopUpMenuThreeButton(), // Create an instance and include it
                  ],
                )),
            Positioned(
              left: 1.0,
              right: 1.0,
              top: 1.0,
              bottom: 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.folder,
                    size: 80.0,
                    color: Color.fromRGBO(58, 109, 180, 0.7215686274509804),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    folderName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
