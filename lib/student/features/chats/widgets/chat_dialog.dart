import 'package:education_system/models/course_model.dart';
import 'package:flutter/material.dart';

import '../../../../components/locale/applocale.dart';
import '../../../../shared/utils/colors.dart';
import '../chat_page.dart';

class ChatDialog extends StatelessWidget {
  const ChatDialog({super.key, required this.courseModel});
  final CourseModel courseModel;
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatPage(isGroupChat: true, courseModel: courseModel),
                  ));
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
                      Image.asset('assets/images/7.png'),
                      Text(
                        '${getLang(context, "Group Chat")}',
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatPage(
                      courseModel: courseModel,
                    ),
                  ));
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
                      Image.asset('assets/images/8.png'),
                      Text(
                        '${getLang(context, "Private Chat")}',
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
          child: Text('${getLang(context, "Close")}'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
