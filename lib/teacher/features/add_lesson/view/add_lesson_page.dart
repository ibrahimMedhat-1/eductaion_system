import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/teacher/features/add_lesson/manager/add_lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/utils/colors.dart';
import '../../../../student/features/payment/widgets/my_text_field.dart';

class AddLessonPage extends StatefulWidget {
  final String year;
  const AddLessonPage({super.key, required this.year});

  @override
  State<AddLessonPage> createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLessonPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddLessonCubit(),
      child: BlocConsumer<AddLessonCubit, AddLessonState>(
        listener: (context, state) {},
        builder: (context, state) {
          final AddLessonCubit cubit = AddLessonCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Add Lesson',
                style: TextStyle(color: ColorsAsset.kPrimary),
              ),
              backgroundColor: ColorsAsset.kLight2,
              actions: [
                Padding(padding: const EdgeInsets.all(5.0), child: Image.asset("assets/images/logo2.png")),
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          cubit.selectVideo();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            color: ColorsAsset.kLight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: cubit.videoFile != null
                                  ? HtmlElementView(viewType: cubit.id)
                                  : Center(child: Image.asset("assets/images/icons8-add-100.png")),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      if (cubit.videoFile != null)
                        MaterialButton(
                          onPressed: () {
                            cubit.videoFile = null;
                            cubit.emit(SelectLessonVideo());
                          },
                          child: const Text('Remove Video'),
                        ),
                      Row(
                        children: [
                          MyTextField(
                            hintText: "Lesson Name",
                            controller: cubit.lessonNameController,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                if (state is LessonAddedLoading) const Center(child: CircularProgressIndicator())
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.videoFile != null) {
                  cubit.addLesson(
                    context,
                    courseId: Constants.teacherModel!.courseId!,
                    year: widget.year,
                    name: cubit.lessonNameController.text,
                    subject: Constants.teacherModel!.subject!,
                    courseReference: FirebaseFirestore.instance
                        .collection('secondary years')
                        .doc(widget.year)
                        .collection(Constants.teacherModel!.subject!)
                        .doc(Constants.teacherModel!.courseId.toString().trim()),
                  );
                }
              },
              child: const Text('Add Lesson'),
            ),
          );
        },
      ),
    );
  }
}

class LessonVideo extends StatefulWidget {
  final File videoFile;
  const LessonVideo({super.key, required this.videoFile});

  @override
  State<LessonVideo> createState() => _LessonVideoState();
}

class _LessonVideoState extends State<LessonVideo> {
  late VideoPlayerController controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
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
