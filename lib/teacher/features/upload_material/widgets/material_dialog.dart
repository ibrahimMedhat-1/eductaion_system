import 'package:education_system/components/locale/applocale.dart';
import 'package:education_system/teacher/features/add_pdf_page/view/add_pdf_page.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/colors.dart';
import '../../add_lesson/view/add_lesson_page.dart';
import '../../add_quiz/view/add_quiz_page.dart';

class MaterialDialog extends StatelessWidget {
  final String year;
  const MaterialDialog({super.key, required this.year});

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
                    MaterialPageRoute(
                        builder: (context) => QuestionPage(
                              year: year,
                            )),
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
                       Text(
                         getLang(context, "Add Questions")
                       ,
                        style: const TextStyle(color: ColorsAsset.kPrimary, fontWeight: FontWeight.bold),
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
                    MaterialPageRoute(builder: (context) => AddLessonPage(year: year)),
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
                       Text(
                        getLang(context, "Add Lesson")
                        ,
                        style: const TextStyle(color: ColorsAsset.kPrimary, fontWeight: FontWeight.bold),
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
                    MaterialPageRoute(builder: (context) => AddPdfPag(year: year)),
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
                      Image.asset('assets/images/pdf_image.jpeg'),
                       Text(
                         getLang(context, "Add PDF")
                        ,
                        style: const TextStyle(color: ColorsAsset.kPrimary, fontWeight: FontWeight.bold),
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
          child:  Text(
              getLang(context, "Close")),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
