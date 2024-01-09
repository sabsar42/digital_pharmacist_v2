import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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


  DateTime _dateTime = DateTime.now();
  late String dateByUser = DateFormat('dd-MM-yyyy').format(_dateTime);
  late String timeByUser = DateFormat('HH-mm').format(_dateTime) ;
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
    String uniqueID = widget.diagnosisNumber;

    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('users')
          .doc(userID)
          .collection('healthRecords')
          .doc(uniqueID)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _diagnosisController.text = data['diagnosis'] ?? '';
          _summaryController.text = data['summaryOfMedicalRecord'] ?? '';
          _prescriptionController.text = data['prescribedDrugs'] ?? '';
          dateByUser = data['date'] ?? '';
          timeByUser = data['time'] ?? DateFormat('HH-mm').format(_dateTime);
        });
      }
    } catch (error) {
      print("Error loading health record data: $error");
    }
  }

  Future<void> addHealthRecordDetails() async {
    String userID = currentUser.uid;
    String uniqueID = widget.diagnosisNumber;

    CollectionReference<Map<String, dynamic>> healthRecordsCollection =
        FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('healthRecords');

    Map<String, dynamic> newRecord = {
      'diagnosis': uniqueID,
      'doctorName': 'Shakib Absar',
      'hospitalName': 'Shakib Khan Hospital',
      'diagnosis': _diagnosisController.text,
      'summaryOfMedicalRecord': _summaryController.text,
      'prescribedDrugs': _prescriptionController.text,
      'date': dateByUser,
      'time': timeByUser,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await healthRecordsCollection.doc(uniqueID).set(newRecord);
  }

  void _showDatePicker() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (date != null) {
      setState(() {
        _dateTime = DateTime(
          date.year,
          date.month,
          date.day,
          _dateTime.hour,
          _dateTime.minute,
        );
        dateByUser =  DateFormat('dd-MM-yyyy').format(_dateTime);
      });
    }
  }

  void _showTimePicker() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {

        _dateTime = DateTime(
          _dateTime.year,
          _dateTime.month,
          _dateTime.day,
          time.hour,
          time.minute,
        );
        timeByUser =  DateFormat('HH:mm').format(_dateTime);
      });
    }
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
                  SizedBox(height: 10.0),
                  Container(
                    child: Column(
                      children: [
                        Card(
                          color: Colors.teal.shade200,
                          child: ListTile(
                            title: RichText(
                              text: TextSpan(
                                text: 'DATE :  ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:  dateByUser ,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors
                                          .purple, // Set your desired color here
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.calendar_month,
                                color: Colors
                                    .purple, // Set your desired color here
                              ),
                              onPressed: _showDatePicker,
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.lightGreen.shade400,
                          child: ListTile(
                            title: RichText(
                              text: TextSpan(
                                text: 'TIME :  ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: timeByUser,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors
                                          .purple, // Set your desired color here
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.access_time,
                                color: Colors
                                    .purple, // Set your desired color here
                              ),
                              onPressed: _showTimePicker,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
}
