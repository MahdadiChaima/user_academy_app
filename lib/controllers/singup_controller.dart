import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_snack_bar.dart';
import 'auth_controller.dart';


class SignUpController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePassword = true.obs;

  final authController = Get.find<AuthController>();

  Future<void> signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final address = addressController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();

    if (firstName.length > 10) {
      showCustomSnackBar(title: "error".tr, message: 'error_first_name'.tr);
      return;
    }

    if (lastName.length > 10) {
      showCustomSnackBar(title: "error".tr, message: 'error_last_name'.tr);
      return;
    }

    if (!RegExp(r'^\d{10}\$').hasMatch(phoneNumber)) {
      showCustomSnackBar(title: "error".tr, message: 'error_phone'.tr);
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$').hasMatch(email)) {
      showCustomSnackBar(title: "error".tr, message: 'error_email'.tr);
      return;
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\\$&*~]).{8,}\$').hasMatch(password)) {
      showCustomSnackBar(title: "error".tr, message: 'error_password'.tr);
      return;
    }

    await authController.signUp(
      email: email,
      password: password,
      phone: phoneNumber,
      address: address,
      firstName: firstName,
      lastName: lastName,
    );

  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
