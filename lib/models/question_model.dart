import 'package:flutter/cupertino.dart';

class AddQuestionModel {
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  String? modelAnswer;
  int? modelAnswerNo;
  AddQuestionModel();
  Map<String, dynamic> toMap() => {
        'question': questionController.text,
        'answer1': option1Controller.text,
        'answer2': option2Controller.text,
        'answer3': option3Controller.text,
        'modelAnswer': modelAnswer,
        'modelAnswerNo': modelAnswerNo,
      };

  AddQuestionModel.fromJson(Map<String, dynamic>? json) {
    questionController.text = json!['question'];
    option1Controller.text = json['answer1'];
    option2Controller.text = json['answer2'];
    option3Controller.text = json['answer3'];
    modelAnswer = json['modelAnswer'];
    modelAnswerNo = json['modelAnswerNo'];
  }
}
