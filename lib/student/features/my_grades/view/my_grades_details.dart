import 'package:flutter/material.dart';

import '../../../../shared/utils/colors.dart';

class MyGradesDetails extends StatefulWidget {
  const MyGradesDetails({super.key});

  @override
  State<MyGradesDetails> createState() => _MyGradesDetailsState();
}

class _MyGradesDetailsState extends State<MyGradesDetails> {
  Map<int, int> selectedAnswers = {};

  final List<String> questions = [
    'Question 1',
    'Question 2',
    'Question 3',
  ];
  final List<String> modelAnswer = [
    'Answer 1',
    'Answer 3',
    'Answer 3',
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
        title: const Text(
          'My Grades in English Course',
          style: TextStyle(color: ColorsAsset.kPrimary),
        ),
        backgroundColor: ColorsAsset.kLight2,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset("assets/images/logo2.png"),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ExpansionTile(
                  shape: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: ColorsAsset.kPrimary,
                  )),
                  backgroundColor: ColorsAsset.kLight,
                  expandedAlignment: Alignment.topLeft,
                  title: const Text(
                    'Quiz One',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorsAsset.kPrimary),
                  ),
                  trailing: const Text("Grade = 12/15"),
                  children: <Widget>[
                    Column(
                      children: List.generate(questions.length, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              questions[index],
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsAsset.kPrimary),
                            ),
                            const SizedBox(height: 8.0),
                            Column(
                              children: List.generate(answers[index].length,
                                  (optionIndex) {
                                return RadioListTile(
                                  title: Text(
                                    answers[index][optionIndex],
                                    style: const TextStyle(
                                        color: ColorsAsset.kTextcolor),
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
                            Row(
                              children: [
                                const Text("Model Answer : "),
                                Text(modelAnswer[index],
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsAsset.kPrimary))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
