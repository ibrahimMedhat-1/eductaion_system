import 'package:education_system/models/student_model.dart';
import 'package:education_system/models/teacher_model.dart';

import '../models/parent_model.dart';

String lang = "en";

abstract class Constants {
  static StudentModel? studentModel;
  static ParentModel? parentModel;
  static TeacherModel? teacherModel;
}

// Function to validate the number
bool isNumber(String value) {
  final n = num.tryParse(value);
  return n != null;
}
