import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:luckyman_managers_app/Model/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  RxString userDocRef = ''.obs;

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnaphot(e)).single;

    return userData;
  }

   
}
