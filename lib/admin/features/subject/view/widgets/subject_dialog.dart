import 'package:flutter/material.dart';

import '../../../../../auth/login/widgets/main_text_field.dart';
import '../../../../../shared/utils/colors.dart';

class SubjectDialog extends StatelessWidget {
  const SubjectDialog({super.key});

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Subject'),
          content: MainTextField(
            hintText: "Subject Name",
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
          Icons.add_box,
          color: ColorsAsset.kPrimary,
        ));
  }
}
