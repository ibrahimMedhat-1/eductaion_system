import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/admin/features/home/view/home_page.dart';
import 'package:education_system/models/parent_model.dart';
import 'package:education_system/models/student_model.dart';
import 'package:education_system/parent/features/home_page/view/parent_home_page.dart';
import 'package:education_system/student/features/home/student_home_page.dart';
import 'package:education_system/teacher/features/home/teacher_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/teacher_model.dart';
import '../../../shared/constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isProfessor = false;
  bool isAdmin = false;

  void changeToadmin() {
    isProfessor = false;
    isAdmin = !isAdmin;
    emit(ChangeType());
  }

  bool isParent = false;

  void changeToParent() {
    isProfessor = false;
    isAdmin = false;
    isParent = !isParent;
    emit(ChangeType());
  }

  void changeToProfessor() {
    isAdmin = false;
    isProfessor = !isProfessor;
    emit(ChangeType());
  }

  void login(context) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text)
        .then((value) async {
      if (isProfessor) {
        await FirebaseFirestore.instance
            .collection('teachers')
            .where('email', isEqualTo: emailController.text.trim())
            .get()
            .then((value) {
          if (value.docs.isEmpty) {
            emit(LoginError());
            print('h');
            Fluttertoast.showToast(msg: 'Not a professor');
          } else {
            print(value.docs);
            Constants.teacherModel = TeacherModel.fromJson(value.docs[0].data());
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TeacherLayout(),
                ));
          }
        }).catchError((onError) {
          emit(LoginError());
          print('k$onError');
          Fluttertoast.showToast(msg: 'Not a professor');
        });
      } else if (isAdmin) {
        await FirebaseFirestore.instance
            .collection('admin')
            .where('email', isEqualTo: emailController.text.trim())
            .get()
            .then((value) {
          if (value.docs.isEmpty) {
            emit(LoginError());
            Fluttertoast.showToast(msg: 'Not an Admin');
          } else {
            print(value.docs);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminHomePage(),
                ));
          }
        }).catchError((onError) {
          emit(LoginError());
          Fluttertoast.showToast(msg: 'Not an Admin');
        });
      } else if (isParent) {
        await FirebaseFirestore.instance
            .collection('parents')
            .doc(emailController.text.trim().toLowerCase())
            .get()
            .then((value) {
          Constants.parentModel = ParentModel.fromJson(value.data());
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ParentHomePage(),
              ));
        });
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
                builder: (context) => const StudentLayout(),
              ));
        }).catchError((onError) {
          emit(LoginError());
          Fluttertoast.showToast(msg: 'Not a student');
        });
      }
      emit(LoginSuccessfully());
    }).catchError((onError) {
      emit(LoginError());
      Fluttertoast.showToast(msg: onError.toString());
    });
  }
}
