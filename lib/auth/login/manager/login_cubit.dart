import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eductaion_system/models/student_model.dart';
import 'package:eductaion_system/student/features/home/student_home_page.dart';
import 'package:eductaion_system/teacher/features/home/teacher_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../shared/constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isProfessor = false;

  void changeType() {
    isProfessor = !isProfessor;
    emit(ChangeType());
  }

  void login(context) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text)
        .then((value) async {
      if (isProfessor) {
        var professor = await FirebaseFirestore.instance
            .collection('professors')
            .where('email', isEqualTo: emailController.text)
            .get()
            .then((value) {})
            .catchError((onError) {
          emit(LoginError());
          Fluttertoast.showToast(msg: onError.toString());
        });
        if (professor != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TeacherLayout(),
              ));
        } else {
          emit(LoginError());
          Fluttertoast.showToast(msg: 'Not a professor');
        }
      } else {
        await FirebaseFirestore.instance
            .collection('students')
            .where('email', isEqualTo: emailController.text)
            .get()
            .then((value) {
          Constants.studentModel = StudentModel.fromJson(value.docs.first.data());
          print(Constants.studentModel!.parentData!.email);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Studentlayout(),
              ));
        }).catchError((onError) {
          emit(LoginError());
          Fluttertoast.showToast(msg: onError.toString());
        });
      }
      emit(LoginSuccessfully());
    }).catchError((onError) {
      emit(LoginError());
      Fluttertoast.showToast(msg: onError.toString());
    });
  }
}
