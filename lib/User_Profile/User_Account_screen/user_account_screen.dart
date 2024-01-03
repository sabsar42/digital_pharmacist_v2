import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  late User currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
      loadUserData();
    }
  }

  Future<void> loadUserData() async {
    String userID = currentUser.uid;
    var userDoc = await FirebaseFirestore.instance.collection('users').doc(userID).get();

    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      setState(() {
        fullNameController.text = userData['full_name'] ?? '';
        emailController.text = userData['email'] ?? '';
        phoneController.text = userData['phone'] ?? '';
        passwordController.text = userData['password'] ?? '';
        ageController.text = userData['age'] ?? '';
        weightController.text = userData['weight'] ?? '';
        genderController.text = userData['gender'] ?? '';
        heightController.text = userData['height'] ?? '';
        bloodGroupController.text = userData['blood_group'] ?? '';
      });
    }
  }

  Future<void> addUserDetails() async {
    String userID = currentUser.uid;

    var userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get();

    if (userDoc.exists) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .update({
        'full_name': fullNameController.text,
        'age': ageController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'height': weightController.text,
        'weight': heightController.text,
        'gender': genderController.text,
        'blood_group': bloodGroupController.text,
        'password': passwordController.text,
      });
    } else {
      await FirebaseFirestore.instance.collection('users').doc(userID).set({
        'full_name': fullNameController.text,
        'age': ageController.text,
        'email': emailController.text,
        'height': heightController.text,
        'gender': genderController.text,
        'blood_group': bloodGroupController.text,
      });
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
                      child: const Image(
                        image: AssetImage("assets/profile_image.jpg"),
                      ),
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
