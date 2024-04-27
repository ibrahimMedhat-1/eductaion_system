import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/locale/applocale.dart';
import '../../../../shared/utils/colors.dart';
import '../manager/add_quiz_cubit.dart';
import '../widgets/question_widget.dart';

class QuestionPage extends StatefulWidget {
  final String year;

  const QuestionPage({
    super.key,
    required this.year,
  });

  @override
  QuestionPageState createState() => QuestionPageState();
}

class QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddQuizCubit(),
      child: BlocConsumer<AddQuizCubit, AddQuizState>(
        listener: (context, state) {},
        builder: (context, state) {
          final AddQuizCubit cubit = AddQuizCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title:  Text(
                '${getLang(context,  "Add Questions")}'
                ,
                style: const TextStyle(color: ColorsAsset.kPrimary),
              ),
              backgroundColor: ColorsAsset.kLight2,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset("assets/images/logo2.png"),
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(

                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: ColorsAsset.kPrimary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextFormField(
                            decoration:  InputDecoration(hintText:
                            '${getLang(context,  "Questions Amount")}'
                            ),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                cubit.selectedQuantity = 0;
                                cubit.generateQuestions();
                              }
                              cubit.selectedQuantity = int.parse(value);
                              cubit.generateQuestions();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: ColorsAsset.kPrimary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(hintText:
                            '${getLang(context,  "Exam Name")}'
                            ),
                            controller: cubit.lessonNameController,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: DropdownButton<String>(
                            value: cubit.typeValue,
                            hint: const Text('Select Type'),
                            onChanged: (value) {
                              cubit.typeValue = value!;
                              cubit.emit(AddQuizInitial());
                            },
                            items:  [
                              DropdownMenuItem(value: 'quiz', child: Text(
                                  '${getLang(context,  "quiz")}'
                                  )),
                              DropdownMenuItem(value: 'assignment', child: Text('${getLang(context,  "assignment")}')),
                            ]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: state is QuizAddedLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: cubit.questions.length,
                            itemBuilder: (context, index) {
                              return QuestionWidget(
                                addQuestionModel: cubit.questions[index],
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            floatingActionButton: SizedBox(
              width: 150,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
                ),

                onPressed: () {
                  if (cubit.selectedQuantity != 0) {
                    cubit.addQuiz(
                      context,
                      courseId: Constants.teacherModel!.courseId!,
                      year: widget.year,
                      name: cubit.lessonNameController.text,
                      subject: Constants.teacherModel!.subject!,
                      type: cubit.typeValue,
                      courseReference: FirebaseFirestore.instance
                          .collection('secondary years')
                          .doc(widget.year)
                          .collection(Constants.teacherModel!.subject!)
                          .doc(Constants.teacherModel!.courseId.toString().trim()),
                    );
                  }
                },
                 child:   Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Adjust the padding as needed
                      child:
                 Text(
                    '${getLang(context,  "Add Quiz")}'
                    ),
              ),
              ),
            )
          );
        },
      ),
    );
  }
}
