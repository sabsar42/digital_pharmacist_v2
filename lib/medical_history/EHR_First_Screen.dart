import 'EHR_Detailed_View.dart';
import 'Health_Record_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'EHR_First_Screen.dart';
import 'Health_Record_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';
import 'package:flutter/material.dart';
import 'PopBup_Menu_Three_Button_Functions_Screen.dart';


class EHRScreen extends StatelessWidget {
  final String diagnosisNumberfromPrev;

  EHRScreen({required this.diagnosisNumberfromPrev});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 45,
      //   elevation: 20.0,
      //   backgroundColor: Color.fromRGBO(236, 220, 248, 1.0),
      //   title: Text(
      //     'EHR Health Record',
      //     style: TextStyle(
      //       fontSize: 22,
      //       color: Colors.deepPurple,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(38.0), // Adjust the height as needed
      //     child: BuildThreeButton(),
      //   ),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(15),
      //       bottomRight: Radius.circular(15),
      //     ),
      //   ),
      // ),


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
                )
            ),
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
