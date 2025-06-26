import 'package:concordia_user/services/init_services.dart';
import 'package:concordia_user/views/course_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'views/home_screen.dart';
import 'views/login_screen.dart';
import 'views/signup_screen.dart';
import 'views/welcome_screen.dart';
import 'bindings/home_binding.dart';
import 'translations/app_translations.dart';

void main() {
  runApp(const InitApp());
}

/// هذا الـ Widget يظهر شاشة تحميل أثناء تهيئة الخدمات
class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _initializeApp(),
      builder: (context, snapshot) {
        // أثناء التحميل
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        // بعد الانتهاء: تشغيل التطبيق الحقيقي مع userId
        return MyApp(userId: snapshot.data);
      },
    );
  }

  Future<String?> _initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await initServices(); // ترجع userId
  }
}

class MyApp extends StatelessWidget {
  final String? userId;
  const MyApp({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Concordia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: Get.locale?.languageCode == 'ar' ? 'NotoSansArabic' : 'Poppins',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 22),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      locale: Get.deviceLocale ?? const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      fallbackLocale: const Locale('en'),
      translations: AppTranslations(),
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: '/signup',
          page: () => const SignUpScreen(),
        ),
      ],
      home: userId != null ? HomeScreen() : const WelcomeScreen(),
    );
  }
}
