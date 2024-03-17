import 'package:flutter/material.dart';

import '../../../../models/question_model.dart';
import '../../../../shared/utils/colors.dart';
import '../../../../student/features/payment/widgets/my_text_field.dart';

class AddLessonPage extends StatefulWidget {
  const AddLessonPage({super.key});

  @override
  State<AddLessonPage> createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLessonPage> {
  int? selectedQuantity;
  List<ViewQuestionModel> questions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Lesson',
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
      body: Row(
        children: [
          Flexible(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        color: ColorsAsset.kLight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Image.asset("assets/images/video.png")),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: const MyTextField(
                        hintText: "Lesson Name",
                      ),
                    )
                  ],
                ),
              )),
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
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
                      value: selectedQuantity,
                      hint: const Text('Select quantity'),
                      onChanged: (value) {
                        setState(() {
                          selectedQuantity = value!;
                          generateQuestions();
                        });
                      },
                      items: List.generate(10, (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text((index + 1).toString()),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        // return QuestionWidget(
                        //   questions[index],
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void generateQuestions() {
    questions.clear();
    for (int i = 0; i < selectedQuantity!; i++) {
      // questions.add(ViewQuestionModel());
    }
  }
}
