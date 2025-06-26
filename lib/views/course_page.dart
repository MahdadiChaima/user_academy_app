import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ===== MODEL =====
class Course {
  final String id;
  final String title;
  final String type;
  final bool isPaid;
  final bool isFavourite;
  final List<String> paidBy;
  final bool isPaidForUser;

  Course({
    required this.id,
    required this.title,
    required this.type,
    required this.isPaid,
    required this.isFavourite,
    required this.paidBy,
    required this.isPaidForUser,
  });

  factory Course.fromFirestore(DocumentSnapshot doc, List<String> childrenIds) {
    final data = doc.data() as Map<String, dynamic>;
    final paidByList = List<String>.from(data['paidBy'] ?? []);
    final isPaidForUser = childrenIds.any((id) => paidByList.contains(id));

    return Course(
      id: doc.id,
      title: data['title'] ?? '',
      type: data['type'] ?? 'adult',
      isPaid: data['isPaid'] ?? false,
      isFavourite: data['isFavourite'] ?? false,
      paidBy: paidByList,
      isPaidForUser: isPaidForUser,
    );
  }
}

// ===== CONTROLLER =====
class CourseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Course> allCourses = <Course>[].obs;
  RxString selectedTab = 'All'.obs;
  RxString selectedType = 'adult'.obs;

  List<String> get childrenIds =>
      Get.find<AuthController>().children.map((c) => c.id).toList();

  @override
  void onInit() {
    fetchCourses();
    super.onInit();
  }

  void fetchCourses() {
    _firestore.collection('courses').snapshots().listen((snapshot) {
      final courses = snapshot.docs
          .map((doc) => Course.fromFirestore(doc, childrenIds))
          .toList();
      allCourses.assignAll(courses);
    });
  }

  void setTab(String tab) => selectedTab.value = tab;
  void setType(String type) => selectedType.value = type;


  List<Course> get filteredCourses {
    return allCourses.where((course) {
      if (course.type != selectedType.value) return false;
      if (selectedTab.value == 'Paid') return course.isPaidForUser;
      if (selectedTab.value == 'Favourites') return course.isFavourite;
      return true;
    }).toList();
  }
}

// ===== AUTH CONTROLLER STUB (replace with your real AuthController) =====
class AuthController extends GetxController {
  var children = [
    Child(id: 'child123', name: 'Ali'),
    Child(id: 'child456', name: 'Aya'),
  ];
}

class Child {
  final String id;
  final String name;
  Child({required this.id, required this.name});
}

// ===== UI VIEW =====
class CoursesPage extends StatelessWidget {
  final CourseController controller = Get.put(CourseController());
  final List<String> tabs = ['All', 'Paid', 'Favourites'];
  final List<String> types = ['adult', 'children'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Courses')),
      body: Column(
        children: [
          // Tabs
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tabs.map((tab) {
              final isSelected = controller.selectedTab.value == tab;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(tab),
                  selected: isSelected,
                  onSelected: (_) => controller.setTab(tab),
                ),
              );
            }).toList(),
          )),
          // Dropdown
          Obx(() => DropdownButton<String>(
            value: controller.selectedType.value,
            items: types.map((type) {
              return DropdownMenuItem(value: type, child: Text(type));
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                controller.setType(value);
              }
            },
          )),
          // Courses
          Expanded(
            child: Obx(() {
              final filtered = controller.filteredCourses;
              if (filtered.isEmpty) return Center(child: Text('No courses'));
              return ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final course = filtered[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(course.title),
                      subtitle: Text(
                          'Type: ${course.type}, Paid: ${course.isPaidForUser ? "Yes (for your child)" : "No"}'),
                      trailing: Icon(course.isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
