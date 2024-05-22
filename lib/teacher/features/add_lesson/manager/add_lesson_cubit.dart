import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

part 'add_lesson_state.dart';

class AddLessonCubit extends Cubit<AddLessonState> {
  AddLessonCubit() : super(AddLessonInitial());

  static AddLessonCubit get(context) => BlocProvider.of(context);

  TextEditingController lessonNameController = TextEditingController();
  VideoPlayerController? videoPlayerController;

  final String id = '1';
  final String mimeType = 'video/mp4';
  Uint8List? bytes;
  var videoFile;
  void selectVideo() async {
    print('video');
    await ImagePicker().pickVideo(source: ImageSource.gallery).then((value) async {
      emit(UploadVideoLoading());
      videoFile = await value!.readAsBytes();
      final sourceElement = html.SourceElement();
      sourceElement.type = mimeType;
      sourceElement.src = Uri.dataFromBytes(await value.readAsBytes(), mimeType: mimeType).toString();

      final videoElement = html.VideoElement();
      videoElement.controls = true;
      videoElement.children = [sourceElement];
      videoElement.style.height = '100%';
      videoElement.style.width = '100%';

      ui_web.platformViewRegistry.registerViewFactory(id, (int viewId) => videoElement);
      emit(SelectLessonVideo());

      // videoPlayerController = VideoPlayerController.file(videoFile!)
      //   ..initialize().then((value) {
      //     print('object');
      //
      //     videoPlayerController!.play();
      //   });
    });
  }

  Future<void> addLesson(
    context, {
    required String year,
    required String subject,
    required String courseId,
    required String name,
    required DocumentReference<Map<String, dynamic>> courseReference,
  }) async {
    emit(LessonAddedLoading());
    var quiz = FirebaseFirestore.instance
        .collection('secondary years')
        .doc(year)
        .collection(subject)
        .doc(courseId.trim())
        .collection('material')
        .doc();
    print(courseReference);
    print(quiz.id);
    print(name);
    print(quiz);
    await FirebaseStorage.instance
        .ref()
        .child('lessons/${Constants.teacherModel!.courseId.toString().trim()}/${DateTime.now()}')
        .putData(
          videoFile!,
          SettableMetadata(contentType: 'video/mp4'),
        )
        .then((p0) {
      p0.ref.getDownloadURL().then((value) async {
        await quiz.set({
          'courseReference': courseReference,
          'id': quiz.id,
          'name': name,
          'reference': quiz,
          'video': value,
          'type': 'lesson',
          'date': DateTime.now().toString(),
        });
      });
    });

    Navigator.pop(context);
    emit(LessonAddedSuccessfully());
  }
}
