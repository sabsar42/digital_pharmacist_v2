import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/upload_profile_image_contoller.dart';

class UserProfileCircleAvatar extends StatefulWidget {
  @override
  State<UserProfileCircleAvatar> createState() => _UserProfileCircleAvatarState();
}

class _UserProfileCircleAvatarState extends State<UserProfileCircleAvatar> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowUserProfileImageController>(
      builder: (controller) {
        final profileImageUrl = controller.profileImageUrl;

        return Container(
          height: 200,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
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
    );
  }
}