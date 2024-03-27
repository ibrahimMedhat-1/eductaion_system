import 'package:education_system/teacher/features/upload_material/pages/view_lesson/manager/view_lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../student/features/view_course/view_course_page.dart';

class ViewLesson extends StatelessWidget {
  final String videoLink;
  final String lessonTitle;
  const ViewLesson({
    super.key,
    required this.videoLink,
    required this.lessonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewLessonCubit(),
      child: BlocConsumer<ViewLessonCubit, ViewLessonState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final ViewLessonCubit cubit = ViewLessonCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: Text(lessonTitle)),
            body: state is GetLessonLoading
                ? const Center(child: CircularProgressIndicator())
                : Row(
                    children: [
                      Flexible(
                          flex: 3,
                          child: VideoLecturePage(
                            videoLink: videoLink,
                          )),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
