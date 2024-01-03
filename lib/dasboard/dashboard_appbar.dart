import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/Scheduler/Screen/SchedulerScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/style.dart';

import '../User_Profile/UserProfile.dart';
import 'drawer_dashboard.dart';

class DashboardAppbar extends StatefulWidget {
  const DashboardAppbar({super.key});

  @override
  State<DashboardAppbar> createState() => _DashboardAppbarState();
}

class _DashboardAppbarState extends State<DashboardAppbar> {
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
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, left: 15),
            // color: Colors.green,
          ),
          Positioned(
            top: 45,
            left: 25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserProfile()));
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userInfo['full_name'] ?? 'Name not available',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          userInfo['age'] ?? "N/A",
                          style: size16White(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 40,
            right: 49,
            child: Stack(
              children: [
                Container(
                  height: 40,
                  width: 235,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      color: Color(0xffB3C3FD),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Positioned(
                    bottom: 5,
                    top: 5,
                    left: 10,
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/dashboard_3.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Pill 2X",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 35,
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.black, width: 1),
                                color: Color(0xffF68D8D),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Text(
                              "9.00AM",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
          Positioned(
            top: 80,
            left: 300,
            child: Stack(
              children: [
                Container(
                  height: 45,
                  width: 55,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffFFEF99),
                  ),
                ),
                Positioned(
                  bottom: 3,
                  top: 3,
                  left: 3,
                  right: 3,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SchedulerScreen()));
                    },
                    child: CircleAvatar(
                      radius: 2,
                      backgroundImage:
                      AssetImage('assets/images/alarm-clock.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(12, 57, 93, 1.0),
      ),
    );
  }
}
