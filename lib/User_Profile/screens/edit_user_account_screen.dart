import 'dart:io';
import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digi_pharma_app_test/common_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../show_snackbar.dart';
import '../controller/upload_profile_image_contoller.dart';
import 'UserProfile.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ShowUserProfileImageController showUserProfileImageController =
      Get.find<ShowUserProfileImageController>();

  File? _image;
  final imagePicker = ImagePicker();
  late User currentUser;

  String? userID;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    showUserProfileImageController.loadUserImageData();
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
    var userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();

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

  Future<void> addUserProfilePicture() async {
    String userID = currentUser.uid;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${userID}/user_profile_folder")
        .child("${userID}_dp.jpg");

    await ref.putFile(_image!);
    String userProfileImageUrl = await ref.getDownloadURL();
    print(userProfileImageUrl);

    var userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();

    if (userDoc.exists) {
      await FirebaseFirestore.instance.collection('users').doc(userID).update({
        'user_profile_picture': userProfileImageUrl,
      });
    } else {
      await FirebaseFirestore.instance.collection('users').doc(userID).set({
        'password': passwordController.text,
      });
    }
  }

  Future<void> addUserDetails() async {
    String userID = currentUser.uid;

    var userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();

    if (userDoc.exists) {
      await FirebaseFirestore.instance.collection('users').doc(userID).update({
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

  Future imagePickerMethod(ImageSource source) async {
    final pick = await imagePicker.pickImage(source: source);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);

        showSnackBar(
            'Image Uploaded Successfully', Duration(microseconds: 300), true);
      } else {
        showSnackBar('No Image Selected', Duration(microseconds: 300), false);
      }
    });
  }

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/common_background.png',
          fit: BoxFit.cover,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.teal,
          ),
        ),
        title: Text("EDIT PROFILE",
            style: Theme.of(context).textTheme.titleMedium),
      ),
      body: CommonBackground(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Image with Icon
                Stack(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: InkWell(
                        child: GetBuilder<ShowUserProfileImageController>(
                          builder: (controller) {
                            final profileImageUrl = controller.profileImageUrl;

                            return Container(
                              height: 50, // Adjust the height as needed
                              width: 50, // Adjust the width as needed
                              child: ClipOval(
                                child: profileImageUrl != null
                                    ? Image.network(
                                        profileImageUrl,
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(
                                        Icons.person,
                                        size: 30,
                                        color:
                                            Color.fromRGBO(141, 12, 206, 1.0),
                                      ),
                              ),
                            );
                          },
                        ),
                        onTap: () => imagePickerMethod(ImageSource.gallery),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.teal.shade600,
                        ),
                        child: const Icon(Icons.camera_alt_outlined,
                            color: Colors.white70, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),

                // Form Fields
                Form(
                  key: _formKey,
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
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Eneter an email';
                          }

                          bool emailValid = RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(value!);
                          if (emailValid == false) {
                            return 'Enter valid Email';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Eneter valid Phone Number';
                          }

                          bool validPhone =
                              RegExp(r'^01[3-9][0-9]{8}$').hasMatch(value!);

                          /// 11 digit and start with 019,017,018 etc
                          if (validPhone == false) {
                            return 'Enter valid Phone Number';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.fingerprint),
                          suffixIcon: IconButton(
                            icon: Icon(obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              togglePasswordVisibility();
                            },
                          ),
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Eneter a Password';
                          }
                          if (value!.length < 6) {
                            return 'Enter Password more than 6 letters';
                          }
                          bool passwordRegex = RegExp(
                                  r'^(?!.*(.).*\1)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$&*~]).{6,}$')
                              .hasMatch(value);
                          if (passwordRegex == false) {
                            return 'Enter Strong Password';
                          }

                          return null;
                        },
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
                            if (_formKey.currentState!.validate()) {
                              addUserDetails();
                              addUserProfilePicture();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfile()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 4.0,
                            backgroundColor: Colors.teal.shade600,
                            fixedSize: Size(350.0, 50.0),
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
                            "Time : ${DateTime.now()}",
                            style: TextStyle(fontSize: 12),
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
      ),
    );
  }

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }
}
