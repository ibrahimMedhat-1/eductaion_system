import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eductaion_system/models/student_model.dart';

String lang = "en";

abstract class Constants {
  static StudentModel? studentModel = StudentModel(
      name: 'ibrahim',
      reference: FirebaseFirestore.instance.collection('students').doc('xaGtgWrUrEW2cDybEp4vOHGrB7m2'),
      email: 'email',
      phone: '010',
      id: 'xaGtgWrUrEW2cDybEp4vOHGrB7m2',
      password: 'sdn',
      parentData: StudentParentData('sd', '@', '23'),
      gender: 'male');
}
