import 'package:education_system/student/features/my_assignment/manager/my_assignments_cubit.dart';
import 'package:education_system/student/features/my_grades/manager/my_grades_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/utils/colors.dart';

class MyAssignmentDetails extends StatefulWidget {
  final String id;
  const MyAssignmentDetails({super.key, required this.id});

  @override
  State<MyAssignmentDetails> createState() => _MyAssignmentDetailsState();
}

class _MyAssignmentDetailsState extends State<MyAssignmentDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAssignmentsCubit()..myAssignments(widget.id),
      child: BlocConsumer<MyAssignmentsCubit, MyAssignmentsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final MyAssignmentsCubit cubit = MyAssignmentsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'My Assignment in English Course',
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
                : cubit.assignments.isEmpty
                    ? const Center(
                        child: Text('No quizzes taken yet'),
                      )
                    : ListView.builder(
                        itemCount: cubit.assignments.length,
                        itemBuilder: (context, indexx) {
                          print(cubit.assignments[indexx]['questions'].length);
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
                                    'Assignment ${indexx + 1}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                                  ),
                                  trailing: Text(
                                      "Grade = ${cubit.assignments[indexx]['myGrade']}/${cubit.assignments[indexx]['totalGrade']}"),
                                  children: <Widget>[
                                    Column(
                                      children: List.generate(cubit.assignments[indexx]['questions'].length,
                                          (index) {
                                        print(index);
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cubit.assignments[indexx]['questions'][index]['question'],
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorsAsset.kPrimary),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Column(
                                              children: List.generate(3, (optionIndex) {
                                                print(cubit.assignments[indexx]['questions'][index]
                                                    ['answer${optionIndex + 1}']);
                                                print(cubit.selectedAnswers[indexx][index]);
                                                return RadioListTile(
                                                  title: Text(
                                                    cubit.assignments[indexx]['questions'][index]
                                                        ['answer${optionIndex + 1}'],
                                                    style: const TextStyle(color: ColorsAsset.kTextcolor),
                                                  ),
                                                  value: cubit.selectedAnswers[indexx][index],
                                                  groupValue: cubit.assignments[indexx]['questions'][index]
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
                                                Text(
                                                    cubit.assignments[indexx]['questions'][index]
                                                        ['modelAnswer'],
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
