import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/Scheduler/widget/schedulerProfile.dart';
import 'package:digi_pharma_app_test/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulerScreen extends StatefulWidget {
  const SchedulerScreen({Key? key});

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


        String medicineName = data['medicineName'] ?? 'Unknown Medicine';
        String type = data['type'] ?? 'Unknown Type';
        String duration = data['duration'] ?? 'Unknown Duration';
        Timestamp startedDate = data['timestamp'] ?? 'Unknown Time';
        Timestamp validtillFB = data['validtill'] ?? 'Unknown Time';
        List<int> medicineTimes =
        List<int>.from(data['listoftimes'] ?? []);
        DateTime dateTime = startedDate.toDate().toLocal();
        DateTime validtillTime = validtillFB.toDate().toLocal();
        Duration difference = validtillTime.difference(DateTime.now());
        int indays = difference.inDays;
        String formattedDateTime = indays.toString();
        print('$medicineName: $medicineTimes');

        records.add({
          'documentID': document.id,
          'medicineName': medicineName,
          'type': type,
          'duration': duration,
          'time': formattedDateTime,
          'listoftimes': medicineTimes,
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

  String formatTime(int time) {
    int formattedTime = time % 12;
    if (formattedTime == 0) {
      formattedTime = 12;
    }
    String period = time >= 12 ? 'PM' : 'AM';
    return '$formattedTime $period';
  }

  @override
  Widget build(BuildContext context) {
    List<String> last7Days = _generateLast7Days();
    String currentDate = DateFormat('EEE, dd MMM').format(DateTime.now());

    List<String> upComingDays = _upComingDays();

    return Scaffold(
      body: Container(
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
                          children: last7Days
                              .map(
                                (date) => GestureDetector(
                              onTap: () {
                                print('Clicked on date');
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: date.contains(
                                        DateFormat('dd MMM')
                                            .format(DateTime.now()))
                                        ? Colors.deepOrange
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
                          children: upComingDays
                              .map(
                                (date) => Container(
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
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else {
                      List<Map<String, dynamic>> records = snapshot.data ?? [];

                      Map<int, List<Widget>> groupedWidgets = {};

                      records.forEach((record) {
                        String medicineName = record['medicineName'];
                        String type = record['type'];
                        String duration = record['duration'];
                        String stDate = record['time'];
                        List<int> times =
                        List<int>.from(record['listoftimes'] ?? []);
                        List<String> amPm = [];
                        for (int i = 0; i < times.length; i++) {
                          if (times[i] > 12) {
                            amPm.add('${times[i] - 12}PM');
                          } else {
                            amPm.add('${times[i]}AM');
                          }
                        }

                        for (int time in times) {
                          Widget medicineWidget = Container(
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              title: Text(
                                medicineName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(type),
                              trailing: Column(
                                children: [
                                  Text('Duration: $duration Days'),
                                  Text('Remaining: $stDate Days'),
                                ],
                              ),
                            ),
                          );

                          Widget timeWidget = Container(
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              title: Text('${formatTime(time)}'),
                            ),
                          );

                          Widget combinedRow = Container(
                            margin: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 70,
                                  child: medicineWidget,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 30,
                                  child: timeWidget,
                                ),
                              ],
                            ),
                          );

                          if (!groupedWidgets.containsKey(time)) {
                            groupedWidgets[time] = [];
                          }

                          groupedWidgets[time]!.add(combinedRow);
                        }
                      });

                      List<Widget> sortedWidgets = [];
                      List<int> sortedKeys = groupedWidgets.keys.toList()
                        ..sort();

                      for (var key in sortedKeys) {
                        sortedWidgets.addAll(groupedWidgets[key]!);
                      }

                      return ListView(
                        children: sortedWidgets,
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
