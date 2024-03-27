import 'package:flutter/cupertino.dart';

class ViewQuestionModel {
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? modelAnswer;

  ViewQuestionModel({
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.modelAnswer,
  });

  ViewQuestionModel.fromJson(Map<String, dynamic>? json) {
    question = json!['question'];
    option1 = json['answer1'];
    option2 = json['answer2'];
    option3 = json['answer3'];
    modelAnswer = json['modelAnswer'];
  }
  Map<String, dynamic> toMap() => {
        'question': question,
        'answer1': option1,
        'answer2': option2,
        'answer3': option3,
        'modelAnswer': modelAnswer,
      };
}

class AddQuestionModel {
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  String? modelAnswer;

  Map<String, dynamic> toMap() => {
        'question': questionController.text,
        'answer1': option1Controller.text,
        'answer2': option2Controller.text,
        'answer3': option3Controller.text,
        'modelAnswer': modelAnswer,
      };
}
