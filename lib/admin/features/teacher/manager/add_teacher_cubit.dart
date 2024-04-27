import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/models/teacher_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'add_teacher_state.dart';

class AddTeacherCubit extends Cubit<AddTeacherState> {
  AddTeacherCubit() : super(AddTeacherInitial());

  static AddTeacherCubit get(context) => BlocProvider.of(context);
  TextEditingController teacherNameController = TextEditingController();
  TextEditingController teacherEmailController = TextEditingController();
  TextEditingController teacherPasswordController = TextEditingController();

  String? selectedSubject;

  final List<String> subjects = [];

  void getSubjects() async {
    await FirebaseFirestore.instance.collection('secondary years').doc('first Secondary').get().then((value) {
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

  void addTeacher(context) async {
    emit(AddTeacherLoading());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: teacherEmailController.text.trim().toLowerCase(),
      password: teacherPasswordController.text,
    )
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('teachers')
          .doc(teacherEmailController.text.trim().toLowerCase())
          .set(TeacherModel(
                  bio: '',
                  centerName: '',
                  centerNo: '',
                  courseId: '',
                  degree: '',
                  email: teacherEmailController.text.trim().toLowerCase(),
                  id: teacherEmailController.text.trim().toLowerCase(),
                  image: '',
                  name: teacherNameController.text.trim(),
                  subject: selectedSubject,
                  years: years)
              .toMap())
          .then((value) {
        emit(AddTeacherSuccessfully());
        Navigator.pop(context);
      }).catchError((onError) {
        Fluttertoast.showToast(msg: onError.toString());
        emit(AddTeacherError());
      });
    }).catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString());
      print(onError);
      emit(AddTeacherError());
    });
  }

  List<String> years = [];

  bool firstYear = false;
  bool secondYear = false;
  bool thirdYear = false;

  void selectYear(bool value, String year) {
    years.clear();
    if (year == 'first Secondary') {
      firstYear = true;
      secondYear = false;
      thirdYear = false;
      years.add(year);
    } else if (year == 'second Secondary') {
      firstYear = false;
      secondYear = true;
      thirdYear = false;

      years.add(year);
    } else {
      firstYear = false;
      secondYear = false;
      thirdYear = true;

      years.add(year);
    }
    emit(ChangeValue());
  }
}
