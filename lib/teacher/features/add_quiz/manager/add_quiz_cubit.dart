import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/question_model.dart';

part 'add_quiz_state.dart';

class AddQuizCubit extends Cubit<AddQuizState> {
  AddQuizCubit() : super(AddQuizInitial());

  static AddQuizCubit get(context) => BlocProvider.of(context);
  List<AddQuestionModel> questions = [];
  int selectedQuantity = 0;

  void generateQuestions() {
    questions.clear();
    for (int i = 0; i < selectedQuantity; i++) {
      questions.add(AddQuestionModel());
    }
    emit(AllQuizQuestionsGenerated());
  }

  Future<void> addQuiz({
    required year,
    required subject,
    required teacherId,
  }) async {
    final List<Map<String, dynamic>> questionsData = [];
    for (final questionModel in questions) {
      questionsData.add(questionModel.toMap());
    }
    FirebaseFirestore.instance
        .collection('secondary years')
        .doc(year)
        .collection(subject)
        .doc(teacherId)
        .collection('quiz')
        .add({
      'questions': questionsData,
    });
    emit(QuizAddedSuccessfully());
  }
}
