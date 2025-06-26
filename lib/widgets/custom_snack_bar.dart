import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar({
  required String title,
  required String message,
  bool isError = true,
}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: isError ? Colors.red.shade300 : Colors.green.shade300,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 3),
    borderRadius: 12,
  );
}
