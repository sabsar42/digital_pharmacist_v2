import 'EHR_First_Screen.dart';
import 'Health_Record_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/medical_history/Three_Button_Functions_Screen.dart';
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
      appBar: AppBar(
        toolbarHeight: 45,
        elevation: 20.0,
        backgroundColor: Color.fromRGBO(236, 220, 248, 1.0),
        title: Text(
          '$diagnosisNumberfromPrev - Health Record',
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

      body: HealthRecordDetailCard(record: record),

    );
  }
}
class HealthRecordDetailCard extends StatelessWidget {
  final HealthRecord record;
  final customColor = Color.fromRGBO(99, 174, 232, 1.0);

  HealthRecordDetailCard({required this.record});

  @override
  Widget build(BuildContext context) {

    return ListView(

      children: [

        Container(

          height: 700,
          color: Color.fromRGBO(241, 229, 220, 1.0),
          margin: EdgeInsets.all(1.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              _buildDoctorInfo(record.doctorName, record.hospitalName),
              _buildDivider(),
              _buildSection("Diagnosis", record.diagnosis),
              _buildDivider(),
              _buildSection("Summary of the whole History", record.summaryOfMedicalRecord, textColor: Colors.black),
              _buildDivider(),
              _buildSection("Prescribed Medicine", record.prescribedDrugs),


            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, String content, {Color textColor = Colors.black}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color:Colors.black
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          content,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.black,
      thickness: 1.0,
    );
  }

  Widget _buildDoctorInfo(String doctorName, String hospitalName) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
      child : Container(
      color:Color.fromRGBO(65, 33, 1, 0.18823529411764706),
      padding: EdgeInsets.all(20),
      child: Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/doctor_avatar.png'),
              radius: 30,
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.doctorName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  record.hospitalName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'Hospital: $hospitalName',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    ),
    ),
    );
  }
}
