import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/Scheduler/Screen/SchedulerScreen.dart';
import 'package:digi_pharma_app_test/Scheduler/widget/settingsDropdown.dart';
import 'package:digi_pharma_app_test/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulerSettingsScreen extends StatefulWidget {
  const SchedulerSettingsScreen({Key? key}) : super(key: key);

  @override
  State<SchedulerSettingsScreen> createState() =>
      _SchedulerSettingsScreenState();
}

class _SchedulerSettingsScreenState extends State<SchedulerSettingsScreen> {
  late User currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController newValueController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController frequencyController = TextEditingController();
  final TextEditingController futureDateController = TextEditingController();
  late DateTime futureTime = DateTime.now();

  late List<TextEditingController> timeControllers;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    loadHealthRecordDetails();
    int timesPerDay = calculateTimesPerDay();
    timeControllers = List.generate(timesPerDay, (index) => TextEditingController());
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

  Future<void> loadHealthRecordDetails() async {
    String userID = currentUser.uid;

    try {
      var snapshot = await _firestore
          .collection('users')
          .doc(userID)
          .collection('healthRecords')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var latestRecord = snapshot.docs.first.data();
        setState(() {});
      }
    } catch (e) {
      print("Error loading health record details: $e");
    }
  }

  Future<void> addUserDetails() async {
    String userID = currentUser.uid;
    print(futureTime);
    List<int> pillSchedule = [];
    for (int i = 0; i < timeControllers.length; i++) {

      int timeValue = int.parse(timeControllers[i].text);


      pillSchedule.add(timeValue);
    }


    Map<String, dynamic> addDetails = {
      'medicineName': newValueController.text,
      'type': typeController.text,
      'duration': durationController.text,
      'frequency': frequencyController.text,
      'validtill': futureTime,
      'timestamp': FieldValue.serverTimestamp(),
      'listoftimes':pillSchedule,

    };


    await _firestore
        .collection('users')
        .doc(userID)
        .collection('remindersSet')
        .add(addDetails);
  }

  String dropdownvalue = 'Item 1';

  var items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6'];

  var colors = [
    Color(0x5903593f),
    Color(0x59F11212),
    Color(0xFFFF6B00),
    Color(0x5903593f),
    Color(0x59F11212),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SchedulerScreen()));
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 15, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set Reminders',
                  style: siz31Black(),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/dashboard_1.png',
                    height: 202,
                    width: 202,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Medicine Name',
                  style: siz20Black(),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xff040359), width: 2)),
                  child: DropdownButton(
                    value: dropdownvalue,
                    elevation: 0,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        newValueController.text = newValue!;
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Type',
                  style: siz20System(),
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          height: 72,
                          width: 82,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colors[index],
                          ),
                          //color: Colors.red,
                        );
                      }),
                ),
                Text(
                  'Time & Schedule',
                  style: size25Black(),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.yellow,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff08346D)),
                          onPressed: () {
                            _showTimeDialog();
                          },
                          child: Icon(Icons.add))
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(5, 15, 5, 5),
                  elevation: 10,

                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: 180,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Start',
                              style: siz20Black(),
                            ),
                            CustomDropdown(
                              items: ['Today', 'Yesterday'],
                              initialValue: 'Today',
                              onChanged: (String newValue) {},
                            ),
                            Icon(Icons.add),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Duration',
                              style: siz20Black(),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomDropdown(
                              items: [
                                '3',
                                '7',
                                '10',
                                '15',
                                '20',
                                '25',
                                '30',
                                '40',
                                '60',
                              ],
                              initialValue: '3',
                              onChanged: (value) {
                                setState(() {
                                  durationController.text = value;
                                  calculateDate();
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Frequency',
                              style: siz20Black(),
                            ),
                            CustomDropdown(
                              items: [
                                'Everyday',
                                'Twice a Day',
                                'Thrice a Day'
                              ],
                              initialValue: 'Everyday',
                              onChanged: (String? newValue) {
                                setState(() {
                                  frequencyController.text = newValue!;
                                  int timesPerDay = calculateTimesPerDay();
                                  timeControllers =
                                      List.generate(timesPerDay,
                                              (index) => TextEditingController());
                                  _showTimeDialog();

                                });
                              },
                            ),
                            Icon(Icons.add),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Alarm',
                              style: siz20Black(),
                            ),
                            Icon(Icons.add),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff08346D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onPressed: () {
                        addUserDetails();
                        print(newValueController.text);
                        print(frequencyController.text);
                        print(durationController.text);
                        print('pressed');
                        print(futureDateController.text);
                        print(futureTime);
                        for (int i = 0; i < timeControllers.length; i++) {
                          print("Time ${i + 1}: ${timeControllers[i].text}");
                        }
                      },
                      child: Text(
                        "Add Reminders",
                        style: size20White(),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void calculateDate() {
    DateTime currentDate = DateTime.now();
    int durationInDays = int.parse(durationController.text);
    DateTime futureDate = currentDate.add(Duration(days: durationInDays));
    futureTime = futureDate;
  }

  Future<void> _showTimeDialog() async {
    int timesPerDay = calculateTimesPerDay();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.yellow,

          title: Text('Select Pill Schedule'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(

                  children: List.generate(timesPerDay, (index) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: timeControllers[index],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Time ${index + 1}',
                                fillColor: colors[index],
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: 'AM',
                              items: ['AM', 'PM'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,

                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                if (value == 'PM') {
                                  timeControllers[index].text = (int.parse(timeControllers[index].text) + 12).toString();
                                }

                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'AM/PM',
                              ),
                            ),
                          ),
                        ],

                      ),
                    );
                  }),
                ),
                Text('NB: After Selecting AM/PM time will automatic generated in 24hr time format!!'),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text('Cancel')),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  int calculateTimesPerDay() {
    switch (frequencyController.text) {
      case 'Everyday':
        return 1;
      case 'Twice a Day':
        return 2;
      case 'Thrice a Day':
        return 3;
      default:
        return 1;
    }
  }
}
