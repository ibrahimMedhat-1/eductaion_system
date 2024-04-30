
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/models/course_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import '../../../../models/teacher_model.dart';

part 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit() : super(CourseDetailsInitial());

  static CourseDetailsCubit get(context) => BlocProvider.of(context);
  bool isFirstYearSelected = false;
  bool isSecondYearSelected = false;
  bool isThirdYearSelected = false;
  TeacherModel? selectedTeacher;

  void handleTeacherChange(TeacherModel newValue) {
    selectedTeacher = newValue;
    emit(ChangeValue());
  }

  CourseModel? courseModel;

  void getCourseDetails(year, subject, courseId) async {
    print(year);
    print(subject);
    print(courseId);
    await FirebaseFirestore.instance
        .collection('secondary years')
        .doc(year)
        .collection(subject.toString().trim())
        .doc(courseId.toString().trim())
        .get()
        .then((value) {
      print('value.data()');
      print(value.data());
      courseModel = CourseModel.fromJson(value.data());
      emit(GetCourseDetails());
    }).catchError((onError) {
      print(onError);
    });
  }

  List<TeacherModel> teachers = [];

  void getTeachers(year, subject) async {
    await FirebaseFirestore.instance
        .collection('teachers')
        .where('subject', isEqualTo: subject)
        .where('years', isEqualTo: [year])
        .get()
        .then((value) {
          for (var teacher in value.docs) {
            if (teacher.data()['courseId'] == null) {
              teachers.add(TeacherModel.fromJson(teacher.data()));
              print(teacher.data());
            }
          }
          emit(GetTeachers());
        });
  }

  Future<void> assignTeacher(
      DocumentReference<Map<String, dynamic>> courseRef) async {
    emit(AssignTeacherLoading());
    await courseRef.update({
      'teacher name': selectedTeacher!.name,
      'teacher': FirebaseFirestore.instance
          .collection('teachers')
          .doc(selectedTeacher!.id),
    });

    await FirebaseFirestore.instance
        .collection('teachers')
        .doc(selectedTeacher!.id!.trim())
        .update({
      'courseId': courseModel!.id,
      'courseReference': courseModel!.reference
    });

    emit(AssignTeacherDone());
  }

  Uint8List? image;

  void addAdvertisement() async {
    emit(ImageLoading());
    await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((value) async {
      image = await value!.readAsBytes();
      emit(GetImageSuccess());
    }).catchError((onError) {
      print('1');
      print(onError);
    });
  }

  void uploadBanner(DocumentReference courseRef,context) async {
    emit(Loading());
    await FirebaseStorage.instance
        .ref()
        .child("Banners/${courseRef.id}/${DateTime.now()}")
        .putData(
          image!,
          SettableMetadata(contentType: 'image/png'),
        )
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance
            .collection("Banners")
            .add({'image': value, 'courseRef': courseRef}).then((value){
          Navigator.pop(context);

        });
      });
    }).catchError((onError) {
      print('2');
      print(onError);

    });
  }
}
