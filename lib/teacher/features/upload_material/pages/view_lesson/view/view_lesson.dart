import 'package:education_system/teacher/features/upload_material/pages/view_lesson/manager/view_lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../shared/constants.dart';
import '../../../../../../student/features/view_course/view_course_page.dart';

class ViewLesson extends StatelessWidget {
  final String videoLink;
  final String lessonTitle;
  final String year;
  final String videoID;
  const ViewLesson({
    super.key,
    required this.videoLink,
    required this.lessonTitle, required this.year, required this.videoID,
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
                : Column(
                  children: [
                    Row(
                        children: [
                          Flexible(
                              flex: 3,
                              child:
                              cubit.videoFile != null
                                  ? SizedBox(
                                height: 200,
                                  child: HtmlElementView(viewType: cubit.id))
                                  :
                              VideoLecturePage(
                                videoLink: videoLink,
                              ),
                          ),
                        ],
                      ),
                    state is UploadVideoLoading?
                    const CircularProgressIndicator():
                    ElevatedButton(onPressed: (){
                      cubit.selectVideo();
                    }, child: const Text("Choose video")),

                    state is LessonAddedLoading?
                    const CircularProgressIndicator():
                    ElevatedButton(onPressed: (){
                      cubit.updateLesson(context,
                          year: year,
                          subject: Constants.teacherModel!.subject!,
                          courseId: Constants.teacherModel!.courseId!,
                        videoDocID: videoID,
                      );

                    }, child: const Text("update video")),

                  ],
                ),
          );
        },
      ),
    );
  }
}
