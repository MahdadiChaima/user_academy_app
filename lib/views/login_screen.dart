import 'package:concordia_user/views/signup_screen.dart';
import 'package:concordia_user/widgets/custom_button.dart';
import 'package:concordia_user/widgets/custom_text.dart';
import 'package:concordia_user/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/login_controller.dart';
import '../widgets/custom_decorative_circles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final AuthController authController = Get.put(AuthController());
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          DecorativeCircles(mediaQuery: mediaQuery),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * 0.08,
                vertical: mediaQuery.height * 0.06,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: mediaQuery.height * 0.02),

                  // DropdownButton aligned right at the top
                  SizedBox(height: mediaQuery.height * 0.09),

                  CustomText(
                    text: 'login'.tr,
                    type: TextType.title,
                    color: const Color(0xFF1F41BB),
                    alignCenter: true,
                  ),
                  SizedBox(height: mediaQuery.height * 0.02),

                  CustomText(
                    text: 'welcome_back'.tr,
                    type: TextType.subtitle,
                    color: Colors.black,
                    alignCenter: true,
                  ),

                  SizedBox(height: mediaQuery.height * 0.1),

                  CustomTextField(
                    hintText: 'email'.tr,
                    controller: controller.emailController,
                  ),

                  SizedBox(height: mediaQuery.height * 0.02),
                  CustomTextField(
                    hintText: 'password'.tr,
                    controller: controller.passwordController,
                    isPassword: true,
                    obscureText: authController.isPasswordHidden,
                  ),
                  SizedBox(height: mediaQuery.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                            title: 'forget_password'.tr,
                            content: Column(
                              children: [
                                CustomTextField(
                                  hintText: 'email'.tr,
                                  controller: controller.emailController,
                                ),
                                const SizedBox(height: 20),
                                CustomButton(
                                  text: 'send_reset_link'.tr,
                                  onPressed: () async {
                                    await controller.resetPassword();
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: CustomText(
                          text: 'forget_password'.tr,
                          type: TextType.body,
                          color: const Color(0xFF1F41BB),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: mediaQuery.height * 0.15),
                  CustomButton(
                    text: "login".tr,
                    onPressed: () async {
                      await authController.signIn(
                        controller.emailController.text.trim(),
                        controller.passwordController.text.trim(),
                      );
                      print('✅ account verified');
                    },
                    //width: mediaQuery.width * 0.4,
                    height: mediaQuery.width * 0.15,
                  ),
                  SizedBox(height: mediaQuery.height * 0.02),
                  GestureDetector(
                    onTap: () {
                      Get.to(SignUpScreen());
                    },
                    child: CustomText(
                      text: 'create_new_account'.tr,
                      type: TextType.body,
                      //color: const Color(0xFF1F41BB),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
