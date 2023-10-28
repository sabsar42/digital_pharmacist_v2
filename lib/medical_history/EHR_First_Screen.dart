import 'Health_Record_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'EHR_First_Screen.dart';
import 'Health_Record_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';
import 'package:flutter/material.dart';

import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';
import 'package:flutter/material.dart';

import 'Three_Button_Functions_Screen.dart';

class EHRScreen extends StatelessWidget {

  final String diagnosisNumberfromPrev;
  EHRScreen({required this.diagnosisNumberfromPrev});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        elevation: 20.0,
        backgroundColor: Color.fromRGBO(236, 220, 248, 1.0),
        title: Text(
          'EHR Health Record',
          style: TextStyle(
            fontSize: 22,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(38.0), // Adjust the height as needed
          child: BuildThreeButton(),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        children: <Widget>[
          _buildEHRFolder("Folder 1"),
          _buildEHRFolder("Folder 2"),
          _buildEHRFolder("Folder 3"),
          _buildEHRFolder("Folder 4"),
        ],
      ),
    );
  }

  Widget _buildEHRFolder(String folderName) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(16.0),

      child: InkWell(
        onTap: () {

        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.folder,
              size: 80.0,
              color: Colors.blue,
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
    );
  }
}
