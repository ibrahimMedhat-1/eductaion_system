import 'package:flutter/cupertino.dart';

class ViewQuestionModel {
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? modelAnswer;
}

class AddQuestionModel {
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  String? modelAnswer;

  Map<String, dynamic> toMap() => {
        'question': questionController,
        'option1': option1Controller,
        'option2': option2Controller,
        'option3': option3Controller,
        'modelAnswer': modelAnswer,
      };
}
