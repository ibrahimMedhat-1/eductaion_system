import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/models/course_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../shared/constants.dart';

part 'course_quiz_state.dart';

class CourseQuizCubit extends Cubit<CourseQuizState> {
  CourseQuizCubit() : super(CourseQuizInitial());
  static CourseQuizCubit get(context) => BlocProvider.of(context);

  final List<Map<String, dynamic>> quizzes = [];
  List<List<String>> selectedAnswers = [];
  List<List<String>> groupAnswers = [];

  void getQuiz(CourseModel courseModel) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(Constants.parentModel!.studentReference!.id)
        .collection('quiz')
        .doc(courseModel.id)
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
    emit(GetQuizzesSuccessfully());
  }
}
