import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  String? courseName;
  String? teacherName;
  String? image;
  DocumentReference<Map<String, dynamic>>? teacher;
  Map<String, dynamic>? studyPlan;

  CourseModel.fromJson(Map<String, dynamic>? json) {
    courseName = json!['course name'];
    teacherName = json['teacher name'];
    image = json['image'];
    teacher = json['teacher'];
    studyPlan = json['study plan'];
  }
}
