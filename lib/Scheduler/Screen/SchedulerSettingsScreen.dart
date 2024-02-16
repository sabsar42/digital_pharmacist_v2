import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/Scheduler/Screen/SchedulerScreen.dart';
import 'package:digi_pharma_app_test/Scheduler/widget/settingsDropdown.dart';
import 'package:digi_pharma_app_test/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SchedulerSettingsScreen extends StatefulWidget {
  const SchedulerSettingsScreen({Key? key}) : super(key: key);

  @override
  State<SchedulerSettingsScreen> createState() =>
      _SchedulerSettingsScreenState();
}

class _SchedulerSettingsScreenState extends State<SchedulerSettingsScreen> {
  late User currentUser;
  bool switchValue = false;
  late String latestHealthRecordId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  double _currentSliderValue = 1;
  final TextEditingController newValueController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController frequencyController = TextEditingController();
  final TextEditingController futureDateController = TextEditingController();
  final TextEditingController pillTimeController = TextEditingController();
  final TextEditingController pillLimitController = TextEditingController();
  final TextEditingController pillImageController = TextEditingController();
  late DateTime futureTime = DateTime.now();

  late List<TextEditingController> timeControllers;
  int medTypeIsSelected = -1;
  var items = ['select'];


  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchLatestHealthRecordId(currentUser.uid);
    int timesPerDay = calculateTimesPerDay();
    timeControllers =
        List.generate(timesPerDay, (index) => TextEditingController());
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

