import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'EHR_First_Screen.dart';
import 'Health_Record_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/medical_history/PopBup_Menu_Three_Button_Functions_Screen.dart';
import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';
import 'package:flutter/material.dart';

import 'TabBar_View.dart';

class HealthRecord {
  final String diagnosisNumber;
  final String doctorName;
  final String hospitalName;
  final String date;
  final String timeline;
  late final String diagnosis;
  late final String summaryOfMedicalRecord;
  late final String prescribedDrugs;

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
      diagnosis: "Asthama",
      summaryOfMedicalRecord: "This Summary",
      prescribedDrugs: "Napa",
      doctorName: "Dr. John Doe",
      hospitalName: "ABC Hospital",
      date: "10/25/2023",
      timeline: "8:00 AM - 9:30 AM",
    );

    return Scaffold(
      body: HealthRecordDetailCard(record: record),
    );
  }
}




class HealthRecordDetailCard extends StatefulWidget {
  final HealthRecord record;

  HealthRecordDetailCard({required this.record});

  @override
  State<HealthRecordDetailCard> createState() => _HealthRecordDetailCardState();
}

class _HealthRecordDetailCardState extends State<HealthRecordDetailCard> {
  late User currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

  Future<void> addHealthRecordDetails() async {
    String userID = currentUser.uid;

    Map<String, dynamic> addDetails = {
      'diagnosis': widget.record.diagnosis,
      'summaryOfMedicalRecord': widget.record.summaryOfMedicalRecord,
      'prescribedDrugs': widget.record.prescribedDrugs,
    };


    //await _firestore.collection('users').doc(userID).collection('healthRecords').doc(widget.record.diagnosisNumber).set(addDetails);
    await _firestore.collection('users').doc(userID).collection('healthRecords').doc(widget.record.diagnosisNumber).update(addDetails);

  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 700,
          color: Color.fromRGBO(255, 255, 255, 1.0),
          margin: EdgeInsets.all(1.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDoctorInfo(widget.record.doctorName, widget.record.hospitalName),
              _buildDivider(),
              _buildEditableSection("Diagnosis", widget.record.diagnosis, (value) {
                setState(() {
                  widget.record.diagnosis = value;
                });
              }),
              //_buildDivider(),
              _buildEditableSection("Summary of the whole History", widget.record.summaryOfMedicalRecord, (value) {
                setState(() {
                  widget.record.summaryOfMedicalRecord = value;
                });
              }, textColor: Colors.black),
             // _buildDivider(),
              _buildEditableSection("Prescribed Medicine", widget.record.prescribedDrugs, (value) {
                setState(() {
                  widget.record.prescribedDrugs = value;
                });
              }),
              SizedBox(height: 20,),
              _buildDivider(),
              ElevatedButton(
                onPressed: () {
                  addHealthRecordDetails();
                },
                child: Text("SAVE"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditableSection(String title, String content, Function(String) onChanged, {Color textColor = Colors.black}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          maxLength: null,
          initialValue: content,
          onChanged: onChanged,
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
      child: Container(
        color: Color.fromRGBO(241, 229, 246, 1.0),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/doctor_avatar.png'),
                  radius: 30,
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.record.doctorName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.record.hospitalName,
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
