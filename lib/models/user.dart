import 'package:firebase_auth/firebase_auth.dart';
class UserModel {
  final String uid;
  final String email;
  final String? firstName;
  final String? phone;
  final String? address;
  final String? lastName;

  UserModel({
    required this.uid,
    required this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,

  });

  factory UserModel.fromFirebase(User user) {
    return UserModel(uid: user.uid, email: user.email ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phone: map['phone'],
      address: map['address'],
    );
  }
}
