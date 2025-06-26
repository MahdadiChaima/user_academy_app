import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../services/firebase_auth_service.dart';
import '../widgets/custom_snack_bar.dart';

class AuthController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rxn<User> user = Rxn<User>();
  Rxn<UserModel> userModel = Rxn<UserModel>();
  var isPasswordHidden = true.obs;

  @override
  void onInit() {
    user.bindStream(_authService.userChanges);
    super.onInit();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  String get userId => user.value?.uid ?? '';

  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
  }) async {
    try {
      final userCred = await _authService.signUp(email, password);
      if (userCred != null) {
        final newUser = UserModel(
          uid: userCred.uid,
          email: email,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          address: address,
        );

        await _authService.saveUserData(newUser);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userCred.uid);

        showCustomSnackBar(
          title: 'success'.tr,
          message: 'account_created_successfully'.tr,
          isError: false,
        );

        Get.offAllNamed('/home');
      }
    } catch (e) {
      showCustomSnackBar(title: 'error'.tr, message: e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', _auth.currentUser!.uid);

      showCustomSnackBar(
        title: 'success'.tr,
        message: 'login'.tr,
        isError: false,
      );

      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          showCustomSnackBar(title: 'error'.tr, message: 'invalid_credential'.tr);
          break;
        case 'invalid-email':
          showCustomSnackBar(title: 'error'.tr, message: 'invalid_email'.tr);
          break;
        default:
          showCustomSnackBar(title: 'error'.tr, message: 'login_failed'.tr);
      }
    } catch (_) {
      showCustomSnackBar(title: 'error'.tr, message: 'login_failed'.tr);
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    Get.offAllNamed('/auth');
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showCustomSnackBar(
        title: 'success'.tr,
        message: 'reset_email_sent'.tr,
        isError: false,
      );
    } catch (e) {
      showCustomSnackBar(title: 'error'.tr, message: e.toString());
    }
  }

  Future<void> loadUserModel(String uid) async {
    final userData = await _authService.getUserData(uid);
    if (userData != null) {
      userModel.value = userData;
    }
  }

  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('userId');
    if (uid != null) {
      await loadUserModel(uid);
    }
  }
}
