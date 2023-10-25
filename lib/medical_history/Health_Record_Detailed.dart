import 'Health_Record_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';
import 'package:flutter/material.dart';

class HealthRecord {
  final String diagnosisNumber;
  final String doctorName;
  final String hospitalName;
  final String date;
  final String timeline;
  final String diagnosis;
  final String summaryOfMedicalRecord;
  final String prescribedDrugs;

  HealthRecord({
    required this.diagnosisNumber,
    required this.diagnosis,
    required this.summaryOfMedicalRecord,
    required this.doctorName,
    required this.hospitalName,
    required this.date,
    required this.timeline,
    required this.prescribedDrugs,
  });
}

class HealthRecordDetailScreen extends StatelessWidget {

  final String diagnosisNumberfromPrev;
  HealthRecordDetailScreen({required this.diagnosisNumberfromPrev});


  @override
  Widget build(BuildContext context) {

    final record = HealthRecord(
      diagnosisNumber: "D12345",
      diagnosis : "Asthama",
      summaryOfMedicalRecord : "This Summary",
      prescribedDrugs : "Napa",
      doctorName: "Dr. John Doe",
      hospitalName: "ABC Hospital",
      date: "10/25/2023",
      timeline: "8:00 AM - 9:30 AM",
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
          child: AppBar(

            elevation: 10,
            backgroundColor: Color.fromRGBO(236, 220, 248, 1.0),
            title: Text(
              '$diagnosisNumberfromPrev Health Records',
              style: TextStyle(
                fontSize: 24,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: HealthRecordDetailCard(record: record),
        ),
      ),
    );
  }
}

class HealthRecordDetailCard extends StatelessWidget {
  final HealthRecord record;
  final customColor = Color.fromRGBO(239, 207, 170, 1.0);
  HealthRecordDetailCard({required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: customColor,
      margin: EdgeInsets.all(0.0),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        height: 700,
        width : 600,
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Diagnosis',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              record.diagnosis,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Summary of Medical Record',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              record.summaryOfMedicalRecord,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Prescribed Drugs',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox (height: 8.0),
            Text(
              record.prescribedDrugs,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Dr. ${record.doctorName}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8.0),
                Icon(
                  Icons.link,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
