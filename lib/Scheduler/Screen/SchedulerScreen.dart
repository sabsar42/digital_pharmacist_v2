import 'package:digi_pharma_app_test/Scheduler/widget/schedulerProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulerScreen extends StatefulWidget {
  const SchedulerScreen({super.key});

  @override
  State<SchedulerScreen> createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends State<SchedulerScreen> {
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
    }
  }

  Future<List<Map<String, dynamic>>> getData() async {
    try {
      String userID = currentUser.uid;

      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('remindersSet')
          .where("validtill", isGreaterThanOrEqualTo: Timestamp.now())
          .get();

      List<Map<String, dynamic>> records = [];

      result.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        // Handling null values with default values
        String medicineName = data['medicineName'] ?? 'Unknown Medicine';
        String type = data['type'] ?? 'Unknown Type';
        String duration = data['duration'] ?? 'Unknown Duration';
        Timestamp startedDate= data['timestamp']??'Unknow Time';
        DateTime dateTime = startedDate.toDate().toLocal();
        String formattedDateTime = DateFormat.yMMMMd().add_jm().format(dateTime);

        records.add({
          'documentID': document.id,
          'medicineName': medicineName,
          'type': type,
          'duration': duration,
          'time':formattedDateTime,

        });
      });

      return records;
    } catch (error) {
      print("Error fetching records: $error");
      return [];
    }
  }

  List<String> _generateLast7Days() {
    List<String> last7Days = [];
    for (int i = 3; i >= 0; i--) {
      DateTime currentDate = DateTime.now().subtract(Duration(days: i));
      String dayName = DateFormat('EEE').format(currentDate);
      String dayAndMonth = DateFormat('dd MMM').format(currentDate);
      last7Days.add('$dayName\n$dayAndMonth');
    }
    return last7Days;
  }

  List<String> _upComingDays() {
    List<String> upComingDays = [];
    for (int i = 1; i < 3; i++) {
      DateTime currentDate = DateTime.now().add(Duration(days: i));
      String dayName = DateFormat('EEE').format(currentDate);
      String dayAndMonth = DateFormat('dd MMM').format(currentDate);
      upComingDays.add('$dayName\n$dayAndMonth');
    }
    return upComingDays;
  }

  @override
  Widget build(BuildContext context) {
    List<String> last7Days = _generateLast7Days();
    String currentDate = DateFormat('EEE, dd MMM').format(DateTime.now());

    List<String> upComingDays = _upComingDays();

    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 200,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   flexibleSpace: SchedulerAppBar(),
      // ),
      body: Container(
        //  margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 25,
              child: SizedBox(height: 200, child: schedulerProfileBar()),
            ),
            Expanded(
              flex: 15,
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Reminders',
                    style: size30Black(),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: last7Days
                              .map(
                                (date) => GestureDetector(
                                  onTap: () {
                                    final Timestamp firebaseTimestamp =
                                        Timestamp.fromMillisecondsSinceEpoch(
                                            1641555245000);
                                    DateTime dateTime = firebaseTimestamp.toDate().toLocal(); // Convert to local time
                                    String formattedDateTime = DateFormat.yMMMMd().add_jm().format(dateTime);
                                    print(formattedDateTime);

                                    print(firebaseTimestamp);
                                    print('Clicked on date');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: date.contains(
                                                DateFormat('dd MMM')
                                                    .format(DateTime.now()))
                                            ? Colors.blue
                                            : Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      date,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: date.contains(
                                                DateFormat('dd MMM')
                                                    .format(DateTime.now()))
                                            ? Colors.blue
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: upComingDays
                              .map(
                                (date) => Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: date.contains(DateFormat('dd MMM')
                                              .format(DateTime.now()))
                                          ? Colors.blue
                                          : Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    date,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: date.contains(DateFormat('dd MMM')
                                              .format(DateTime.now()))
                                          ? Colors.blue
                                          : null,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              flex: 60,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    //    color: Colors.deepOrange,
                    ),
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else {
                      List<Map<String, dynamic>> records = snapshot.data ?? [];
                      return ListView.separated(
                        itemCount: records.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> record = records[index];
                          String medicineName = record['medicineName'];
                          String type = record['type'];
                          String duration = record['duration'];
                          String stDate = record['time'];

                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              title: Text(
                                medicineName,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(type),
                              trailing: Column(
                                children: [
                                  Text('$duration days'),
                                  Text('Stard Date : $stDate'),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(height: 20);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
