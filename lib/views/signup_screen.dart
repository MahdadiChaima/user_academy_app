import 'package:concordia_user/widgets/custom_button.dart';
import 'package:concordia_user/widgets/custom_text.dart';
import 'package:concordia_user/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/singup_controller.dart';
import '../widgets/custom_decorative_circles.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final AuthController authController = Get.put(AuthController());
    final SignUpController controller = Get.put(SignUpController());

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
                  SizedBox(height: mediaQuery.height * 0.09),

                  CustomText(
                    text: "create_account".tr,
                    type: TextType.title,
                    color: const Color(0xFF1F41BB),
                    alignCenter: true,
                  ),
                  SizedBox(height: mediaQuery.height * 0.02),

                  CustomText(
                    text: "create_account_subtitle".tr,
                    type: TextType.subtitle,
                    color: Colors.black,
                    alignCenter: true,
                  ),

                  SizedBox(height: mediaQuery.height * 0.1),
                  CustomTextField(
                    hintText: "first_name".tr,
                    controller: controller.firstNameController,
                  ),
                  SizedBox(height: mediaQuery.height * 0.02),
                  CustomTextField(
                    hintText: "last_name".tr,
                    controller: controller.lastNameController,
                  ),


                  SizedBox(height: mediaQuery.height * 0.02),

                  CustomTextField(
                    hintText: "address".tr,
                   controller: controller.addressController,
                  ),

                  SizedBox(height: mediaQuery.height * 0.02),
                  CustomTextField(
                    hintText: "number".tr,
                    controller: controller.phoneNumberController,
                  ),

                  SizedBox(height: mediaQuery.height * 0.02),
                  CustomTextField(
                    hintText: "email".tr,
                    controller: controller.emailController,
                  ),

                  SizedBox(height: mediaQuery.height * 0.02),
                  CustomTextField(
                    hintText: "password".tr,
                    controller: controller.passwordController,
                    isPassword: true,
                    obscureText: authController.isPasswordHidden,
                  ),


                  SizedBox(height: mediaQuery.height * 0.06),
                  CustomButton(
                    text: "signup".tr,
                    onPressed: () async {
                      print('lastName!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                      print(controller.lastNameController.toString());
                      await  controller.signUp();
                      print('lastName***************************************');
                      print(controller.lastNameController.toString());
                      print('✅ account verified');
                    },
                    height: mediaQuery.width * 0.15,
                  ),
                  SizedBox(height: mediaQuery.height * 0.02),
                  GestureDetector(
                    onTap: () {
                      Get.to(LoginScreen());
                    },
                    child: CustomText(
                      text: "already_have_account".tr,
                      type: TextType.body,
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
