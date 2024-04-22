import 'dart:html';

import 'package:education_system/models/course_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../shared/utils/colors.dart';
import '../../../../../../student/features/view_course/manager/view_course_cubit.dart';

class ViewPdfPage extends StatelessWidget {
  final CourseModel? courseModel;
  final String name;
  final String? pdfUrl;
  const ViewPdfPage({super.key, required this.name, this.courseModel, this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF')),
      body: Column(
        children: [
          InkWell(
            onTap: courseModel == null
                ? null
                : () {
                    print(pdfUrl);
                    window.open(pdfUrl!, 'PDF Viewer');
                    ViewCourseCubit.get(context).courseWatched(courseModel!, context);
                  },
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.6,
              color: ColorsAsset.kLight,
              child: Center(
                child: Image.asset('assets/images/pdf_image.jpeg'),
              ),
            ),
          ),
          Text(name),
        ],
      ),
    );
  }
}
