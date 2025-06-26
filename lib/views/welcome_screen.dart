import 'package:concordia_user/views/login_screen.dart';
import 'package:concordia_user/views/signup_screen.dart';
import 'package:concordia_user/widgets/custom_button.dart';
import 'package:concordia_user/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/welcome_controller.dart';
import '../widgets/custom_decorative_circles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final controller = Get.put(WelcomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          DecorativeCircles(mediaQuery: mediaQuery),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * 0.06,
                vertical: mediaQuery.height * 0.06,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: mediaQuery.height * 0.02),

                  // DropdownButton aligned right at the top
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(() => DropdownButton<String>(
                        value: controller.selectedLang.value,
                        dropdownColor: Colors.white,
                        items: const [
                          DropdownMenuItem(value: 'en', child: Text("🇬🇧 English",style: TextStyle(fontWeight:FontWeight.w600 ),)),
                          DropdownMenuItem(value: 'ar', child: Text("🇸🇦 العربية")),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            controller.changeLanguage(value);
                          }
                        },
                      )),
                    ],
                  ),

                  SizedBox(height: mediaQuery.height * 0.04),

                  Image.asset(
                    'assets/images/welcome.png',
                    height: mediaQuery.height * 0.4,
                  ),

                  SizedBox(height: mediaQuery.height * 0.04),

                  CustomText(
                    text: "welcome_tit".tr,
                    type: TextType.title,
                    color: const Color(0xFF1F41BB),
                    alignCenter: true,
                  ),

                  SizedBox(height: mediaQuery.height * 0.015),

                  Center(
                    child: CustomText(
                      text: "welcome_subtitle".tr,
                      type: TextType.subtitle,
                      alignCenter: true,
                    ),
                  ),

                  SizedBox(height: mediaQuery.height * 0.05),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        text: "login".tr,
                        onPressed: () {
                          Get.to(LoginScreen());
                        },
                        width: mediaQuery.width * 0.4,
                        height:mediaQuery.width * 0.15 ,
                      ),
                      SizedBox(width: mediaQuery.width * 0.04),
                      CustomButton(
                        text: "signup".tr,
                        onPressed: () {
                          Get.to(SignUpScreen());
                        },
                        width: mediaQuery.width * 0.4,
                        height:mediaQuery.width * 0.15 ,
                        color: Colors.grey,
                      ),
                    ],
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
