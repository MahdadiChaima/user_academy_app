import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'custom_top_half_circle.dart';

class CustomHeaderBackground extends StatelessWidget {
  final Widget child;
  final double topPadding;

  const CustomHeaderBackground({
    super.key,
    required this.child,
    this.topPadding = 40,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Stack(
      children: [
        const TopHalfCircle(),
        Positioned(
          top: topPadding,
          left: 0,
          right: 0,
          child: _buildHeader(authController),
        ),
        Padding(
          padding: EdgeInsets.only(top:20),
          child: child,
        ),
      ],
    );
  }

  Widget _buildHeader(AuthController authController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 8),
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 22,
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),
              const SizedBox(width: 18),
              Text(
                'Hi ${authController.userModel.value?.firstName ?? ''}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const Stack(
            children: [
              Icon(Icons.notifications, size: 28),
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
