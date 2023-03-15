
import 'package:get/get.dart';

import 'user_repository.dart';


class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _userRepo = Get.put(UserRepository());

  getUserData(email) {
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar('Error', 'Login to continue');
    }
  }
}
