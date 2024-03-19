import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eductaion_system/models/course_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../shared/constants.dart';

part 'my_grades_state.dart';

class MyGradesCubit extends Cubit<MyGradesState> {
  MyGradesCubit() : super(MyGradesInitial());
  static MyGradesCubit get(context) => BlocProvider.of(context);
  List<CourseModel> courses = [];
  void myCoursesGrades() async {
    emit(GetMyCoursesGradesLoading());
    await FirebaseFirestore.instance
        .collection('students')
        .doc(Constants.studentModel!.id)
        .collection('quiz')
        .get()
        .then((value) async {
      for (var element in value.docs) {
        DocumentReference<Map<String, dynamic>> course = element.data()['courseReference'];
        await course.get().then((value) {
          courses.add(CourseModel.fromJson(value.data()));
          print(courses);
        }).catchError((onError) {
          print(onError.toString());
          emit(GetMyCoursesGradesError());
        });
      }
      emit(GetMyCoursesGradesSuccessfully());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetMyCoursesGradesError());
    });
  }
}
