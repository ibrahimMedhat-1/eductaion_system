import 'package:education_system/teacher/features/add_quiz/widgets/question_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../models/question_model.dart';

class QuestionWidget extends StatefulWidget {
  final AddQuestionModel addQuestionModel;

  const QuestionWidget({required this.addQuestionModel, super.key});

  @override
  QuestionWidgetState createState() => QuestionWidgetState();
}

class QuestionWidgetState extends State<QuestionWidget> {
  bool option1 = false;
  bool option2 = false;
  bool option3 = false;
  @override
  void initState() {
    super.initState();
    option1 = widget.addQuestionModel.modelAnswerNo == 1;
    option2 = widget.addQuestionModel.modelAnswerNo == 2;
    option3 = widget.addQuestionModel.modelAnswerNo == 3;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.5,
            child: QuestionTextField(
              hintText: "Enter Question",
              controller: widget.addQuestionModel.questionController,
            ),
          ),
          const SizedBox(height: 8.0),
          QuestionTextField(
            hintText: "Answer 1",
            controller: widget.addQuestionModel.option1Controller,
          ),
          const SizedBox(height: 8.0),
          QuestionTextField(
            hintText: "Answer 2",
            controller: widget.addQuestionModel.option2Controller,
          ),
          const SizedBox(height: 8.0),
          QuestionTextField(
            hintText: "Answer 3",
            controller: widget.addQuestionModel.option3Controller,
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Checkbox(
                value: option1,
                shape: const CircleBorder(),
                onChanged: (value) {
                  setState(() {
                    option1 = !option1;
                    if (option1) {
                      option2 = false;
                      option3 = false;
                      widget.addQuestionModel.modelAnswer = widget.addQuestionModel.option1Controller.text;
                      widget.addQuestionModel.modelAnswerNo = 1;
                      print(widget.addQuestionModel.modelAnswer);
                    } else {
                      widget.addQuestionModel.modelAnswer = null;
                    }
                  });
                },
              ),
              const Text('Option 1'),
              Checkbox(
                value: option2,
                shape: const CircleBorder(),
                onChanged: (value) {
                  setState(() {
                    option2 = !option2;
                    if (option2) {
                      option1 = false;
                      option3 = false;
                      widget.addQuestionModel.modelAnswer = widget.addQuestionModel.option2Controller.text;
                      widget.addQuestionModel.modelAnswerNo = 2;
                      print(widget.addQuestionModel.modelAnswer);
                    } else {
                      widget.addQuestionModel.modelAnswer = null;
                    }
                  });
                },
              ),
              const Text('Option 2'),
              Checkbox(
                value: option3,
                shape: const CircleBorder(),
                onChanged: (value) {
                  setState(() {
                    option3 = !option3;
                    if (option3) {
                      option1 = false;
                      option2 = false;
                      widget.addQuestionModel.modelAnswer = widget.addQuestionModel.option3Controller.text;
                      widget.addQuestionModel.modelAnswerNo = 3;
                      print(widget.addQuestionModel.modelAnswer);
                    } else {
                      widget.addQuestionModel.modelAnswer = null;
                    }
                  });
                },
              ),
              const Text('Option 3'),
            ],
          ),
        ],
      ),
    );
  }
}
