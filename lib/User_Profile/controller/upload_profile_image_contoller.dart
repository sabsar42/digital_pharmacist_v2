import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ShowUserProfileImageController extends GetxController {
  File? _image;
  final imagePicker = ImagePicker();
  late User currentUser;

  String? userID;
  String? _profileImageUrl;

  String? get profileImageUrl => _profileImageUrl;

  @override
  void onInit() {
    super.onInit();
    loadUserImageData();
  }

  Future<void> loadUserImageData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = user;
      String userID = currentUser.uid;
      print(userID);
      var userDoc =
      await FirebaseFirestore.instance.collection('users').doc(userID).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData =
        userDoc.data() as Map<String, dynamic>;
        _profileImageUrl =
            userData['user_profile_picture'] ?? 'No Image';
        update();
      }
    }
  }
}
