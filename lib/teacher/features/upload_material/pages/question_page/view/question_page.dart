import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../components/locale/applocale.dart';
import '../../../../../../shared/utils/colors.dart';
import '../manager/question_view_cubit.dart';

class TeacherQuestionPage extends StatelessWidget {
  final Map<String, dynamic> question;

  const TeacherQuestionPage({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    print(question);
    return BlocProvider(
  create: (context) => QuestionViewCubit(),
  child: BlocConsumer<QuestionViewCubit, QuestionViewState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    final QuestionViewCubit cubit = QuestionViewCubit.get(context);
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
                  Text("Question"),
                  const SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText:  question['questions'][index]['question']!,
                      border: OutlineInputBorder(

                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Column(
                    children: List.generate(3, (optionIndex) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText:  question['questions'][index]['answer${optionIndex + 1}']!,
                              border: OutlineInputBorder(

                              )
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 8.0),
                  Text("Model Answer"),
                  const SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText:  '${getLang(context,  "Model Answer : ")}${question['questions'][index]['modelAnswer']}',
                      border: OutlineInputBorder(
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  },
),
);
  }
}
