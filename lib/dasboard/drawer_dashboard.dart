import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../LogIn_UI/LoginPage.dart';
import '../User_Profile/controller/upload_profile_image_contoller.dart';
import '../User_Profile/screens/UserProfile.dart';
import '../User_Profile/widget/user_profile_circle_avatar_get.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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

  void showSnackBar(String message) {
    var snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      backgroundColor: Color.fromRGBO(243, 231, 252, 1.0),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/dashboard_card.png", // Replace with the URL of your image
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 10),
                Text(
                  userInfo['full_name'] ?? 'Name not available',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userInfo['email'] ?? 'Email not available',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              // Handle drawer item tap
              Navigator.pop(context); // Close the drawer
              // Perform the action you want when Dashboard is tapped
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle drawer item tap
              Navigator.pop(context); // Close the drawer
              // Perform the action you want when Settings is tapped
            },
          ),
          ListTile(
            leading: ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LogInScreen()),
                  );
                } catch (e) {
                  print("Sign out error: $e");
                }
              },
              child: Text(
                'Logout',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(154, 5, 5, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
