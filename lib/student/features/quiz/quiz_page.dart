import 'package:education_system/models/course_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/colors.dart';
import '../view_course/manager/view_course_cubit.dart';

class QuizPage extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final String type;
  final CourseModel courseModel;
  const QuizPage({
    super.key,
    required this.courseModel,
    required this.questions,
    required this.type,
  });

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  static late int length;

  late List<String> selectedAnswers;
  bool loading = false;

  @override
  void initState() {
    length = widget.questions.length;
    selectedAnswers = List.generate(length, (index) => '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English First Exam', style: TextStyle(color: ColorsAsset.kTextcolor)),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: List.generate(widget.questions.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.questions[index]['question']!,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                        ),
                        const SizedBox(height: 8.0),
                        Column(
                          children: List.generate(3, (optionIndex) {
                            return RadioListTile(
                              title: Text(
                                widget.questions[index]['answer${optionIndex + 1}']!,
                                style: const TextStyle(color: ColorsAsset.kTextcolor),
                              ),
                              value: selectedAnswers[index],
                              groupValue: widget.questions[index]['answer${optionIndex + 1}'].toString(),
                              onChanged: (value) {
                                setState(() {
                                  selectedAnswers[index] =
                                      widget.questions[index]['answer${optionIndex + 1}'].toString();
                                  print(selectedAnswers[index]);
                                  print(selectedAnswers[index] == widget.questions[index]['modelAnswer']);
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
        onPressed: () {
          ViewCourseCubit().courseWatched(widget.courseModel);
        },
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