  Future<String?> fetchLatestHealthRecordId(String userId) async {
    print(userId);
    print('entereddddddd');
    try {
      print('agaian');
      CollectionReference healthRecordsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('healthRecords');
      print('isIt');

      QuerySnapshot querySnapshot = await healthRecordsCollection
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();
      print(querySnapshot.docs.first.id);
      print('isIt');
      if (querySnapshot.docs.isNotEmpty) {
        latestHealthRecordId = querySnapshot.docs.first.id;

        print('recordrecoredrecord');
        print(latestHealthRecordId);
        setState(() {
          loadHealthRecordDetails(latestHealthRecordId);
        });
        return querySnapshot.docs.first.id;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> loadHealthRecordDetails(String latestHealthRecordId) async {
    String userID = currentUser.uid;

    try {
      var snapshot = await _firestore
          .collection('users')
          .doc(userID)
          .collection('healthRecords')
          .doc( latestHealthRecordId)
          .collection('medicine_dosage_duration')
          .get();

      for (QueryDocumentSnapshot document in snapshot.docs) {
        String medicineName = document['medicine_name'];
        items.add(medicineName);
        setState(() {});
      }
    } catch (e) {
      print("Error loading health record details: $e");
    }
  }

  Future<void> addMedicineInfo() async {
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
      'listoftimes': pillSchedule,
      'pilltime': pillTimeController.text,
      'pilllimit': pillLimitController.text,
      'pillImage': pillImageController.text,
    };

    await _firestore
        .collection('users')
        .doc(userID)
        .collection('remindersSet')
        .add(addDetails);
  }

  String dropdownvalue = 'select';
  bool manualDropdownFlag = false;

  var colors = [
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  var medImgForm = [
    Image.asset('assets/images/syrup.png'),
    Image.asset('assets/images/tablet.png'),
    Image.asset('assets/images/eye-drops.png'),
    Image.asset('assets/images/dashboard_4.png'),
    Image.asset('assets/images/capsule.png'),
  ];
  var medicineImage = [
    'assets/images/syrup.png',
    'assets/images/tablet.png',
    'assets/images/eye-drops.png',
    'assets/images/dashboard_4.png',
    'assets/images/capsule.png'
  ];
  var medFormName = ['Syrup', 'Tablet', 'Drops', 'Injection', 'Capsule'];

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
            Icons.arrow_back_ios,
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
            margin: EdgeInsets.fromLTRB(15, 0, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set Reminders',
                  style: siz31Black(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Medicine Name',
                  style: siz20Black(),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 75,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        height: 44,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey, width: 2)),
                        child: Center(
                          child: DropdownButton(
                            value: manualDropdownFlag
                                ? newValueController.text
                                : dropdownvalue,
                            dropdownColor: Colors.grey,
                            borderRadius: BorderRadius.circular(30),
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
                      ),
                    ),
                    Expanded(
                      flex: 35,
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: Color(0xff45967f),
                          ),
                          onPressed: () {
                            _showDialog(context);
                          },
                          child: Text(
                            'Enter Manually',
                            style: size14White(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Medicine Form',
                  style: siz20Black(),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  height: 150,
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            if (medTypeIsSelected == index) {
                              medTypeIsSelected = -1;
                            } else {
                              medTypeIsSelected = index;
                              typeController.text = medFormName[index];
                              pillImageController.text = medicineImage[index];
                            }
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                padding: EdgeInsets.all(8),
                                height: medTypeIsSelected == index ? 80 : 72,
                                width: medTypeIsSelected == index ? 80 : 72,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: medTypeIsSelected == index
                                      ? Color(0x9602a676)
                                      : Colors.white,
                                ),
                                child: medImgForm[index],
                                //color: Colors.red,
                              ),
                              Text(
                                medFormName[index],
                                style: medTypeIsSelected == index
                                    ? size25Black()
                                    : size15Black(),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                Text(
                  'Pill Limit',
                  style: siz20Black(),
                ),
                Slider(
                  value: _currentSliderValue,
                  max: 5,
                  divisions: 5,
                  activeColor: Color(0xff02a676),
                  label: _currentSliderValue.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _currentSliderValue = value;
                      int x = value.toInt();
                      pillLimitController.text = x.toString();
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        pillTimeController.text = 'Before Meal';
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Text(
                          "Before Meal",
                          style: size15Black(),
                        )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        pillTimeController.text = 'After Meal';
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Text(
                          "After Meal",
                          style: size17White(),
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Text(
                        'Start From ',
                        style: siz20Black(),
                      ),
                    ),
                    Expanded(
                      flex: 70,
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        child: Center(
                          child: CustomDropdown(
                            items: ['Today', 'Yesterday'],
                            initialValue: 'Today',
                            onChanged: (String newValue) {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 28,
                      child: Text(
                        'Duration    ',
                        style: siz20Black(),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 72,
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        child: Center(
                          child: CustomDropdown(
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
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Text(
                        'Frequency     ',
                        style: siz20Black(),
                      ),
                    ),
                    Expanded(
                      flex: 70,
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        child: Center(
                          child: CustomDropdown(
                            items: ['Everyday', 'Twice a Day', 'Thrice a Day'],
                            initialValue: 'Everyday',
                            onChanged: (String? newValue) {
                              setState(() {
                                frequencyController.text = newValue!;
                                int timesPerDay = calculateTimesPerDay();
                                timeControllers = List.generate(timesPerDay,
                                    (index) => TextEditingController());
                                _showTimeDialog();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Alarm     ',
                      style: siz20Black(),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Switch(
                      inactiveTrackColor: Colors.white,
                      inactiveThumbColor: Colors.red,
                      value: switchValue,
                      onChanged: (value) {
                        switchValue = value;
                        setState(() {});
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff02a676),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          addMedicineInfo();
                          for (int i = 0; i < timeControllers.length; i++) {
                            print("Time ${i + 1}: ${timeControllers[i].text}");
                          }
                        },
                        child: Text(
                          "Add Reminders",
                          style: size20White(),
                        )),
                  ),
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
          backgroundColor: Colors.white,
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
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
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
                                  timeControllers[index].text =
                                      (int.parse(timeControllers[index].text) +
                                              12)
                                          .toString();
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
                Text(
                    'NB: After Selecting AM/PM time will automatic generated in 24hr time format!!'),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
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

  void _showDialog(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Name'),
          content: TextField(
            controller: textFieldController,
            decoration: InputDecoration(hintText: 'Medicine Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                newValueController.text = textFieldController.text;
                items.add(newValueController.text);
                manualDropdownFlag = true;
                setState(() {});

                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
