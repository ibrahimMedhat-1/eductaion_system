import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/question_model.dart';

part 'add_quiz_state.dart';

class AddQuizCubit extends Cubit<AddQuizState> {
  AddQuizCubit() : super(AddQuizInitial());
  static AddQuizCubit get(context) => BlocProvider.of(context);
  TextEditingController lessonNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
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

  List<AddQuestionModel> editQuestions = [];
  void editGenerateQuestions() {
    editQuestions.clear();
    editQuestions = questions.toList();
    print(editQuestions);
    print(questions);
    for (int i = 0; i < selectedQuantity; i++) {
      editQuestions.add(AddQuestionModel());
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
    String? quizId,
  }) async {
    emit(QuizAddedLoading());
    final List<Map<String, dynamic>> questionsData = [];
    if (quizId == null) {
      for (final questionModel in questions) {
        questionsData.add(questionModel.toMap());
      }
    } else {
      for (final questionModel in editQuestions) {
        questionsData.add(questionModel.toMap());
      }
    }
    DocumentReference<Map<String, dynamic>> quiz;
    if (quizId != null) {
      quiz = FirebaseFirestore.instance
          .collection('secondary years')
          .doc(year)
          .collection(subject)
          .doc(courseId.trim())
          .collection('material')
          .doc(quizId);
    } else {
      quiz = FirebaseFirestore.instance
          .collection('secondary years')
          .doc(year)
          .collection(subject)
          .doc(courseId.trim())
          .collection('material')
          .doc();
    }
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

  void getAllQuestions({
    required String year,
    required String subject,
    required String courseId,
    required String quizId,
  }) async {
    var quiz = FirebaseFirestore.instance
        .collection('secondary years')
        .doc(year)
        .collection(subject)
        .doc(courseId.trim())
        .collection('material')
        .doc(quizId);
    await quiz.get().then((onValue) {
      lessonNameController.text = onValue['name'];
      typeValue = onValue['type'];
      for (var e in onValue['questions']) {
        questions.add(AddQuestionModel.fromJson(e));
      }
    });
    selectedQuantity = questions.length;
    amountController.text = questions.length.toString();
    editQuestions = questions.toList();
    emit(GetQuizDataSuccessfully());
    print(questions);
  }
}
