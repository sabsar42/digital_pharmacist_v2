import 'package:digi_pharma_app_test/Scheduler/Screen/SchedulerSettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/style.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../User_Profile/controller/upload_profile_image_contoller.dart';
import '../../User_Profile/widget/user_profile_circle_avatar_get.dart';

class SchedulerAppBar extends StatefulWidget {
  const SchedulerAppBar({super.key});

  @override
  State<SchedulerAppBar> createState() => _SchedulerAppBarState();
}

class _SchedulerAppBarState extends State<SchedulerAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15),
            // color: Colors.green,
          ),
          Positioned(
            top: 15,
            left: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello Shuvo Sonjoy",
                        style: siz22White(),
                      ),
                      Text(
                        "ID: 2112s2X",
                        style: size20White(),
                      ),
                      Text(
                        "Age: 22",
                        style: size20White(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 110,
              left: 10,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Schedule',
                      style: siz22White(),
                    ),
                    SizedBox(
                      height: 5,
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
                        child: Text(
                          'Create',
                          style: siz20System(),
                        ))
                  ],
                ),
              ))
        ],
      ),
      decoration: BoxDecoration(
          color: Color(0xff08346D),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
    );
  }
}
