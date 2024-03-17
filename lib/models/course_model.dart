import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  String? id;
  DocumentReference<Map<String, dynamic>>? reference;
  String? courseName;
  String? teacherName;
  String? image;
  DocumentReference<Map<String, dynamic>>? teacher;
  Map<String, dynamic>? studyPlan;

  CourseModel.fromJson(Map<String, dynamic>? json) {
    courseName = json!['course name'];
    id = json['id'];
    reference = json['reference'];
    teacherName = json['teacher name'];
    image = json['image'];
    teacher = json['teacher'];
    studyPlan = json['study plan'];
  }
}
