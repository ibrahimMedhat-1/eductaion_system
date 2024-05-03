import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/models/course_model.dart';
import 'package:education_system/student/features/quiz/quiz_page.dart';
import 'package:education_system/student/features/view_course/manager/view_course_cubit.dart';
import 'package:education_system/teacher/features/upload_material/pages/pdf_page/view/pdf_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../shared/utils/colors.dart';
import '../../widgets/cutom_appbar.dart';

class ViewCoursePage extends StatelessWidget {
  final CourseModel courseModel;

  const ViewCoursePage({super.key, required this.courseModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewCourseCubit()..getCourseMaterial(courseModel),
      child: BlocConsumer<ViewCourseCubit, ViewCourseState>(
        listener: (context, state) {},
        builder: (context, state) {
          final ViewCourseCubit cubit = ViewCourseCubit.get(context);
          return Scaffold(
            appBar: customAppBar(context),
            body: state is GetMaterialLoading
                ? const Center(child: CircularProgressIndicator())
                : cubit.material.isEmpty
                    ? const Center(child: Text('No Material Yet'))
                    : Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: cubit.material[cubit.index]['type'] == 'lesson'
                                ? VideoLecturePage(
                                    courseModel: courseModel,
                                    videoLink: cubit.material[cubit.index]['video'],
                                    lesson: cubit.material[cubit.index]['reference'],
                                  )
                                : cubit.material[cubit.index]['type'] == 'pdf'
                                    ? ViewPdfPage(
                                        name: cubit.material[cubit.index]['name'],
                                        courseModel: courseModel,
                                        pdfUrl: cubit.material[cubit.index]['pdf'],
                                      )
                                    : QuizPage(
                                        quizName: cubit.material[cubit.index]['name'],
                                        quiz: cubit.material[cubit.index]['id'],
                                        courseModel: courseModel,
                                        type: cubit.material[cubit.index]['type'],
                                        questions: List<Map<String, dynamic>>.from(
                                            cubit.material[cubit.index]['questions']),
                                      ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: ColorsAsset.kPrimary,
                                  ),
                                  left: BorderSide(
                                    color: ColorsAsset.kPrimary,
                                  ),
                                  right: BorderSide(
                                    color: ColorsAsset.kPrimary,
                                  ),
                                ),
                              ),
                              child: ListView.builder(
                                itemCount: cubit.material.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 2,
                                      child: ListTile(
                                        onTap: index == 0 || cubit.watched[index]
                                            ? () {
                                                print(index);
                                                cubit.select(index);
                                              }
                                            : null,
                                        tileColor: cubit.index == index
                                            ? ColorsAsset.kLightPurble
                                            : index == 0 || cubit.watched[index] || index == 0
                                                ? ColorsAsset.kLightPurble
                                                : Colors.grey,
                                        title: Text(
                                          cubit.material[index]['name'].toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
          );
        },
      ),
    );
  }
}

class VideoLecturePage extends StatefulWidget {
  final String videoLink;
  final DocumentReference<Map<String, dynamic>>? lesson;
  final CourseModel? courseModel;
  const VideoLecturePage({
    super.key,
    this.courseModel,
    required this.videoLink,
    this.lesson,
  });

  @override
  State<VideoLecturePage> createState() => _VideoLecturePageState();
}

class _VideoLecturePageState extends State<VideoLecturePage> {
  late VideoPlayerController controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoLink))
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(() async {
        if (controller.value.position == controller.value.duration) {
          ViewCourseCubit.get(context).courseWatched(widget.courseModel!, context);
          print('video Ended');
        }
      });
    _chewieController = ChewieController(
      videoPlayerController: controller,

      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      allowFullScreen: false,
      aspectRatio: 16 / 9,
      looping: false,
      autoPlay: false,
      showControlsOnInitialize: true,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          color: ColorsAsset.kLight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Chewie(controller: _chewieController)),
          ),
        ),
      ),
    );
  }
}
