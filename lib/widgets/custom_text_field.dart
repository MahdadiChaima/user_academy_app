import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final RxBool? obscureText;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isPassword && obscureText != null) {
      return Obx(() => TextField(
        controller: controller,
        obscureText: obscureText!.value,

        decoration: InputDecoration(
          hintText: hintText,
          fillColor: const Color(0xFFF1F4FF),
          filled: true,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF1F41BB),
              width: 2,
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText!.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              obscureText!.toggle();
            },
          ),
        ),
      ));
    } else {
      return TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: const Color(0xFFF1F4FF),
          filled: true,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF1F41BB),
              width: 2,
            ),
          ),
        ),
      );
    }
  }
}
