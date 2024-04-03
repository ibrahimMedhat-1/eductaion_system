import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../auth/login/widgets/main_text_field.dart';
import '../../../../../shared/utils/colors.dart';
import '../../manager/subjects_cubit.dart';

class SubjectDialog extends StatelessWidget {
  const SubjectDialog({super.key});

  void _showAddDialog(BuildContext context) {
    TextEditingController subjectName = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Subject'),
          content: MainTextField(
            hintText: "Subject Name",
            controller: subjectName,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () async {
                DocumentReference<Map<String, dynamic>> subjectsDoc =
                    FirebaseFirestore.instance.collection('secondary years').doc('first Secondary');

                await subjectsDoc.get().then((value) {
                  List subjects = value.data()!['subjects'];
                  subjects.add(subjectName.text.trim());
                  subjectsDoc.set({'subjects': subjects});
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    ).whenComplete(() {
      SubjectsCubit.get(context).getSubjects();
    });
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
