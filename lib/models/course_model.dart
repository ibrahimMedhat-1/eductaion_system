import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  String? id;
  DocumentReference<Map<String, dynamic>>? reference;
  String? courseName;
  String? teacherName;
  String? teacherImage;
  String? price;
  String? image;
  DocumentReference<Map<String, dynamic>>? teacher;
  Map<String, dynamic>? studyPlan;
  List<String>? years;

  CourseModel(
      {this.id,
      this.reference,
      this.price,
      this.courseName,
      this.teacherName,
      this.image,
      this.teacher,
      this.studyPlan,
      this.years,
      this.teacherImage});

  CourseModel.fromJson(Map<String, dynamic>? json) {
    courseName = json!['course name'];
    years = List.generate(json['years'].length, (index) => json['years'][index].toString());
    id = json['id'];
    price = json['price'];
    reference = json['reference'];
    teacherName = json['teacher name'];
    image = json['image'];
    teacher = json['teacher'];
    studyPlan = json['study plan'];
  }

  Map<String, dynamic> toMap() => {
        'course name': courseName,
        'price': price,
        'years': years,
        'id': id,
        'reference': reference,
        'teacher name': teacherName,
        'image': image,
        'teacher': teacher,
        'study plan': studyPlan,
        'teacher image': teacherImage,
      };
}
