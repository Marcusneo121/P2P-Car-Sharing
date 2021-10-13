import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String imagePath;
  final String name;
  final String email;

  const UserProfile({
    required this.imagePath,
    required this.email,
    required this.name,
  });
}
