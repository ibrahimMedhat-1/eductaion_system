import 'package:flutter/material.dart';

import '../../../../shared/utils/colors.dart';
import '../../add_lesson/view/add_lesson_page.dart';
import '../../add_quiz/view/add_quiz_page.dart';

class MaterialDialog extends StatelessWidget {
  const MaterialDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const QuestionPage()),
                  );
                },
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: ColorsAsset.kLight2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/10.png'),
                      const Text(
                        'Add Quiz',
                        style: TextStyle(color: ColorsAsset.kPrimary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AddLessonPage()),
                  );
                },
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: ColorsAsset.kLight2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/9.png'),
                      const Text(
                        'Add Lesson',
                        style: TextStyle(color: ColorsAsset.kPrimary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
