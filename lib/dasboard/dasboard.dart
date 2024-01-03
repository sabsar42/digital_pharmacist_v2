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
            SizedBox(height: 170, child: DashboardAppbar()),
            Container(
              margin: EdgeInsets.only(left: 20, top: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Medical History",
                    style: TextStyle(fontSize: 31, color: Colors.black),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 50,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HealthRecordScreen()));
                            },
                            child: Container(
                              child: Container(
                                child: Text(
                                  "Medical History",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                height: 68,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xffFACE8C),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.1,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 25,
                          child: Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Container(
                              height: 69,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xffa0d28f),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 25,
                          child: Container(
                            margin: EdgeInsets.only(left: 14),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => monthlyMed()));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 69,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0x5453405e),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black),
                                    ),
                                  ),
                                  Positioned(
                                      top: 5,
                                      left: 5,
                                      bottom: 5,
                                      right: 5,
                                      child: Image.asset(
                                          'assets/images/dashboard_3.png'))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 40, 5, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Medicine", style: TextStyle(fontSize: 31)),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: 154,
                          height: 128,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black),
                            color: Color(0xff90b6f0),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
