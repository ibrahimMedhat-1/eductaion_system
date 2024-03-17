import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  String? name;
  DocumentReference<Map<String, dynamic>>? reference;
  String? email;
  String? phone;
  String? id;
  String? gender;
  String? password;
  StudentParentData? parentData;

  StudentModel({
    required this.name,
    required this.reference,
    required this.email,
    required this.phone,
    required this.id,
    required this.password,
    required this.parentData,
    required this.gender,
  });

  StudentModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    reference = json['reference'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    password = json['password'];
    id = json['id'];
    parentData = StudentParentData.fromJson(json['parentData']);
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'reference': reference,
        'phone': phone,
        'gender': gender,
        'id': id,
        'password': password,
        'parentData': parentData!.toMap(),
      };
}

class StudentParentData {
  String? name;
  String? email;
  String? phone;

  StudentParentData(this.name, this.email, this.phone);

  StudentParentData.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'email': email,
      };
}
