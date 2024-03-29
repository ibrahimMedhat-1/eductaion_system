import 'package:education_system/teacher/features/student_view/manager/student_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/utils/colors.dart';
import '../../../../student/features/profile/widgets/parent_data.dart';

class StudentPage extends StatelessWidget {
  final Map<String, dynamic> student;
  const StudentPage({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student details',
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
      body: BlocProvider(
        create: (context) => StudentDataCubit()..getStudentGrades(student['id']),
        child: BlocConsumer<StudentDataCubit, StudentDataState>(
          listener: (context, state) {},
          builder: (context, state) {
            final StudentDataCubit cubit = StudentDataCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Flexible(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundColor: const Color(0xFF6E85B7),
                              backgroundImage: NetworkImage(student['image'] ?? ''),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // PersonalData(),
                            FamilyDataSection(parentData: student['parentData']),
                          ],
                        ),
                      )),
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ListView.builder(
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
                                    'Quiz ${indexx + 1}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                                  ),
                                  trailing: Text(
                                      "Grade = ${cubit.quizzes[indexx]['myGrade']}/${cubit.quizzes[indexx]['totalGrade']}"),
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
                                                const Text("Model Answer : "),
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
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
