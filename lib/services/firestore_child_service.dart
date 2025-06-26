import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../models/child_model.dart';

class ChildService {
  static Future<void> addChild(ChildModel child) async {
    final authController = Get.find<AuthController>();
    final userId = authController.userId;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('children')
        .add(child.toMap());
  }
}

