import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/models/course_model.dart';
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
        DocumentReference<Map<String, dynamic>> course = element.data()['reference'];
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

  final List<Map<String, dynamic>> quizzes = [];
  List<List<String>> selectedAnswers = [];
  List<List<String>> groupAnswers = [];

  void myQuizzes(String id) async {
    print(id);
    print(Constants.studentModel!.id);
    emit(GetMyQuizzesLoading());

    await FirebaseFirestore.instance
        .collection('students')
        .doc(Constants.studentModel!.id)
        .collection('quiz')
        .doc(id.trim())
        .collection('quiz')
        .get()
        .then((value) {
      for (var element in value.docs) {
        quizzes.add(element.data());
      }
    });
    print(quizzes);

    for (var element in quizzes) {
      List<String> answers = [];

      for (var question in element['questions']) {
        List<String> allAnswers = [];
        allAnswers.add(question['answer1']);
        allAnswers.add(question['answer2']);
        allAnswers.add(question['answer3']);
        answers.add(question['myAnswer']);
        groupAnswers.add(allAnswers);
      }
      selectedAnswers.add(answers);
    }
    print(selectedAnswers);
    emit(GetMyQuizzesSuccessfully());
  }
}
