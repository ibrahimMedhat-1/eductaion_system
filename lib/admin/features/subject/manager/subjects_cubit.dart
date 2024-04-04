import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/course_model.dart';

part 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  SubjectsCubit() : super(SubjectsInitial());
  static SubjectsCubit get(context) => BlocProvider.of(context);
  String courseImage = '';

  TextEditingController courseNameController = TextEditingController();
  TextEditingController coursePriceController = TextEditingController();
  String? selectedSubject;
  List<String> years = [];

  bool firstYear = false;
  bool secondYear = false;
  bool thirdYear = false;

  void selectYear(bool value, String year) {
    if (value) {
      years.add(year);
    } else {
      years.remove(year);
    }
  }

  final List<String> subjects = [];

  void getSubjects() async {
    emit(GetSubjectsLoading());
    await FirebaseFirestore.instance.collection('secondary years').doc('first Secondary').get().then((value) {
      selectedSubject = null;
      subjects.clear();
      for (String subject in value.data()!['subjects']) {
        subjects.add(subject);
      }
      emit(GetSubjects());
    });
  }

  void handleSubjectChange(String newValue) {
    selectedSubject = newValue;
    emit(ChangeValue());
  }

  List<CourseModel> courses = [];
  List<CourseModel> searchList = [];
  String year = 'first secondary';

  void getCourses(subject) async {
    emit(GetCoursesLoading());
    courses.clear();
    await getCoursesOfSubject(subject, 'first Secondary');
    await getCoursesOfSubject(subject, 'second Secondary');
    await getCoursesOfSubject(subject, 'third Secondary');
  }

  Future<void> getCoursesOfSubject(subject, year) async {
    emit(GetCoursesLoading());
    await FirebaseFirestore.instance
        .collection('secondary years')
        .doc(year)
        .collection(subject.toString().trim())
        .get()
        .then((value) {
      for (var element in value.docs) {
        courses.add(CourseModel.fromJson(element.data()));
      }
      print(courses);
      emit(GetCoursesSuccessfully());
    }).catchError((onError) {
      emit(GetCoursesError());
      print('fdf ${onError.toString()}');
      Fluttertoast.showToast(msg: onError.toString());
    });
  }

  Future<void> addCourse() async {
    DocumentReference<Map<String, dynamic>> courseDoc = FirebaseFirestore.instance
        .collection('secondary years')
        .doc('first Secondary')
        .collection(selectedSubject!)
        .doc();
    await courseDoc.set(CourseModel(
      image: courseImage,
      price: coursePriceController.text,
      courseName: courseNameController.text,
      id: courseDoc.id,
      reference: courseDoc,
      studyPlan: {},
      years: years,
    ).toMap());
  }

  void changeCourseImage() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) async {
      final image = await value!.readAsBytes();
      await FirebaseStorage.instance
          .ref()
          .child('courses/${DateTime.now()}')
          .putData(
            image,
            SettableMetadata(contentType: 'image/png'),
          )
          .then((p0) async {
        await p0.ref.getDownloadURL().then((value) async {
          courseImage = value;
          emit(ChangeValue());
        });
      }).catchError((onError) {
        print('2');
        print(onError);
      });
    }).catchError((onError) {
      print('1');
      print(onError);
    });
  }
}
