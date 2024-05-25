import 'package:education_system/shared/main_cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../../../../shared/utils/colors.dart';

class SubjectContainer extends StatefulWidget {
  final String subjectName;

  const SubjectContainer({super.key, required this.subjectName});

  @override
  State<SubjectContainer> createState() => _SubjectContainerState();
}

class _SubjectContainerState extends State<SubjectContainer> {
  String translated = '';
  @override
  void initState() {
    super.initState();
    GoogleTranslator().translate(widget.subjectName, to: 'ar').then((value) {
      translated = value.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(translated);
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorsAsset.kbackgorund,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        MainCubit.get(context).lang == 'en' ? widget.subjectName : translated,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
