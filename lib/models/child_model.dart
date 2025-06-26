class ChildModel {
  final String? id; // اجعله اختياريًا
  final String name;
  final int age;

  ChildModel({this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }

  factory ChildModel.fromMap(Map<String, dynamic> map, {required String id}) {
    return ChildModel(
      id: id,
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
    );
  }
}
