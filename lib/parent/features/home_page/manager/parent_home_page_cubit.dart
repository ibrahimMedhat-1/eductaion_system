import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../models/student_model.dart';

part 'parent_home_page_state.dart';

class ParentHomePageCubit extends Cubit<ParentHomePageState> {
  ParentHomePageCubit() : super(ParentHomePageInitial());
  static ParentHomePageCubit get(context) => BlocProvider.of(context);
  StudentModel? studentModel;
  void getStudentDetails(DocumentReference<Map<String, dynamic>> studentReference) {
    studentReference.get().then((value) {
      studentModel = StudentModel.fromJson(value.data());
      emit(GetStudentsData());
    });
  }

  final List<Map<String, dynamic>> quizzes = [];
  List<List<String>> selectedAnswers = [];
  List<List<String>> groupAnswers = [];

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
        await course.reference.collection('quiz').get().then((value) {
          for (var element in value.docs) {
            quizzes.add(element.data());
          }
        });
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
    emit(GetChildQuizzesSuccessfully());
  }
}
