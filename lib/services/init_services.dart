import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/add_child_controller.dart';
import '../firebase_options.dart';

Future<String?> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inject controllers
  Get.put(AuthController());
  Get.put(HomeController());
  Get.lazyPut(() => ChildController());

  // Load user ID from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('userId');

  // Load user model if user is logged in
  if (userId != null) {
    await Get.find<AuthController>().loadUserModel(userId);
  }

  return userId; // ✅ هذا يجب أن يكون موجود
}
