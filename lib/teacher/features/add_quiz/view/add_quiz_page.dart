import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/utils/colors.dart';
import '../manager/add_quiz_cubit.dart';
import '../widgets/question_widget.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

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
              title: const Text(
                'Add Quiz',
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
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: ColorsAsset.kPrimary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: DropdownButton<int>(
                      value: cubit.selectedQuantity,
                      hint: const Text('Select quantity'),
                      onChanged: (value) {
                        cubit.selectedQuantity = value!;
                        cubit.generateQuestions();
                      },
                      items: List.generate(11, (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text((index).toString()),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.selectedQuantity != 0) {
                  // cubit.addQuiz();
                }
              },
              child: const Text('Add Quiz'),
            ),
          );
        },
      ),
    );
  }
}
