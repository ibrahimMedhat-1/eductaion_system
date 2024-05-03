import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/components/locale/applocale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/course_model.dart';
import '../../../../models/student_model.dart';

part 'parent_home_page_state.dart';

class ParentHomePageCubit extends Cubit<ParentHomePageState> {
  ParentHomePageCubit() : super(ParentHomePageInitial());

  static ParentHomePageCubit get(context) => BlocProvider.of(context);
  StudentModel? studentModel;

  void getStudentDetails(DocumentReference<Map<String, dynamic>> studentReference) async {
    await studentReference.get().then((value) {
      studentModel = StudentModel.fromJson(value.data());
    });
  }

  List<CourseModel> courses = [];

  void getStudentGrades(String id) async {
    print(id);
    emit(GetChildQuizzesLoading());

    await FirebaseFirestore.instance
        .collection('students')
        .doc(id)
        .collection('quiz')
        .get()
        .then((value) async {
      for (var course in value.docs) {
        print('here');
        await course.reference.get().then((value) async {
          await value.data()!['reference'].get().then((value) {
            print(value.data());
            courses.add(CourseModel.fromJson(value.data()));
          });
        });
      }
      print(courses.length);
    });

    emit(GetChildQuizzesSuccessfully());
  }

  void changePassword(email, context) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(getLang(context, 'We have sent you an email')),
        ),
      );
    });
  }
}
