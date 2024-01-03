import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LogIn_UI/LoginPage.dart';
import 'User_Account_screen/user_account_screen.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
    var userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      return userDoc.data() as Map<String, dynamic>;
    } else {
      return {};
    }
  }
  Widget buildBannerCard() {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: AssetImage(
              "assets/images/card_background.png",  // Replace with the URL of your image
            ),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.greenAccent[400],
              radius: 50,
              child: Image.asset(
                "assets/images/patient.png",
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              userInfo['full_name'] ?? 'Name not available',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,  // Adjust text color based on background
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                UserDetailCard(label: "Age", value: userInfo['age'] ?? "N/A"),
                SizedBox(width: 16.0),
                UserDetailCard(label: "Gender", value: userInfo['gender'] ?? "N/A"),
                SizedBox(width: 16.0),
                UserDetailCard(label: "Location", value: userInfo['city'] ?? "N/A"),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget buildListTile(String title, IconData icon, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, size: 30.0),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward_ios_sharp),
          onTap: onTap,
        ),
        Divider(
          thickness: 1.0,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget buildLogoutTile(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await FirebaseAuth.instance.signOut();
          // Navigate to the login screen or another destination.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LogInScreen()),
          );
        } catch (e) {
          print("Sign out error: $e");
          // Display an error message to the user if sign out fails.
        }
      },
      child: Text(
        'Logout',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.blue,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildBannerCard(),
            SizedBox(height: 16.0),
            buildListTile("My Account", Icons.account_circle, () {
              // Navigate to MyAccountScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
              );
            }),

            buildListTile("Notification", Icons.notifications, () {
              // Handle tile tap
            }),
            buildListTile("Settings", Icons.settings, () {
              // Handle tile tap
            }),
            SizedBox(height: 16.0),
            buildLogoutTile(context),
          ],
        ),
      ),
    );
  }
}

class UserDetailCard extends StatelessWidget {
  final String label;
  final String value;

  UserDetailCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
