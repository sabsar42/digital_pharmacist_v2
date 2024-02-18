import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/common_background.dart';
import 'package:digi_pharma_app_test/medical_history/Health%20Record/screens/health_record_card_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transformable_list_view/transformable_list_view.dart';
import 'package:digi_pharma_app_test/medical_history/Health%20Record/screens/Health_Record_Detailed.dart';
import '../../TabBar_View.dart';
import '../widget/TranformableListView_Packagea_Method.dart';

class HealthRecordScreen extends StatefulWidget {
  HealthRecordScreen({Key? key});

  @override
  State<HealthRecordScreen> createState() => _HealthRecordScreenState();
}

class _HealthRecordScreenState extends State<HealthRecordScreen> {
  late User currentUser;
  bool isAddingRecord = false;
  List<HealthRecord> records = [];

  @override
  void initState() {
    super.initState();
    fetchHealthRecords();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
    fetchHealthRecords();
  }

  Future<void> fetchHealthRecords() async {
    String userID = currentUser.uid;

    CollectionReference<Map<String, dynamic>> healthRecordsCollection =
        FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('healthRecords');

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await healthRecordsCollection.get();

    List<HealthRecord> fetchedRecords = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      String docID = doc.id.toString();

      return HealthRecord(
        docID: docID,
        diagnosisNumber: docID[docID.length - 1],
        diagnosisType: data['diagnosisType'].toString(),
        doctorName: data['doctorName'].toString(),
        specialization: data['doctor_specialization'].toString(),
        hospitalName: data['hospitalName'].toString(),
        date: data['date'].toString(),
        isCompleted: data['isCompleted'] ?? false,
        time: data['time'].toString(),
      );
    }).toList();

    setState(() {
      records = fetchedRecords;
    });
  }

  Future<void> addHealthRecord() async {
    setState(() {
      isAddingRecord = true;
    });

    String userID = currentUser.uid;

    CollectionReference<Map<String, dynamic>> healthRecordsCollection =
        FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('healthRecords');

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await healthRecordsCollection.get();

    int firstuniqueDiagnosisNumber = querySnapshot.size;
    int uniqueDiagnosisNumber = firstuniqueDiagnosisNumber + 1;

    String uniqueID = '$userID+${uniqueDiagnosisNumber.toString()}';

    Map<String, dynamic> newRecord = {
      'diagnosis': uniqueDiagnosisNumber,
      'doctorName': 'New Doctor',
      'hospitalName': 'New Hospital',
      'date': 'New Date',
      'timeline': 'New Timeline',
    };

    await healthRecordsCollection.doc(uniqueID).set(newRecord);
    setState(() {
      isAddingRecord = false;
    });
  }

  Future<void> deleteHealthRecord(String uniqueID) async {
    String userID = currentUser.uid;

    CollectionReference<Map<String, dynamic>> healthRecordsCollection =
        FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('healthRecords');

    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal.shade50,
          title: Text("Confirmation"),
          content: Text("Are you sure you want to delete this health record?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      await healthRecordsCollection.doc(uniqueID).delete();
      await fetchHealthRecords();
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Card(
            // padding: EdgeInsets.all(8.0), // Adjust padding as needed
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/card_background.png", // Replace with the URL of your image
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              height: 35,
              width: 60,
              child: Center(
                child: Text(
                  '${records.length} ',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white), // Adjust font size as needed
                ),
              ),
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(6, 36, 59, 1.0),
            )),
        elevation: 10,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(246, 236, 218, 1.0),
        title: Text(
          'HEALTH RECORDS',
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: CommonBackground(
        child: RefreshIndicator(
          onRefresh: () async {
            await fetchHealthRecords();
          },
          child: isAddingRecord
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : TransformableListView.builder(
                  getTransformMatrix: getTransformMatrix,
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    return HealthRecordCard(
                      record: records[index],
                      onDelete: () async {
                        await deleteHealthRecord(records[index].docID);
                      },
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        splashColor: Colors.teal,
        backgroundColor: Colors.white70,
        onPressed: () async {
          //  String uniqueDocID = (records.length+1).toString();
          await addHealthRecord();
          await fetchHealthRecords();

          /// !!!!! NEED to be fixed, created an Dupilcate DocID in firebase, EasyFix tho !!!!!
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             TabBarScreen(uniqueDocID: uniqueDocID.toString())));
          setState(() {});
        },
      ),
    );
  }
}

class HealthRecord {
  final String docID;
  final String diagnosisNumber;
  final String diagnosisType;
  final String doctorName;
  final String specialization;
  final String hospitalName;
  final String date;
  final bool isCompleted;
  final String time;

  HealthRecord({
    required this.docID,
    required this.diagnosisNumber,
    required this.diagnosisType,
    required this.doctorName,
    required this.specialization,
    required this.hospitalName,
    required this.date,
    required this.isCompleted,
    required this.time,
  });
}
