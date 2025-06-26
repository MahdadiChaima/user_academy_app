import 'package:concordia_user/views/course_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_child_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_header_background.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.find();
  final ChildController childController = Get.find();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFF8F9FF), // خلفية عامة موحدة
      body: SafeArea(
        child: SingleChildScrollView(
          child: CustomHeaderBackground(child:SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 160),
                Obx(() {
                  return Column(
                    children: [
                      if (childController.children.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('لا يوجد أطفال بعد'),
                        )
                      else
                        ...childController.children.map((child) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              child.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),

                      const SizedBox(height: 10),

                      // 🔵 زر إضافة طفل
                      ElevatedButton.icon(
                        onPressed: () {
                          _showAddChildBottomSheet(context);
                        },
                        icon: Icon(Icons.add),
                        label: Text('إضافة طفل'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 20),
                _buildOptionCard(
                  imagePath: 'assets/images/courses_home.png',
                  label: 'Courses',
                  onTap: () {
                    Get.to(CourseScreen());
                  },
                ),
                const SizedBox(height: 20),
                _buildOptionCard(
                  imagePath: 'assets/images/workshop_home.png',
                  label: 'Workshop',
                  onTap: () {},
                ),
              ],
            ),
          ), ))),
              // الدائرة الكبيرة في الخلف


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
        ],
      ),
    );
  }

  void _showAddChildBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Form(
          key: childController.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: childController.nameController,
                decoration: InputDecoration(labelText: 'اسم الطفل'),
                validator: (value) => value!.isEmpty ? 'أدخل الاسم' : null,
              ),
              TextFormField(
                controller: childController.ageController,
                decoration: InputDecoration(labelText: 'العمر'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'أدخل العمر' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: childController.addChild,
                child: Text('إضافة الطفل'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: back icon & greeting
          Row(
            children: [
              SizedBox(width: 8),
              Text(
                'Hi   ${authController.userModel.value?.firstName ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          // Right side: notification & profile pic
          Row(
            children: [
              Stack(
                children: const [
                  Icon(Icons.notifications, size: 28),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(radius: 5, backgroundColor: Colors.red),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(imagePath, height: 60),
            const SizedBox(width: 20),
            Text(
              label,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

/// ✅ هذا هو الـ Custom Widget للدائرة العلوية

/*
  @override
  Widget build(BuildContext context) {
  if (!Get.isRegistered<ChildController>()) {
  Get.lazyPut(() => ChildController());
  }

  return Scaffold(
      appBar: AppBar(
        title: Text('مرحبا 👋'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => Get.toNamed('/notifications'),
          ),
        ],
      ),
      body: Obx(() {
        if (!controller.hasChildren) {
          return Column(
            children:[

              SizedBox(height: 220),
              ElevatedButton.icon(
              onPressed: () {
                Get.bottomSheet(
                  AddChildBottomSheet(),
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                );
              },
              icon: Icon(Icons.add),
              label: Text('أضف طفل'),
            ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Get.toNamed('/workshops'),
                    icon: Icon(Icons.work),
                    label: Text('Workshops'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Get.toNamed('/courses'),
                    icon: Icon(Icons.school),
                    label: Text('Courses'),
                  ),
                ],
              ),
          ]);
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('أطفالك:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 100, child: _buildChildrenList(controller)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => Get.toNamed('/workshops'),
                      icon: Icon(Icons.work),
                      label: Text('Workshops'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Get.toNamed('/courses'),
                      icon: Icon(Icons.school),
                      label: Text('Courses'),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            // Stay on Home
          } else if (index == 1) {
            Get.toNamed('/liked-courses');
          } else if (index == 2) {
            Get.toNamed('/profile');
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Liked'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildChildrenList(HomeController controller) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: controller.children.length,
      itemBuilder: (context, index) {
        final child = controller.children[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text(child.name)),
          ),
        );
      },
    );
  }
}
*/
