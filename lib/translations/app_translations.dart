import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      //******************************************** LOGIN SCREEN ********************************************
      'login': 'Login',
      'sign_in': 'Sign In',
      'welcome_back': "Welcome back, you've been missed!",
      'email': 'Email',
      'password': 'Password',
      'forget_password': 'Forgot password?',
      'login_failed': 'Login failed, please try again.',
      'invalid_email': 'Invalid email address.',
      'success': 'Success',
      'invalid_credential': 'The provided login credentials are invalid.',

      //******************************************** SIGNUP SCREEN ********************************************
      'signup': 'Sign Up',
      'sign_up': 'Sign Up',
      'create_account': 'Create Account',
      'create_account_subtitle': 'Create an account so you can join us to access your courses',
      'create_new_account': 'Create new account',
      'first_name': 'First Name',
      'last_name': 'Last Name',
      'age': 'Age',
      'address': 'Address',
      'number': 'Phone Number',
      'error_first_name': 'First name must not exceed 10 characters.',
      'error_last_name': 'Last name must not exceed 10 characters.',
      'error_phone': 'Phone number must be 10 digits.',
      'error_email': 'Invalid email format.',
      'error_password': 'Password must be 8+ characters, upper/lower case, number, and special char.',
      'error_email_exists': 'Email is already in use.',
      'account_created_successfully': 'Account created successfully!',
      'already_have_account': 'Already have an account?',

      //******************************************** GENERAL / COMMON ********************************************
      'change_lang': 'Change Language',
      'error': 'Error',
      'password_reset_sent': 'Password reset link sent to your email.',

      //******************************************** WELCOME SCREEN ********************************************
      'welcome_tit': 'Welcome to\n Concordia',
      'welcome_subtitle': 'Access your courses \nYour academic life, organized.',
    },
    'ar': {
      //******************************************** LOGIN SCREEN ********************************************
      'login': 'تسجيل الدخول',
      'sign_in': 'تسجيل الدخول',
      'welcome_back': "مرحبًا بعودتك، لقد اشتقنا إليك!",
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'forget_password': 'نسيت كلمة المرور؟',
      'login_failed': 'فشل تسجيل الدخول، حاول مرة أخرى.',
      'invalid_email': 'عنوان البريد الإلكتروني غير صالح.',
      'success': 'تم بنجاح',
      'invalid_credential': 'بيانات تسجيل الدخول غير صحيحة.',

      //******************************************** SIGNUP SCREEN ********************************************
      'signup': 'إنشاء حساب',
      'sign_up': 'إنشاء حساب',
      'create_account': 'إنشاء حساب',
      'create_account_subtitle': 'أنشئ حسابًا حتى تتمكن من الانضمام إلينا والوصول إلى كورساتك',
      'create_new_account': 'إنشاء حساب جديد',
      'first_name': 'الاسم',
      'last_name': 'اللقب',
      'age': 'العمر',
      'address': 'العنوان',
      'number': 'رقم الهاتف',
      'error_first_name': 'يجب ألا يتجاوز الاسم الأول 10 أحرف.',
      'error_last_name': 'يجب ألا يتجاوز الاسم الأخير 10 أحرف.',
      'error_phone': 'رقم الهاتف يجب أن يتكون من 10 أرقام.',
      'error_email': 'صيغة البريد الإلكتروني غير صحيحة.',
      'error_password': 'كلمة المرور يجب أن تحتوي على 8 أحرف على الأقل، بحروف كبيرة وصغيرة، رقم ورمز.',
      'error_email_exists': 'البريد الإلكتروني مستخدم بالفعل.',
      'account_created_successfully': 'تم إنشاء الحساب بنجاح!',
      'already_have_account': 'لديك حساب بالفعل؟',

      //******************************************** GENERAL / COMMON ********************************************
      'change_lang': 'تغيير اللغة',
      'error': 'خطأ',
      'password_reset_sent': 'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك.',

      //******************************************** WELCOME SCREEN ********************************************
      'welcome_tit': 'مرحبًا بك في\n كونكورديا',
      'welcome_subtitle': 'تابع كورساتك\n ورتّب حياتك الأكاديمية.',
    },
  };
}
