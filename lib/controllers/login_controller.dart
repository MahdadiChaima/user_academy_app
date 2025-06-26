import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_snack_bar.dart';
import 'auth_controller.dart';


class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePassword = true.obs;

  final authController = Get.find<AuthController>();

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    authController.signIn(email, password);
  }

  Future<void> resetPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      showCustomSnackBar(title: 'error'.tr, message: 'error_email'.tr);
      return;
    }

    try {
      await authController.resetPassword(email);
      // ملاحظة: تمت إضافة Snackbar في `AuthController.resetPassword`
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showCustomSnackBar(title: 'error'.tr, message: 'user_not_found'.tr);
      } else {
        showCustomSnackBar(title: 'error'.tr, message: 'login_failed'.tr);
      }
    } catch (_) {
      showCustomSnackBar(title: 'error'.tr, message: 'login_failed'.tr);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
