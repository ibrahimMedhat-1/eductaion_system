import 'package:cloud_firestore/cloud_firestore.dart';

class ParentModel {
  String? id;
  DocumentReference<Map<String, dynamic>>? studentReference;

  ParentModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    studentReference = json['studentReference'];
  }
}
