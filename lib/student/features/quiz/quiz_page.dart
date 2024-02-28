import 'package:flutter/material.dart';

import '../../../shared/utils/colors.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Map<int, int> selectedAnswers = {};

  final List<String> questions = [
    'Question 1',
    'Question 2',
    'Question 3',
  ];

  final List<List<String>> answers = [
    ['Answer 1', 'Answer 2', 'Answer 3'],
    ['Answer 1', 'Answer 2', 'Answer 3'],
    ['Answer 1', 'Answer 2', 'Answer 3'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English First Exam', style: TextStyle(color: ColorsAsset.kTextcolor)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: List.generate(questions.length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    questions[index],
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                  ),
                  const SizedBox(height: 8.0),
                  Column(
                    children: List.generate(answers[index].length, (optionIndex) {
                      return RadioListTile(
                        title: Text(
                          answers[index][optionIndex],
                          style: const TextStyle(color: ColorsAsset.kTextcolor),
                        ),
                        value: optionIndex,
                        groupValue: selectedAnswers[index],
                        onChanged: (value) {
                          setState(() {
                            selectedAnswers[index] = value!;
                          });
                        },
                      );
                    }),
                  ),
                  const Divider(),
                ],
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorsAsset.kPrimary,
        onPressed: () {},
        label: const Text(
          'Submit',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
