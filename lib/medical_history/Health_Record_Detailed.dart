import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HealthRecordDetailScreen extends StatefulWidget {
  final String diagnosisNumber;

  HealthRecordDetailScreen({Key? key, required this.diagnosisNumber});

  @override
  State<HealthRecordDetailScreen> createState() =>
      _HealthRecordDetailScreenState();
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
    loadHealthRecordData();
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
      loadHealthRecordData();
    }
  }

  Future<void> loadHealthRecordData() async {
    String userID = currentUser.uid;
    String uniqueDiagnosisNumber = widget.diagnosisNumber;

   // String uniqueID = '$userID+$uniqueDiagnosisNumber';
    String uniqueID = widget.diagnosisNumber;;

    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('users')
          .doc(userID)
          .collection('healthRecords')
          .doc(uniqueID)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _diagnosisController.text = data['diagnosis'] ?? '';
          _summaryController.text = data['summaryOfMedicalRecord'] ?? '';
          _prescriptionController.text = data['prescribedDrugs'] ?? '';
        });
      }
    } catch (error) {
      print("Error loading health record data: $error");
    }
  }



  Future<void> addHealthRecordDetails() async {
    String userID = currentUser.uid;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(userID)
        .collection('healthRecords')
        .get();
    int uniqueDiagnosisNumber = querySnapshot.size;

    //String uniqueID = '$userID+${uniqueDiagnosisNumber.toString()}';
    String uniqueID =  widget.diagnosisNumber;


    CollectionReference<Map<String, dynamic>> healthRecordsCollection =
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('healthRecords');

    Map<String, dynamic> newRecord = {
      'diagnosis': uniqueID,
      'doctorName': _buildDoctorInfo('doctorName', 'ospitalName'),
      'hospitalName': 'New Hospital',
      'diagnosis': _diagnosisController.text,
      'summaryOfMedicalRecord': _summaryController.text,
      'prescribedDrugs': _prescriptionController.text,
      'timestamp': FieldValue.serverTimestamp(),

    };

    await healthRecordsCollection.doc(uniqueID).set(newRecord);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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

                  SizedBox(height: 30.0),
                  Text(
                    "Diagnosis",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    maxLines: null,
                    controller: _diagnosisController,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  //  _buildDivider(),
                  Text(
                    "Summary of the whole History",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    maxLines: null,
                    controller: _summaryController,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  //    _buildDivider(),
                  Text(
                    "Prescribed Medicine",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    maxLines: null,
                    controller: _prescriptionController,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  // _buildDivider(),
                  ElevatedButton(
                    onPressed: () {
                      addHealthRecordDetails();
                    },
                    child: Text("SAVE"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
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
                  backgroundImage: AssetImage('assets/images/doctor.png'),
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
