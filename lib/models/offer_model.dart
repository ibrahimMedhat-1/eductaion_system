import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/models/course_model.dart';

class OfferModel {
  String? image;
  CourseModel? courseModel;
  DocumentReference<Map<String, dynamic>>? courseRef;

  OfferModel.fromJson(Map<String, dynamic>? json, this.courseModel) {
    image = json!['image'];
    courseRef = json['courseRef'];
  }
}
