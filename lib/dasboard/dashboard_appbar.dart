import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/Scheduler/Screen/SchedulerScreen.dart';
import 'package:digi_pharma_app_test/User_Profile/controller/upload_profile_image_contoller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/style.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:digi_pharma_app_test/Scheduler/Screen/SchedulerScreen.dart';
import '../User_Profile/screens/UserProfile.dart';
import '../User_Profile/widget/user_profile_circle_avatar_get.dart';
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
            padding: EdgeInsets.only(top: 50, left: 10),
            // color: Colors.green,
          ),
          Positioned(
            top: 45,
            left: 15,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.menu,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                GetBuilder<ShowUserProfileImageController>(
                  builder: (controller) {
                    final profileImageUrl = controller.profileImageUrl;

                    return Container(
                      height: 50, // Adjust the height as needed
                      width: 50,  // Adjust the width as needed
                      child: ClipOval(
                        child: profileImageUrl != null
                            ? Image.network(
                          profileImageUrl,
                          fit: BoxFit.cover,
                        )
                            : Icon(
                          Icons.person,
                          size: 30,
                          color: Color.fromRGBO(227, 209, 236, 1.0),
                        ),
                      ),
                    );

                  },
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
                          style:size20White(),
                        ),
                        Text(
                          'Age :  ${userInfo['age']}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // Positioned(
          //   top: 130,
          //   left: 60,
          //   right: 49,
          //   child: Stack(
          //     children: [
          //       Container(
          //         height: 40,
          //         width: 280,
          //         decoration: BoxDecoration(
          //             border: Border.all(color: Colors.black54, width: 1),
          //             color: Color.fromRGBO(238, 217, 217, 1.0),
          //             borderRadius: BorderRadius.circular(10)),
          //       ),
          //       Positioned(
          //           bottom: 5,
          //           top: 5,
          //           left: 40,
          //           child: Row(
          //             children: [
          //               Container(
          //                 width: 30,
          //                 height: double.infinity,
          //                 decoration: BoxDecoration(
          //                   image: DecorationImage(
          //                     image: AssetImage(
          //                       'assets/images/dashboard_3.png',
          //                     ),
          //                     fit: BoxFit.cover,
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Text(
          //                 "Pill 2X",
          //                 style: TextStyle(
          //                     fontSize: 20, fontWeight: FontWeight.w100),
          //               ),
          //               SizedBox(
          //                 width: 20,
          //               ),
          //               Stack(
          //                 alignment: Alignment.center,
          //                 children: [
          //                   Container(
          //                     width: 100,
          //                     height: 35,
          //                     decoration: BoxDecoration(
          //                       border: Border.all(
          //                           color: Colors.black26, width: 0.9),
          //                       color: Color.fromRGBO(227, 209, 236, 1.0),
          //                       borderRadius: BorderRadius.circular(8),
          //                     ),
          //                   ),
          //                   // Text(
          //                   //   // timeWidget,
          //                   //   style: TextStyle(
          //                   //       fontSize: 18, fontWeight: FontWeight.w500),
          //                   // )
          //                 ],
          //               ),
          //             ],
          //           ))
          //     ],
          //   ),
          // ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color:   Color(0xff008081),
        // image: DecorationImage(
        //   image: AssetImage(
        //     "assets/images/dashboard_card.png", // Replace with the URL of your image
        //   ),
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
