import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/Scheduler/Screen/SchedulerSettingsScreen.dart';
import 'package:digi_pharma_app_test/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../User_Profile/controller/upload_profile_image_contoller.dart';
import '../../User_Profile/screens/UserProfile.dart';



class schedulerProfileBar extends StatefulWidget {
  const schedulerProfileBar({super.key});

  @override
  State<schedulerProfileBar> createState() => _schedulerProfileBarState();
}

class _schedulerProfileBarState extends State<schedulerProfileBar> {
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
            padding: EdgeInsets.only(top: 50, left:0 ),
            // color: Colors.green,
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                GetBuilder<ShowUserProfileImageController>(
                  builder: (controller) {
                    final profileImageUrl = controller.profileImageUrl;

                    return CircleAvatar(
                      child: ClipOval(
                        child: profileImageUrl != null
                            ? Image.network(
                          profileImageUrl,
                          fit: BoxFit
                              .cover, // Use BoxFit.cover to ensure the image covers the circular area
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
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
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
          Positioned(
              top: 110,
              left: 180,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Create New Schedule',
                      style: size20White(),
                    ),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SchedulerSettingsScreen()));
                        },
                        child: SizedBox(
                          width: 140,
                          child: Center(
                            child: Text(
                              'Create',
                              style: siz20System(),
                            ),
                          ),
                        ))
                  ],
                ),
              ))

        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(
            "assets/images/dashboard_card.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
