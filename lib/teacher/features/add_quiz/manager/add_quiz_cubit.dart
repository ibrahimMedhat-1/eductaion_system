import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/question_model.dart';

part 'add_quiz_state.dart';

class AddQuizCubit extends Cubit<AddQuizState> {
  AddQuizCubit() : super(AddQuizInitial());
  static AddQuizCubit get(context) => BlocProvider.of(context);
  TextEditingController lessonNameController = TextEditingController();
  List<AddQuestionModel> questions = [];
  int selectedQuantity = 0;
  String typeValue = 'quiz';
  void generateQuestions() {
    questions.clear();
    for (int i = 0; i < selectedQuantity; i++) {
      questions.add(AddQuestionModel());
    }
    emit(AllQuizQuestionsGenerated());
  }

  Future<void> addQuiz(
    context, {
    required String year,
    required String subject,
    required String courseId,
    required String name,
    required String type,
    required DocumentReference<Map<String, dynamic>> courseReference,
  }) async {
    emit(QuizAddedLoading());
    final List<Map<String, dynamic>> questionsData = [];
    for (final questionModel in questions) {
      questionsData.add(questionModel.toMap());
    }
    var quiz = FirebaseFirestore.instance
        .collection('secondary years')
        .doc(year)
        .collection(subject)
        .doc(courseId.trim())
        .collection('material')
        .doc();
    print(courseReference);
    print(quiz.id);
    print(name);
    print(quiz);
    print(questionsData);
    print(type);
    await quiz.set({
      'courseReference': courseReference,
      'id': quiz.id,
      'name': name,
      'reference': quiz,
      'questions': questionsData,
      'type': type,
      'date': DateTime.now().toString(),
    });

    Navigator.pop(context);
    emit(QuizAddedSuccessfully());
  }
}
