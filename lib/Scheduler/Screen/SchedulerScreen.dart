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
        String pilltime = data['pilltime'] ?? 'Unknown';
        String pilllimit = data['pilllimit'] ?? 'Unknown';
        String duration = data['duration'] ?? 'Unknown Duration';
        String pillImage = data['pillImage'] ?? 'unknown';
        Timestamp startedDate = data['timestamp'] ?? 'Unknown Time';
        Timestamp validtillFB = data['validtill'] ?? 'Unknown Time';
        List<int> medicineTimes = List<int>.from(data['listoftimes'] ?? []);
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
          'pilltime': pilltime,
          'pilllimit': pilllimit,
          'pillImage': pillImage,
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
              flex: 22,
              child: SizedBox(height: 200, child: schedulerProfileBar()),
            ),
            Expanded(
              flex: 8,
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                child: Column(children: [


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
                                            ? Color(0xea02a676)
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
                                            ?Color(0xFFFF8D8D)
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
                                      color: date.contains(DateFormat('dd MMM')
                                              .format(DateTime.now()))
                                          ? Color(0x86FF8D8D)
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
                                        DateFormat('dd MMM').format(
                                          DateTime.now(),
                                        ),
                                      )
                                          ? Color(0xea02a676)
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
              flex: 70,
              child: Container(
                // margin: EdgeInsets.only(left: 10, right: 10),
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
                        String pillTime = record['pilltime'];
                        String pillLimit = record['pilllimit'];
                        String pillImage = record['pillImage'];
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
                          Widget medicineWidget = Text(
                            medicineName,
                            style: size20Gray(),
                          );

                          Widget timeWidget = Text(
                            'Time: ${formatTime(time)}',
                            style: size25Black(),
                          );

                          Widget combinedRow = Card(
                            margin: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            elevation: 2,
                            color: Colors.white,
                            child: Container(
                              color: Colors.white,
                              height: 110,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 25,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 5, right: 5),
                                      height: 70,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(pillImage),
                                          fit: BoxFit.contain,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 65,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          timeWidget,
                                          medicineWidget,
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 90,
                                                  child: Center(
                                                    child: Text(
                                                      'Before Meal',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff03805d),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0x9002a676),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x86FF8D8D),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Amount: 2X',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFF64A4A),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return MyDialog(
                                                  index: time,
                                                  medName: medicineName);
                                            });
                                      },
                                      icon: Icon(
                                        Icons.unfold_more_rounded,
                                        color: Color(0xea02a676),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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

class MyDialog extends StatelessWidget {
  final int index;
  final String medName;

  const MyDialog({Key? key, required this.index, required this.medName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Details for Item $medName'),
      content: Column(
        children: [
          Text('Pill Time : '),
          Text('Pill Limit'),
          Text('Duration'),
          Text('Remaining'),
          Text('Medicine Form'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
