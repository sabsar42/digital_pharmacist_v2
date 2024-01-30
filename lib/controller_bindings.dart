import 'package:get/get.dart';

import 'User_Profile/controller/upload_profile_image_contoller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
  Get.put(ShowUserProfileImageController());
  }
}
