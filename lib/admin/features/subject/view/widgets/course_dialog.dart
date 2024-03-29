
import 'package:flutter/material.dart';

import '../../../../../auth/login/widgets/main_text_field.dart';
import '../../../../../shared/utils/colors.dart';

class CourseDialog extends StatelessWidget {
  const CourseDialog({super.key});

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Course'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height*0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/icons8-add-100.png",height: 150,),
                MainTextField(
                  hintText: "Course Name",
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          _showAddDialog(context);
        },
        icon: const Icon(
          Icons.add_box,size: 50,
          color: ColorsAsset.kPrimary,
        ));
  }
}
