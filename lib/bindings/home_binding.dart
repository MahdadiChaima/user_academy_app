import 'package:get/get.dart';
import '../controllers/add_child_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/auth_controller.dart'; // ✅ تأكدي من استيراده

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController()); // ✅ أضف هذا أولًا
    Get.put(HomeController());
    Get.put(ChildController());
  }
}
