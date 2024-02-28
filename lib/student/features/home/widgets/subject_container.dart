import 'package:flutter/material.dart';

import '../../../../shared/utils/colors.dart';

class SubjectContainer extends StatelessWidget {
  final String subjectName;

  const SubjectContainer({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorsAsset.kbackgorund,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        subjectName,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
