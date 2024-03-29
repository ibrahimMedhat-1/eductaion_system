import 'package:education_system/models/student_model.dart';
import 'package:education_system/models/teacher_model.dart';

String lang = "en";

abstract class Constants {
  static StudentModel? studentModel;

  static TeacherModel? teacherModel = TeacherModel(
    bio: 'to7fa',
    centerName: 'stars',
    centerNo: '345678',
    degree: 'bachelor of math',
    email: 'teacher@gmail.com',
    name: 'Ibrahim',
    id: 'cV6Qa074MduGwYC5ujcu',
    image: '',
    courseId: 'wwbjZNx7hD1r37PULn0g',
    subject: 'math',
    years: [
      'first Secondary',
      'second Secondary',
      'third Secondary',
    ],
  );
}
