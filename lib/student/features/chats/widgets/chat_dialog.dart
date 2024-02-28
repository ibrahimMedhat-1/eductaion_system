import 'package:flutter/material.dart';

import '../../../../shared/utils/colors.dart';
import '../chat_page.dart';

class ChatDialog extends StatelessWidget {
  const ChatDialog({super.key});

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
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuestionPage(),));
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
                      const Text(
                        'Group Chat',
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const ChatPage(),));
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
                      const Text(
                        'Private Chat',
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
