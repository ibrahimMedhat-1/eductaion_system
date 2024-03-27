import 'package:flutter/material.dart';

import '../../../../../../shared/utils/colors.dart';

class TeacherQuestionPage extends StatelessWidget {
  final Map<String, dynamic> question;

  const TeacherQuestionPage({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    print(question);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: List.generate(question['questions'].length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question['questions'][index]['question']!,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                  ),
                  const SizedBox(height: 8.0),
                  Column(
                    children: List.generate(3, (optionIndex) {
                      return ListTile(
                        title: Text(
                          question['questions'][index]['answer${optionIndex + 1}']!,
                          style: const TextStyle(color: ColorsAsset.kTextcolor),
                        ),
                      );
                    }),
                  ),
                  Text('Model answer : ${question['questions'][index]['modelAnswer']}'),
                  const Divider(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
