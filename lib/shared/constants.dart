import 'package:eductaion_system/models/student_model.dart';

String lang = "en";

abstract class Constants {
  static StudentModel? studentModel = StudentModel(
      name: 'ibrahim',
      email: 'email',
      phone: '010',
      id: 'hsj',
      password: 'sdn',
      parentData: StudentParentData('sd', '@', '23'),
      gender: 'male');
}
