import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/models/course_model.dart';
import 'package:education_system/student/features/view_course/manager/view_course_cubit.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants.dart';
import '../../../shared/utils/colors.dart';

class QuizPage extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final String type;
  final CourseModel courseModel;
  final String quiz;

  const QuizPage({
    super.key,
    required this.courseModel,
    required this.questions,
    required this.type,
    required this.quiz,
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
        onPressed: () async {
          setState(() {
            loading = true;
          });
          await FirebaseFirestore.instance
              .collection('students')
              .doc(Constants.studentModel!.id)
              .collection(widget.type)
              .doc(widget.courseModel.id!.trim())
              .set({'reference': widget.courseModel.reference});
          var doc = FirebaseFirestore.instance
              .collection('students')
              .doc(Constants.studentModel!.id)
              .collection(widget.type)
              .doc(widget.courseModel.id!.trim())
              .collection('assignment')
              .doc(widget.quiz);
          List<Map<String, dynamic>> questions = [];
          int myGrade = 0;
          for (int i = 0; i < widget.questions.length; i++) {
            questions.add({
              'question': widget.questions[i]['question'],
              'answer1': widget.questions[i]['answer1'],
              'answer2': widget.questions[i]['answer2'],
              'answer3': widget.questions[i]['answer3'],
              'modelAnswer': widget.questions[i]['modelAnswer'],
              'myAnswer': selectedAnswers[i],
            });
            if (selectedAnswers[i] == widget.questions[i]['modelAnswer']) {
              myGrade++;
            }
          }

          await doc.set({
            'courseReference': widget.courseModel.reference,
            'questions': questions,
            'myGrade': myGrade,
            'totalGrade': widget.questions.length,
          });
          ViewCourseCubit.get(context).courseWatched(widget.courseModel, context);
          setState(() {
            loading = false;
          });
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
