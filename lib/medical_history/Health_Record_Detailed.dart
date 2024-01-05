import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HealthRecordDetailScreen extends StatefulWidget {
  HealthRecordDetailScreen({Key? key}) : super(key: key);

  @override
  State<HealthRecordDetailScreen> createState() => _HealthRecordDetailScreenState();
}

class _HealthRecordDetailScreenState extends State<HealthRecordDetailScreen> {
  late User currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _prescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    loadHealthRecordDetails();
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

  Future<void> loadHealthRecordDetails() async {
    String userID = currentUser.uid;

    try {
      var snapshot = await _firestore
          .collection('users')
          .doc(userID)
          .collection('healthRecords')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var latestRecord = snapshot.docs.first.data();
        setState(() {
          _diagnosisController.text = latestRecord['diagnosis'] ?? '';
          _summaryController.text = latestRecord['summaryOfMedicalRecord'] ?? '';
          _prescriptionController.text = latestRecord['prescribedDrugs'] ?? '';
        });
      }
    } catch (e) {
      print("Error loading health record details: $e");
    }
  }

  Future<void> addHealthRecordDetails() async {
    String userID = currentUser.uid;

    Map<String, dynamic> addDetails = {
      'diagnosis': _diagnosisController.text,
      'summaryOfMedicalRecord': _summaryController.text,
      'prescribedDrugs': _prescriptionController.text,
      'timestamp': FieldValue.serverTimestamp(),
    };

    // Use add to let Firestore generate a unique document ID
    await _firestore
        .collection('users')
        .doc(userID)
        .collection('healthRecords')
        .add(addDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Record Details'),
      ),
      body: ListView(
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
                _buildDoctorInfo('Shakib Absar', 'Khan'),
                _buildDivider(),
                _buildEditableSection("Diagnosis", _diagnosisController.text, (value) {
                  setState(() {
                    _diagnosisController.text = value;
                  });
                }),
                _buildDivider(),
                _buildEditableSection("Summary of the whole History", _summaryController.text, (value) {
                  setState(() {
                    _summaryController.text = value;
                  });
                }, textColor: Colors.black),
                _buildDivider(),
                _buildEditableSection("Prescribed Medicine", _prescriptionController.text, (value) {
                  setState(() {
                    _prescriptionController.text = value;
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
      ),
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
                      'Shakib Hospital',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Shakib Hospital',
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
