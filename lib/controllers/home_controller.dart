import 'package:get/get.dart';
import '../../../models/child_model.dart';

class HomeController extends GetxController {
  var children = <ChildModel>[].obs;

  void addChild(ChildModel child) {
    children.add(child);
  }

  bool get hasChildren => children.isNotEmpty;
}
