import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Health Record/patientDataFlow.dart';
import '../Scheduler/widget/settingsDropdown.dart';
import 'Widget/doctor_information.dart';
import 'Widget/med_information_card.dart';
import 'Widget/my_custom_dropdown.dart';

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
  final TextEditingController prescribedMedicineController = TextEditingController();
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _hospitalNameController = TextEditingController();
  final TextEditingController _diagnosisTypeController =
      TextEditingController();

  DateTime _dateTime = DateTime.now();
  late String dateByUser = '';
  late String timeByUser = '';

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
          prescribedMedicineController.text = data['prescribedDrugs'] ?? '';
          _diagnosisTypeController.text = data['diagnosisType'] ?? '';
          _doctorNameController.text = data['doctorName'] ?? '';
          _specializationController.text = data['doctor_specialization'] ?? '';
          _hospitalNameController.text = data['hospitalName'] ?? '';
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
      'diagnosisNumber': uniqueID,
      'doctorName': _doctorNameController.text,
      'doctor_specialization': _specializationController.text,
      'hospitalName': _hospitalNameController.text,
      'diagnosis': _diagnosisController.text,
      'summaryOfMedicalRecord': _summaryController.text,
      'prescribedDrugs': prescribedMedicineController.text,
      'diagnosisType': _diagnosisTypeController.text,
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
        dateByUser = DateFormat('dd-MM-yyyy').format(_dateTime);
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
        timeByUser = DateFormat('HH:mm').format(_dateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              DateTimebyUser,
              diagnosisTypeDropDown(),
              SizedBox(height: 1.0),
              DoctorHospitalInformation(
                  doctorNameController: _doctorNameController,
                  specializationController: _specializationController,
                  hospitalNameController: _hospitalNameController),
              MedInfoCard(
                diagnosisController: _diagnosisController,
                title: 'DIAGNOSIS',
              ), MedInfoCard(
                diagnosisController: prescribedMedicineController,
                title: 'Medicines',
              ), MedInfoCard(
                diagnosisController: _summaryController,
                title: 'Summary of Diagnosis',
              ),
              SizedBox(height: 16.0),

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
      ),
    );
  }

  Padding diagnosisTypeDropDown() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 70, // Adjust the height as needed

        child: Card(
          color: Colors.brown.shade200,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Diagnosis Type : ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 60),
                Expanded(
                  child: MyCustomDropdown(
                    items: ['Operation', 'Check-Up', 'Fever', 'Lab Test'],
                    initialValue: _diagnosisTypeController.text,
                    onChanged: (String? newValue) {
                      setState(() {
                        _diagnosisTypeController.text = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container get DateTimebyUser {
    return Container(
      child: Column(
        children: [
          Card(
            color: Colors.green.shade100,
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
                      text: dateByUser,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.purple, // Set your desired color here
                      ),
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.purple, // Set your desired color here
                ),
                onPressed: _showDatePicker,
              ),
            ),
          ),
          Card(
            color: Colors.green.shade100,
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
                        color: Colors.purple, // Set your desired color here
                      ),
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.access_time,
                  color: Colors.purple, // Set your desired color here
                ),
                onPressed: _showTimePicker,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


