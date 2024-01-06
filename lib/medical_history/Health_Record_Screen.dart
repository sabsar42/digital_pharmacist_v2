import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/common_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transformable_list_view/transformable_list_view.dart';
import 'package:digi_pharma_app_test/medical_history/Health_Record_Detailed.dart';
import 'TabBar_View.dart';
import 'TranformableListView_Packagea_Method.dart';

class HealthRecordScreen extends StatefulWidget {

  HealthRecordScreen({Key? key});
  @override
  State<HealthRecordScreen> createState() => _HealthRecordScreenState();
}

class _HealthRecordScreenState extends State<HealthRecordScreen> {
  var cardCounter = 1;
  List<HealthRecord> records = [];

  late User currentUser;

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
      fetchHealthRecords();
    }
  }

  Future<void> fetchHealthRecords() async {
    String userID = currentUser.uid;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('healthRecords')
        .limit(cardCounter)
        .get();

    setState(() {
      records = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return HealthRecord(
          diagnosisNumber: data['diagnosis'] ?? '',
          doctorName: data['doctorName'] ?? '',
          hospitalName: data['hospitalName'] ?? '',
          date: data['date'] ?? '',
          timeline: data['timeline'] ?? '',
        );
      }).toList();
    });
  }

  Future<void> addHealthRecord() async {
    String userID = currentUser.uid;

    CollectionReference<Map<String, dynamic>> healthRecordsCollection =
    FirebaseFirestore.instance.collection('users').doc(userID).collection('healthRecords');

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await healthRecordsCollection.get();

    // Calculate the new diagnosis number based on the length of the nested collection
    String newDiagnosisNumber = (querySnapshot.docs.length + 1).toString();

    Map<String, dynamic> newRecord = {
      'diagnosis': newDiagnosisNumber,
      'doctorName': 'New Doctor',
      'hospitalName': 'New Hospital',
      'date': 'New Date',
      'timeline': 'New Timeline',
    };

    // Add the new record to the nested collection
    await healthRecordsCollection.add(newRecord);

    // Fetch updated data
    fetchHealthRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Color.fromRGBO(236, 220, 248, 1.0),
        title: Text(
          '\nHealth Records',
          style: TextStyle(
            fontSize: 24,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CommonBackground(
        child: TransformableListView.builder(
          getTransformMatrix: getTransformMatrix,
          itemCount: records.length,
          itemBuilder: (context, index) {
            return HealthRecordCard(record: records[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        splashColor: Colors.purple,
        backgroundColor: Colors.white70,
        onPressed: () {
          addHealthRecord(); // Call the addHealthRecord function
        },
      ),
    );
  }
}


class HealthRecord {
  final String diagnosisNumber;
  final String doctorName;
  final String hospitalName;
  final String date;
  final String timeline;

  HealthRecord({
    required this.diagnosisNumber,
    required this.doctorName,
    required this.hospitalName,
    required this.date,
    required this.timeline,
  });
}

class HealthRecordCard extends StatefulWidget {
  final HealthRecord record;
  final String num;

  HealthRecordCard({required this.record}) : num = record.diagnosisNumber;

  @override
  State<HealthRecordCard> createState() => _HealthRecordCardState();
}

class _HealthRecordCardState extends State<HealthRecordCard> {
  final customColor = Color.fromRGBO(8, 52, 109, 1.0);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
               // HealthRecordDetailScreen(diagnosisNumber: widget.record.diagnosisNumber),
                TabBarScreen(diagnosisNumberfromPrev: widget.num),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        color: customColor,
        elevation: 30,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19.0), // Rounded corners
        ),
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
          child: Padding(
            padding: EdgeInsets.all(35.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Diagnosis Number: ${widget.record.diagnosisNumber}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Date: ${widget.record.date}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/doctor.png'),
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
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              widget.record.hospitalName,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Timeline: ${widget.record.timeline}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      right: 8.0,
                      child: Icon(
                        Icons.link,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
