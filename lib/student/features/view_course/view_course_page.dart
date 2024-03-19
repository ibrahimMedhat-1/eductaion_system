import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eductaion_system/models/course_model.dart';
import 'package:eductaion_system/student/features/quiz/quiz_page.dart';
import 'package:eductaion_system/student/features/view_course/manager/view_course_cubit.dart';
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
                                    videoLink: cubit.material[cubit.index]['video'],
                                    lesson: cubit.material[cubit.index]['reference'],
                                  )
                                : QuizPage(
                                    courseReference: cubit.material[cubit.index]['courseReference'],
                                    quiz: cubit.material[cubit.index]['reference'],
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
                                      elevation: 2,
                                      child: ListTile(
                                        onTap: index == 0 || cubit.material[index - 1]['watched'] != false
                                            ? () {
                                                cubit.select(cubit.material[index], index);
                                              }
                                            : null,
                                        tileColor: cubit.index == index
                                            ? Colors.blueAccent
                                            : index == 0 ||
                                                    cubit.material[index - 1]['watched'] != false ||
                                                    index == 0
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
  final DocumentReference<Map<String, dynamic>> lesson;
  const VideoLecturePage({
    super.key,
    required this.videoLink,
    required this.lesson,
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
          await widget.lesson.update({'watched': true});
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
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
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
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const ExpansionTile(
              shape: OutlineInputBorder(
                  borderSide: BorderSide(
                color: ColorsAsset.kPrimary,
              )),
              backgroundColor: ColorsAsset.kLight,
              expandedAlignment: Alignment.topLeft,
              title: Text(
                'الشهر الاول',
                style: TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('الوحدة الاولي'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('اسالة عاملة'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('امتحان شامل'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const ExpansionTile(
              shape: OutlineInputBorder(
                  borderSide: BorderSide(
                color: ColorsAsset.kPrimary,
              )),
              backgroundColor: ColorsAsset.kLight,
              expandedAlignment: Alignment.topLeft,
              title: Text(
                'الشهر الثاني',
                style: TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('الوحدة الاولي'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('اسالة عاملة'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('امتحان شامل'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const ExpansionTile(
              shape: OutlineInputBorder(
                  borderSide: BorderSide(
                color: ColorsAsset.kPrimary,
              )),
              backgroundColor: ColorsAsset.kLight,
              expandedAlignment: Alignment.topLeft,
              title: Text(
                'الشهر الثالث',
                style: TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('الوحدة الاولي'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('اسالة عاملة'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('امتحان شامل'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
