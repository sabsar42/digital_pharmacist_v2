import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/BMI-calculator/bmi_screens/input_page.dart';
import 'package:digi_pharma_app_test/rapidAPI/medicine_info_screen.dart';
import 'package:digi_pharma_app_test/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Camera Scanner/camera_screen.dart';
import '../Gemini Digi-BOT/sections/text_only.dart';
import '../MedEx Medicine  Collection/Screens/all_medicine_list_screen.dart';
import '../Scheduler/Screen/SchedulerScreen.dart';
import '../medical_history/Health Record/screens/Health_Record_Screen.dart';
import '../monthlyMedicine/monthlyMedScreen/monthlyMed.dart';
import 'dashboard_appbar.dart';
import 'drawer_dashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  Map<String, dynamic> userInfo = {};
  int _selectedIndex = 0;
  late User currentUser;
  List<int> sortedList = [];
  late int upcomingMedicine;
  String upcomingMedicineAmPm = 'wait';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getAllListofTimes();
    loadUserInfo();
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

  Future<void> loadUserInfo() async {
    String userID = user.uid;
    userInfo = await getUserInfo(userID);
    setState(() {});
  }

  Future<Map<String, dynamic>> getUserInfo(String userId) async {
    var userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      return userDoc.data() as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  Future<List<List<int>>> getAllListofTimes() async {
    try {
      String userId = currentUser.uid;
      print(userId);
      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('remindersSet')
          .where("validtill", isGreaterThanOrEqualTo: Timestamp.now())
          .get();

      List<List<int>> allListofTimes = [];

      result.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        List<int> listoftimes = List<int>.from(data['listoftimes'] ?? []);
        allListofTimes.add(listoftimes);
      });

      Set<int> mergedSet = allListofTimes.expand((list) => list).toSet();

      print(mergedSet);
      sortedList = mergedSet.toList()..sort();
      List<int> upcomingTimes = getUpcomingTimes(sortedList);
      print(upcomingTimes.length);
      for (int time in upcomingTimes) {
        print('Upcoming Time: $time');
      }

      return allListofTimes;
    } catch (error) {
      print("Error fetching listoftimes: $error");
      return [];
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

  String formatTime(int time) {
    int formattedTime = time % 12;
    if (formattedTime == 0) {
      formattedTime = 12;
    }
    String period = time >= 12 ? 'PM' : 'AM';
    return '$formattedTime $period';
  }

  List<int> getUpcomingTimes(List<int> times) {
    int currentHour = DateTime.now().hour;

    print('Current Hour: $currentHour');
    List<int> upcomingTimes = [];
    print(times);

    for (int time in times) {
      int hour = time;

      if (hour > currentHour) {
        if (currentHour > 12) {
          upcomingTimes.add(time);
        } else {
          upcomingTimes.add(time);
        }
      }
    }

    if (upcomingTimes.isEmpty) {
      for (int time in times) {
        if (time < currentHour) {
          upcomingTimes.add(time);
        }
      }
    }

    upcomingTimes.sort();
    upcomingMedicine = (upcomingTimes.isNotEmpty ? upcomingTimes.first : null)!;

    upcomingMedicine = upcomingTimes[0];

    if (upcomingMedicine > 12 && upcomingMedicine != 24) {
      upcomingMedicine -= 12;
      upcomingMedicineAmPm = '${upcomingMedicine} PM';
    } else if (upcomingMedicine == 24) {
      upcomingMedicineAmPm = '${upcomingMedicine - 12} AM';
    } else {
      upcomingMedicineAmPm = '${upcomingMedicine} AM';
    }

    return upcomingTimes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 120, child: DashboardAppbar()),
            SizedBox(height: 20,),
            Container(
              width: 200,
              child: Center(child: Text('DASHBOARD',style: siz30White(),)),
              decoration: BoxDecoration(
                color:  Color(0xff008081),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: 30,),
            Stack(
              children: [
                Container(
                  height: 50,
                  width: 320,
                  decoration: BoxDecoration(
                    //  border: Border.all(color: Colors.black54, width: 1),
                      color:  Color(0x91008081),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Positioned(
                    bottom: 5,
                    top: 5,
                    left: 20,
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/dashboard_3.png',
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Next Medicine At",
                          style: siz20Black(),),
                        SizedBox(
                          width: 18,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 35,
                              child: Center(
                                child: FutureBuilder(
                                  future: getAllListofTimes(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Text(
                                        sortedList.length > 0
                                            ? upcomingMedicineAmPm
                                            : 'wait',style:size20White(),
                                      );
                                    }
                                  },
                                ),
                              ),

                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black26, width: 0.9),
                                color:  Color(0xff008081),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            // Text(
                            //   // timeWidget,
                            //   style: TextStyle(
                            //       fontSize: 18, fontWeight: FontWeight.w500),
                            // )
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          //  SizedBox(height: 30,),

            Container(
              //   margin: EdgeInsets.only(left: 20, top: 18,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   "Medical History",
                  //   style: TextStyle(fontSize: 31, color: Colors.black),
                  // ),

                  Container(
                    margin: EdgeInsets.all(5),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0,
                      ),
                      itemCount: 9,
                      // Adjust based on your data
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: Color(0x91008081),
                          onTap: () {
                            if (index == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HealthRecordScreen(),
                                ),
                              );
                            } else if (index == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => monthlyMed(),
                                ),
                              );
                            } else if (index == 2) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SchedulerScreen(),
                                ),
                              );
                            } else if (index == 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MedicineInformation()));
                            } else if (index == 4) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllMedicineList()));
                            } else if (index == 5) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InputPage(),
                                ),
                              );
                            }
                            // Add more conditions for other grid items
                          },
                          child: Container(
                            height: 68,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.99,
                              ),
                            ),
                            child: Center(
                              child: index == 0
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/syrup.png',
                                          width: 60,
                                          height: 60,
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          'Health Records',
                                          style: TextStyle(
                                              color: Color(0xFF008081),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ],
                                    )
                                  : index == 1
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/dashboard_4.png',
                                              width: 60,
                                              height: 60,
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              'Monthly Med',
                                              style: TextStyle(
                                                  color: Color(0xFF008081),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      : index == 2
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/alarm-clock.png',
                                                  width: 60,
                                                  height: 60,
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                  'Med Scheduler',
                                                  style: TextStyle(
                                                      color: Color(0xFF008081),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          : index == 3
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/dashboard_1.png',
                                                      width: 60,
                                                      height: 60,
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Text(
                                                      'Drugs Collection',
                                                      style: TextStyle(
                                                          color: Color(0xFF008081),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                )
                                              : index == 4
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/dashboard_2.png',
                                                          width: 60,
                                                          height: 60,
                                                        ),
                                                        SizedBox(
                                                          height: 12,
                                                        ),
                                                        Text(
                                                          'Medicines Data',
                                                          style: TextStyle(
                                                              color: Color(0xFF008081),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    )
                                                  : index == 5
                                                      ? Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/dashboard_2.png',
                                                              width: 60,
                                                              height: 60,
                                                            ),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Text(
                                                              'BMI Calculator',
                                                              style: TextStyle(
                                                                  color: Color(0xFF008081),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        )
                                                      : Text('None'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          switch (_selectedIndex) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
              );

            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraScreen(),
                ),
              );

            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SectionTextInput(),
                ),
              );
          }
        },
        backgroundColor: Color(0xff008081),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Camera'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: 'DigiBOT'),
        ],
      ),
    );
  }
}
