import 'package:eductaion_system/student/features/my_grades/manager/my_grades_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/utils/colors.dart';

class MyGradesDetails extends StatefulWidget {
  final String id;
  const MyGradesDetails({super.key, required this.id});

  @override
  State<MyGradesDetails> createState() => _MyGradesDetailsState();
}

class _MyGradesDetailsState extends State<MyGradesDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyGradesCubit()..myQuizzes(widget.id),
      child: BlocConsumer<MyGradesCubit, MyGradesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final MyGradesCubit cubit = MyGradesCubit.get(context);
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
            body: state is GetMyQuizzesLoading
                ? const Center(child: CircularProgressIndicator())
                : cubit.quizzes.isEmpty
                    ? const Center(
                        child: Text('No quizzes taken yet'),
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
                                                  onChanged: (value) {
                                                    setState(() {
                                                      // cubit.selectedAnswers[index] = value!;
                                                    });
                                                  },
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
          );
        },
      ),
    );
  }
}
