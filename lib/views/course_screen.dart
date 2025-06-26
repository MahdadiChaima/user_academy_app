import 'package:concordia_user/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/custom_header_background.dart';


class CourseScreen extends StatelessWidget {
  final CourseController controller = Get.put(CourseController());

  CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
        ],
      ),
      body: SafeArea(
        child: CustomHeaderBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header
                SizedBox(height: 150),

                // Search bar
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search courses...',
                      hintStyle: TextStyle(color: Colors.blue),
                      border: InputBorder.none,
                      suffixIcon: Obx(() {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Search icon
                            IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                controller.searchQuery.value =
                                    controller.searchController.text;
                                controller.isSearchPressed.value = true;
                              },
                            ),
                            // Close icon (only if search is active)
                            if (controller.isSearchPressed.value)
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  controller.searchController.clear();
                                  controller.searchQuery.value = '';
                                  controller.isSearchPressed.value = false;
                                },
                              ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),
                Obx(() {
                  if (!controller.isSearchPressed.value) {
                    return SizedBox(); // لا شيء يُعرض قبل الضغط على البحث
                  }

                  final results = controller.searchedAndFilteredCourses;

                  if (results.isEmpty) {
                    return const Center(child: Text('No courses found.'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      final course = results[i];
                      return ListTile(
                        title: Text(course.title),
                        subtitle: Text(course.description),
                        onTap: () {
                          // Action on tap
                        },
                      );
                    },
                  );
                }),

                // Tabs
            Obx(() {
      return controller.isSearchPressed.value
          ? SizedBox()
          : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // DropdownButton
                      Container(
                        height: screenHeight * 0.055,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color:
                              controller.selectedFilter.value == 'all'
                                  ? Colors.blue
                                  : Colors.grey.shade200,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 0.1),
                            ),
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            alignment: Alignment.center,
                            value: controller.selectedType.value,
                            dropdownColor: Colors.white,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color:
                                  controller.selectedFilter.value == 'all'
                                      ? Colors.white
                                      : Colors.black,
                            ),
                            onChanged: (val) {
                              controller.changeType(val!);
                            },
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              height: 2.5,
                              fontSize: screenWidth * 0.035,
                            ),
                            selectedItemBuilder: (BuildContext context) {
                              return controller.types.map((type) {
                                return Text(
                                  type,
                                  style: TextStyle(
                                    color:
                                        controller.selectedFilter.value == 'all'
                                            ? Colors.white
                                            : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.035,
                                  ),
                                );
                              }).toList();
                            },
                            items:
                                controller.types.map((type) {
                                  return DropdownMenuItem(
                                    value: type,
                                    child: Text(type),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),

                      // Paid Button
                      _filterButton(
                        label: 'Paid',
                        selected: controller.selectedFilter.value == 'paid',
                        onPressed: () => controller.changeFilter('paid'),
                        fontSize: screenWidth * 0.035,
                      ),

                      // Favourites Button
                      _filterButton(
                        label: 'Favourites',
                        selected:
                            controller.selectedFilter.value == 'favourites',
                        onPressed: () => controller.changeFilter('favourites'),
                        fontSize: screenWidth * 0.035,
                      ),
                    ],
                  );}
                ),

                SizedBox(height: screenHeight * 0.015),

                // Courses List
                SizedBox(
                  height: screenHeight * 0.6,
                  child: Obx(() {
                    if (controller.isSearchPressed.value) return SizedBox();
                    final courses = controller.filteredCourses;
                    final filter = controller.selectedFilter.value;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 90),
                      child: ListView.builder(
                        itemCount: courses.length,
                        itemBuilder:
                            (_, i) => CourseCard(
                              course: courses[i],
                              selectedFilter: filter,
                            ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for the text buttons (Paid, Favourites)
  Widget _filterButton({
    required String label,
    required bool selected,
    required VoidCallback onPressed,
    required double fontSize,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: selected ? Colors.blue : Colors.grey.shade200,
        foregroundColor: selected ? Colors.white : Colors.black,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class CourseCard extends StatefulWidget {
  final Course course;
  final String selectedFilter;

  CourseCard({super.key, required this.course, required this.selectedFilter});

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  final CourseController controller = Get.find();
  List<String>? paidChildren;

  @override
  void initState() {
    super.initState();
    if (widget.course.isPaid) {
      controller.getPaidChildrenForCourse(widget.course.id).then((names) {
        setState(() {
          paidChildren = names;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    IconData trailingIcon =
        widget.selectedFilter == 'paid' ? Icons.access_time : Icons.favorite;

    return Card(
      color: const Color(0xFFF1F4FE),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text('Course: ${widget.course.title}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${widget.course.description}'),
            Text('Teacher: ${widget.course.teacherName}'),
            Text('Type: ${widget.course.type}'),
            Text('Paid: ${widget.course.isPaid ? "Yes" : "No"}'),
            Text(
              'Levels: ${widget.course.levels.map((e) => e.title).join(', ')}',
            ),
            if (widget.course.isPaid) ...[
              const SizedBox(height: 8),
              Text(
                'Children who paid:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              if (paidChildren == null)
                const CircularProgressIndicator()
              else if (paidChildren!.isEmpty)
                Text('No children paid yet.')
              else
                ...paidChildren!.map((name) => Text("- $name")),
            ],
          ],
        ),
        trailing:
            widget.selectedFilter == 'favourites' ||
                    trailingIcon == Icons.favorite
                ? Obx(() {
                  final isFav =
                      controller.allCourses
                          .firstWhere((c) => c.id == widget.course.id)
                          .isFavourite;
                  return IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: isFav ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      controller.toggleFavourite(widget.course.id);
                    },
                  );
                })
                : Icon(trailingIcon, color: Colors.grey),
      ),
    );
  }
}

class CourseController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final isSearchPressed = false.obs;

  final searchQuery = ''.obs;

  List<Course> searchCourses(String query) {
    return filteredCourses.where((course) {
      final lowerQuery = query.toLowerCase();
      return course.title.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  List<Course> get searchedAndFilteredCourses {
    return allCourses.where((c) {
      final matchesType =
          selectedType.value == 'all' ||
          c.type.toLowerCase() == selectedType.value;

      final matchesFilter =
          selectedFilter.value == 'paid'
              ? c.isPaid
              : selectedFilter.value == 'favourites'
              ? c.isFavourite
              : true;

      final matchesSearch =
          searchQuery.value.isEmpty ||
          c.title.toLowerCase().contains(searchQuery.value.toLowerCase());

      return matchesType && matchesFilter && matchesSearch;
    }).toList();
  }

  RxString selectedFilter = 'all'.obs;
  RxString selectedType = 'all'.obs;

  List<String> types = ['all', 'adult', 'children'];

  RxList<Course> allCourses = <Course>[].obs;
  Future<void> addCourse(Course course) async {
    try {
      await FirebaseFirestore.instance.collection('courses').add({
        'title': course.title,
        'description': course.description,
        'type': course.type.toLowerCase(),
        'isPaid': course.isPaid,
        'imageUrl': course.imageUrl,
        'teacherName': course.teacherName,
        'isFavouriteBy': [], // initially no favourites
        'levels':
            course.levels
                .map(
                  (level) => {
                    'levelId': level.levelId,
                    'title': level.title,
                    'description': level.description,
                  },
                )
                .toList(),
      });

      // Refresh course list
      fetchCoursesFromFirestore();
    } catch (e) {
      print("Failed to add course: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCoursesFromFirestore();
  }

  Future<List<String>> getPaidChildrenForCourse(String courseId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final querySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('payments')
            .where('courseId', isEqualTo: courseId)
            .where('status', isEqualTo: 'paid')
            .get();

    // استخراج الأسماء
    return querySnapshot.docs.map((doc) => doc['childName'] as String).toList();
  }

  void fetchCoursesFromFirestore() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('courses').get();
    final userId =
        Get.find<AuthController>()
            .userModel
            .value
            ?.uid; // Replace this with the current user's ID

    allCourses.value =
        snapshot.docs.map((doc) => Course.fromFirestore(doc, userId!)).toList();
  }

  List<Course> get filteredCourses {
    return allCourses.where((c) {
      final matchesType =
          selectedType.value == 'all' ||
          c.type.toLowerCase() == selectedType.value;
      if (selectedFilter.value == 'paid') {
        return c.isPaid && matchesType;
      } else if (selectedFilter.value == 'favourites') {
        return c.isFavourite && matchesType;
      }
      return matchesType;
    }).toList();
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
  }

  void changeType(String type) {
    selectedType.value = type;
    selectedFilter.value = 'all';
  }

  void toggleFavourite(String courseId) async {
    // Find index of course in list
    int index = allCourses.indexWhere((c) => c.id == courseId);
    if (index == -1) return;

    Course course = allCourses[index];
    final userId =
        Get.find<AuthController>()
            .userModel
            .value
            ?.uid; // Replace with current user ID

    final docRef = FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId);

    try {
      if (course.isFavourite) {
        // Remove userId from isFavouriteBy list in Firestore
        await docRef.update({
          'isFavouriteBy': FieldValue.arrayRemove([userId]),
        });
      } else {
        // Add userId to isFavouriteBy list in Firestore
        await docRef.update({
          'isFavouriteBy': FieldValue.arrayUnion([userId]),
        });
      }

      // Update local list
      allCourses[index] = Course(
        id: course.id,
        title: course.title,
        description: course.description,
        type: course.type,
        isPaid: course.isPaid,
        imageUrl: course.imageUrl,
        isFavourite: !course.isFavourite,
        teacherName: course.teacherName,
        levels: course.levels,
      );

      allCourses.refresh(); // Notify listeners
    } catch (e) {
      print("Error updating favourite status: $e");
      // Optionally show an error message here
    }
  }
}

class Course {
  final String id;
  final String title;
  final String description;
  final String type;
  final bool isPaid;
  final String imageUrl;
  final bool isFavourite;
  final String teacherName;
  final List<Level> levels;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.isPaid,
    required this.imageUrl,
    required this.isFavourite,
    required this.teacherName,
    required this.levels,
  });

  factory Course.fromFirestore(DocumentSnapshot doc, String userId) {
    final data = doc.data() as Map<String, dynamic>;

    return Course(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      type: (data['type'] ?? '').toLowerCase(),
      isPaid: data['isPaid'] ?? false,
      imageUrl: data['imageUrl'] ?? '',
      isFavourite:
          (data['isFavouriteBy'] as List<dynamic>?)?.contains(userId) ?? false,
      teacherName: data['teacherName'] ?? '',
      levels:
          (data['levels'] as List<dynamic>? ?? [])
              .map((e) => Level.fromMap(e as Map<String, dynamic>))
              .toList(),
    );
  }
}

class Level {
  final String levelId;
  final String title;
  final String description;

  Level({
    required this.levelId,
    required this.title,
    required this.description,
  });

  factory Level.fromMap(Map<String, dynamic> data) {
    return Level(
      levelId: data['levelId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }
}
