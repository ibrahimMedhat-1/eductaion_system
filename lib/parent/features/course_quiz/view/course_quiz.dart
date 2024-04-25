import 'package:education_system/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/locale/applocale.dart';
import '../../../../shared/utils/colors.dart';
import '../manager/course_quiz_cubit.dart';

class ParentCourseQuizPage extends StatelessWidget {
  final CourseModel courseModel;
  const ParentCourseQuizPage({super.key, required this.courseModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseQuizCubit()..getQuiz(courseModel),
      child: BlocConsumer<CourseQuizCubit, CourseQuizState>(
        listener: (context, state) {},
        builder: (context, state) {
          final CourseQuizCubit cubit = CourseQuizCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: state is GetQuizzesLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: cubit.quizzes.length,
                      itemBuilder: (context, indexx) {
                        print(cubit.quizzes[indexx]['questions'].length);
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
                                title: Text(
                                  '${getLang(context, "Quiz")} ${indexx + 1}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                                ),
                                trailing: Text(
                                    "${getLang(context, "Grade")} = ${cubit.quizzes[indexx]['myGrade']}/${cubit.quizzes[indexx]['totalGrade']}"),
                                children: <Widget>[
                                  Column(
                                    children:
                                        List.generate(cubit.quizzes[indexx]['questions'].length, (index) {
                                      print(index);
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.quizzes[indexx]['questions'][index]['question'],
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: ColorsAsset.kPrimary),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Column(
                                            children: List.generate(3, (optionIndex) {
                                              print(cubit.quizzes[indexx]['questions'][index]
                                                  ['answer${optionIndex + 1}']);
                                              print(cubit.selectedAnswers[indexx][index]);
                                              return RadioListTile(
                                                title: Text(
                                                  cubit.quizzes[indexx]['questions'][index]
                                                      ['answer${optionIndex + 1}'],
                                                  style: const TextStyle(color: ColorsAsset.kTextcolor),
                                                ),
                                                value: cubit.selectedAnswers[indexx][index],
                                                groupValue: cubit.quizzes[indexx]['questions'][index]
                                                    ['answer${optionIndex + 1}'],
                                                onChanged: (value) {},
                                              );
                                            }),
                                          ),
                                          Row(
                                            children: [
                                              Text('${getLang(context, "Model Answer : ")}'),
                                              Text(cubit.quizzes[indexx]['questions'][index]['modelAnswer'],
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
            ),
          );
        },
      ),
    );
  }
}
