import 'package:education_system/teacher/features/choose_grade/choose_grade_3.dart';
import 'package:flutter/material.dart';

import '../choose_grade/choose_grade_view.dart';
import '../choose_grade/choose_grade_view2.dart';

class TeacherRowList {
  final String title;
  final IconData icon;
  final Widget Function() widgetBuilder;
  bool isSelected;
  dynamic Function(BuildContext)? onTap;

  TeacherRowList({
    this.isSelected = false,
    required this.widgetBuilder,
    required this.icon,
    required this.title,
    required dynamic Function(BuildContext) onTap,
  });

  static List<TeacherRowList> rowList = [
    TeacherRowList(
      isSelected: true,
      widgetBuilder: () =>   const ChooseGradePage2(),
      icon: Icons.file_copy_outlined,
      title: "Upload Material",
      onTap: (context) {},
    ),
    TeacherRowList(
      widgetBuilder: () =>     const Scaffold(

        body: ChooseGradePage(),
      ),
      icon: Icons.class_outlined,
      title: "View Students",
      onTap: (context) {},
    ),
    TeacherRowList(
      widgetBuilder: () => const ChooseGradePage3(),
      icon: Icons.chat_bubble_outline,
      title: "Chats",
      onTap: (context) {},
    ),



  ];
}
