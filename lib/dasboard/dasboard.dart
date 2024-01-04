import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/Upload%20to%20Scanner/UploadScreenPreview.dart';
import 'package:digi_pharma_app_test/common_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../Camera Scanner/camera_screen.dart';
import '../Google Berd/BardHomePage.dart';
import '../Scheduler/Screen/SchedulerScreen.dart';
import '../User_Profile/UserProfile.dart';
import '../medical_history/Api_Health_Record_Screen.dart';
import '../medical_history/Health_Record_Screen.dart';
import '../monthlyMedicine/monthlyMedScreen/monthlyMed.dart';
import '../style.dart';
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

  @override
  void initState() {
    super.initState();
    loadUserInfo();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: CommonBackground(
        child: Column(
          children: [
            SizedBox(height: 200, child: DashboardAppbar()),
            Container(
           //   margin: EdgeInsets.only(left: 20, top: 18,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Medical History",
                    style: TextStyle(fontSize: 31, color: Colors.black),
                  ),
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
                          splashColor: Colors.purple,
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
                                  ? Image.asset(
                                      'assets/images/syrup.png',
                                      width: 40,
                                      height: 40,
                                    )
                                  : index == 1
                                      ? Image.asset(
                                          'assets/images/dashboard_4.png',
                                          width: 40,
                                          height: 40,
                                        )
                                      : index == 2
                                          ? Image.asset(
                                              'assets/images/alarm-clock.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : Text(
                                              "Item $index",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
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
                  builder: (context) => BardHomePage(),
                ),
              );
          }
        },
        selectedItemColor: Color.fromRGBO(62, 34, 148, 1.0),
        unselectedItemColor: Colors.grey,
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
