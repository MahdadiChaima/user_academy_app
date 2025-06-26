import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/child_model.dart';
import '../services/firestore_child_service.dart';
import 'auth_controller.dart';

class ChildController extends GetxController {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var children = <ChildModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchChildren(); // تحميل الأطفال عند بدء التشغيل
  }

  Future<void> fetchChildren() async {
    final userId = Get.find<AuthController>().userId;

    if (userId == null || userId.isEmpty) {
      print("⚠️ userId is null or empty. Children not fetched.");
      return;
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('children')
        .get();

    children.value = snapshot.docs
        .map((doc) => ChildModel.fromMap(doc.data(), id: doc.id))
        .toList();

    print("✅ ${children.length} children fetched.");
  }
  void addChild() async {
    if (formKey.currentState!.validate()) {
      final child = ChildModel(
        name: nameController.text.trim(),
        age: int.tryParse(ageController.text.trim()) ?? 0,
      );

      final userId = Get.find<AuthController>().userId;
      if (userId == null || userId.isEmpty) return;

      final collectionRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('children');

      // توليد id تلقائي عن طريق add()
      await collectionRef.add(child.toMap());

      await fetchChildren();

      nameController.clear();
      ageController.clear();

      Get.back();
      Get.snackbar('تمت الإضافة', 'تمت إضافة الطفل بنجاح');
    }
  }


}
