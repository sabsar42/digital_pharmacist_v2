import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UpdateProfileScreen extends StatefulWidget {
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    loadUserData();
  }

  Future<void> loadUserData() async {
    setState(() {
      fullNameController.text = prefs.getString('fullName') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
      ageController.text = prefs.getString('age') ?? '';
      weightController.text = prefs.getString('weight') ?? '';
      genderController.text = prefs.getString('gender') ?? '';
      heightController.text = prefs.getString('height') ?? '';
      bloodGroupController.text = prefs.getString('bloodGroup') ?? '';
    });
  }

  Future<void> saveUserData() async {
    prefs.setString('fullName', fullNameController.text);
    prefs.setString('email', emailController.text);
    prefs.setString('phone', phoneController.text);
    prefs.setString('password', passwordController.text);
    prefs.setString('age', ageController.text);
    prefs.setString('weight', weightController.text);
    prefs.setString('gender', genderController.text);
    prefs.setString('height', heightController.text);
    prefs.setString('bloodGroup', bloodGroupController.text);
  }





  Future<void> addUserDetails() async {
    // Get the current user ID
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userID = user.uid;

      // Check if the document already exists
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(userID).get();

      if (userDoc.exists) {
        // If the document exists, update its fields
        await FirebaseFirestore.instance.collection('users').doc(userID).update({
          'full_name': fullNameController.text,
          'age': ageController.text,
          'email': emailController.text,
          'phone' : phoneController.text,
          'height': weightController.text,
          'weight': heightController.text,
          'gender': genderController.text,
          'blood_group': bloodGroupController.text,
          'password': passwordController.text
        });
      } else {
        // If the document doesn't exist, create a new one
        await FirebaseFirestore.instance.collection('users').doc(userID).set({
          'full_name': fullNameController.text,
          'age': ageController.text,
          'email': emailController.text,
          'height': heightController.text,
          'gender': genderController.text,
          'blood_group': bloodGroupController.text,
        });
      }
    } else {
      print("User not logged in");
    }
  }

  void getUserID() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userID = user.uid;
      print("User ID: $userID");
      // You can use this userID to associate data in Firestore with the user.
    } else {
      print("User not logged in");
    }
  }


  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text("Edit Profile", style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Image with Icon
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage("assets/profile_image.jpg")),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue, // Change to your desired color
                      ),
                      child: const Icon(Icons.camera, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // Form Fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.fingerprint),
                        suffixIcon: IconButton(
                          icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            togglePasswordVisibility();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: ageController,
                      decoration: InputDecoration(
                        labelText: "Age",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: weightController,
                      decoration: InputDecoration(
                        labelText: "Weight",
                        prefixIcon: Icon(Icons.accessibility),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: genderController,
                      decoration: InputDecoration(
                        labelText: "Gender",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: heightController,
                      decoration: InputDecoration(
                        labelText: "Height",
                        prefixIcon: Icon(Icons.height),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: bloodGroupController,
                      decoration: InputDecoration(
                        labelText: "Blood Group",
                        prefixIcon: Icon(Icons.local_hospital),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          saveUserData();
                          addUserDetails();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          // Change to your desired color
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Created Date and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Joined 01/01/2024",
                          style: TextStyle(fontSize: 12),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle delete profile logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent.withOpacity(0.1),
                            elevation: 0,
                            foregroundColor: Colors.red,
                            shape: const StadiumBorder(),
                          ),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }
}