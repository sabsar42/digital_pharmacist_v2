import 'EHR_First_Screen.dart';
import 'Health_Record_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';
import 'package:flutter/material.dart';

import 'PDF_Screen.dart';

class BuildThreeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String c;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // Align buttons in the center horizontally
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            final String c = '1';
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HealthRecordDetailScreen(diagnosisNumberfromPrev: c),
              ),
            );
          },
          child: Text('Record'),
        ),
        ElevatedButton(
          onPressed: () {
            final String c = '1';
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EHRScreen(diagnosisNumberfromPrev: c),
              ),
            );
          },
          child: Text('EHR'),
        ),
        ElevatedButton(
          onPressed: () {
            final String c = '1';
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PDFViewerScreen(),
              ),
            );
          },
          child: Text('PDF'),
        ),
      ],
    );
  }

}