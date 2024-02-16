import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/medical_history/Health%20Record/screens/Health_Record_Screen.dart';
import 'package:digi_pharma_app_test/medical_history/Health%20Record/widget/medicine_dosage_duration_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Health Record/patientDataFlow.dart';
import '../../../Scheduler/widget/settingsDropdown.dart';
import '../Widget/doctor_information.dart';
import '../Widget/med_information_card.dart';
import '../Widget/my_custom_dropdown.dart';
import '../widget/prescribed_medicine_card.dart';

class HealthRecordDetailScreen extends StatefulWidget {
  final String uniqueDiagnosisNumber;

  HealthRecordDetailScreen({Key? key, required this.uniqueDiagnosisNumber});

  @override
  State<HealthRecordDetailScreen> createState() =>
      _HealthRecordDetailScreenState();
}

class _HealthRecordDetailScreenState extends State<HealthRecordDetailScreen> {
  late User currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController prescribedMedicineController =
      TextEditingController();
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _hospitalNameController = TextEditingController();
  final TextEditingController _diagnosisTypeController =
      TextEditingController();

  // final TextEditingController _medNameController = TextEditingController();
  // final TextEditingController _frequencyController = TextEditingController();
  // final TextEditingController _durationController = TextEditingController();

  DateTime _dateTime = DateTime.now();
  late String dateByUser = '';
  late String timeByUser = '';
  bool isCompleted = false;
  bool isAddingDetailedRecord = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    loadHealthRecordData();
    loadMedicineDetails();
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

  List<dynamic> prescribedMedicines = [];

  Future<void> loadHealthRecordData() async {
    String userID = currentUser.uid;
    String uniqueID = widget.uniqueDiagnosisNumber;

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
          _diagnosisTypeController.text = data['diagnosisType'] ?? '';
          _doctorNameController.text = data['doctorName'] ?? '';
          _specializationController.text = data['doctor_specialization'] ?? '';
          _hospitalNameController.text = data['hospitalName'] ?? '';
          isCompleted = data['isCompleted'] ?? false;
          dateByUser = data['date'] ?? '';
          timeByUser = data['time'] ?? DateFormat('HH-mm').format(_dateTime);
        });
      }
    } catch (error) {
      print("Error loading health record data: $error");
    }
  }

  Future<void> loadMedicineDetails() async {
    String userID = currentUser.uid;
    String uniqueID = widget.uniqueDiagnosisNumber;
    try {
      //
      // /// for ADDING  DRUGS_COLLECTIONS WITH DUPLICATES
      // CollectionReference<Map<String, dynamic>> drugsCollection =
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userID)
      //     .collection('drugsCollection');

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('users')
          .doc(userID)
          .collection('healthRecords')
          .doc(uniqueID)
          .collection('medicine_dosage_duration')
          .get();
      setState(() {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data();
          String medName;
          medName = data['medicine_name'] ?? '';
          prescribedMedicines.add(medName.toString());

          // ///DRUGS - WITH DUPLICATES
          // drugsCollection.add({
          //   'medicine_name': medName.toString(),
          //   'timestamp': FieldValue.serverTimestamp(),
          // });
          //
        }
      });
    } catch (error) {
      print("Error loading Medicine Details: $error");
    }
  }

  Future<void> addHealthRecordDetails() async {
    setState(() {
      isAddingDetailedRecord = true;
    });
    String userID = currentUser.uid;
    String uniqueID = widget.uniqueDiagnosisNumber;
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
      'diagnosisType': _diagnosisTypeController.text,
      'isCompleted': isCompleted,
      'date': dateByUser,
      'time': timeByUser,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await healthRecordsCollection.doc(uniqueID).set(newRecord);
    setState(() {
      isAddingDetailedRecord = false;
    });
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
      body: RefreshIndicator(
        color: Colors.purple,
        onRefresh: () async {
          await loadHealthRecordData();
        },
        child: isAddingDetailedRecord
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,


                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CompletedanndSaveRow(),
                      SizedBox(height: 10.0),
                      DateTimebyUser,
                      diagnosisTypeDropDown(),
                      SizedBox(height: 1.0),
                      DoctorHospitalInformation(
                        doctorNameController: _doctorNameController,
                        specializationController: _specializationController,
                        hospitalNameController: _hospitalNameController,
                      ),
                      MedInfoCard(
                        diagnosisController: _diagnosisController,
                        title: 'DIAGNOSIS',
                      ),
                      MedicineRow(
                        uniqueDiagnosisNumber: widget.uniqueDiagnosisNumber,
                      ),

                      ///BACK HERE IF YOU MESS UPPP
                      // MedInfoCard(
                      //   diagnosisController: prescribedMedicineController ,
                      //   title: '| Medicines',
                      // ),
                      /// BACK TILL HERE
                      ///
                      MedInfoCard(
                        diagnosisController: _summaryController,
                        title: 'Summary of Diagnosis',
                      ),
                      SizedBox(height: 16.0),
                      if (prescribedMedicines.isNotEmpty)
                        PrescribedMedicineCard(
                            prescribedMedicines: prescribedMedicines),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Row CompletedanndSaveRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // SizedBox(
        //   width: 8,
        // ),
      Expanded(
        flex: 4,
        child: Row(

            children:[  Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.yellowAccent,
                  width: 2,
                )),
            child: CircleAvatar(
              backgroundColor: isCompleted ? Colors.green : Colors.grey,
              radius: 18,
              child: IconButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
                icon: Icon(
                  Icons.done_outline_rounded,
                  color: isCompleted ? Colors.white : Colors.black45,
                  size: 22,
                ),
                onPressed: () {
                  isCompleted = !isCompleted;
                  setState(() {});
                },
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 70,
            child: isCompleted ? Text('Completed') : Text('Ongoing'),
          ),]
        ),
      ),
        Expanded(
          flex: 3,
          child: SizedBox(

          ),
        ),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () {
              addHealthRecordDetails();
            },
            child: Text("+ SAVE",style: TextStyle(
              color: Colors.white,
            ),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Padding diagnosisTypeDropDown() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 70, // Adjust the height as needed

        child: Card(
          color: Colors.brown.shade200,
          elevation: 4,
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
            elevation: 2,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.teal.shade500, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: Colors.white70,
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
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.teal.shade500, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: Colors.white70,
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
