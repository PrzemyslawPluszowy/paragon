import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;

  const UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap as Map<String, dynamic>;
    return UserModel(
        id: snapshot['id'], name: snapshot['name'], email: snapshot['email']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
