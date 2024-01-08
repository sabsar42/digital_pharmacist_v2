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
        doctorName: data['doctorName'].toString(),
        hospitalName: data['hospitalName'].toString(),
        date: data['date'].toString(),
        timeline: data['timeline'].toString(),
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

    int uniqueDiagnosisNumber = querySnapshot.size;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit_note_outlined,
              size: 35,
              color: Color.fromRGBO(6, 36, 59, 1.0),
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,
              color: Color.fromRGBO(6, 36, 59, 1.0),)),
        elevation: 10,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(236, 220, 248, 1.0),
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
              return HealthRecordCard(record: records[index]);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        splashColor: Colors.purple,
        backgroundColor: Colors.white70,
        onPressed: () async {
          await addHealthRecord();
          await fetchHealthRecords();
          setState(() {});
        },
      ),
    );
  }
}

class HealthRecord {
  final String docID;
  final String diagnosisNumber;
  final String doctorName;
  final String hospitalName;
  final String date;
  final String timeline;

  HealthRecord({
    required this.docID,
    required this.diagnosisNumber,
    required this.doctorName,
    required this.hospitalName,
    required this.date,
    required this.timeline,
  });
}

class HealthRecordCard extends StatelessWidget {
  final HealthRecord record;

  HealthRecordCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final customColor = Color.fromRGBO(8, 52, 109, 1.0);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TabBarScreen(uniqueDocID: record.docID),
          ),
        );
      },
      child: Card(
        shadowColor: Color.fromRGBO(199, 126, 252, 1.0),
        margin: EdgeInsets.all(10.0),
        color: customColor,
        elevation: 30,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage(
                "assets/images/card_background.png",
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
                            'Diagnosis Number: ${record.diagnosisNumber}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Date: ${record.date}',
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
                              record.doctorName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              record.hospitalName,
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
                        'Timeline: ${record.timeline}',
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