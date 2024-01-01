import 'package:flutter/material.dart';

class EHRArticleDetailScreen extends StatelessWidget {
  final String folderName;

  EHRArticleDetailScreen({required this.folderName});

  @override
  Widget build(BuildContext context) {
    // Dummy data for the report analysis, numbers, and diagnosis values
    final String reportAnalysis = 'This is a sample report analysis.';
    final int patientAge = 35;
    final double cholesterolLevel = 170.5;
    final String diagnosis = 'Hypertension';



    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            color: Color.fromRGBO(124, 67, 166, 1.0),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('EHR Detail',
        style: TextStyle(
          color: Color.fromRGBO(124, 67, 166, 1.0),
        )
        ),
        backgroundColor: Color.fromRGBO(236, 220, 248, 1.0),
         ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.folder,
                  size: 80.0,
                  color:  Color.fromRGBO(37, 83, 147, 0.7215686274509804),
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
          SizedBox(height: 20.0),
          Text(
            'Report Analysis:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            reportAnalysis,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Patient Information:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Age: $patientAge years',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Text(
            'Cholesterol Level: $cholesterolLevel mg/dL',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Text(
            'Diagnosis: $diagnosis',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
