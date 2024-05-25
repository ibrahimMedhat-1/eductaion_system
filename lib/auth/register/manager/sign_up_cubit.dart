import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/models/student_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController parentPhoneController = TextEditingController();
  TextEditingController parentEmailController = TextEditingController();
  TextEditingController parentNameController = TextEditingController();

  void signUp(context) {
    emit(SignUpLoading());
    DocumentReference id;
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text)
        .then((value) async {
      id = FirebaseFirestore.instance.collection('students').doc(value.user!.uid);
      await FirebaseFirestore.instance
          .collection('students')
          .doc(value.user!.uid)
          .set(
            StudentModel(
              image: '',
              gender: 'Male',
              reference: FirebaseFirestore.instance.collection('students').doc(value.user!.uid),
              name: fullNameController.text,
              email: emailController.text,
              phone: phoneController.text,
              id: value.user!.uid,
              password: passwordController.text,
              parentData: StudentParentData(
                parentNameController.text,
                parentEmailController.text,
                parentPhoneController.text,
              ),
            ).toMap(),
          )
          .then((value) async {
        var acs = ActionCodeSettings(
          // URL you want to redirect back to. The domain (www.example.com) for this
          // URL must be whitelisted in the Firebase Console.
          url: 'https://education-system1.firebaseapp.com/__/auth/action?mode=action&oobCode=code',
          // This must be true

          handleCodeInApp: true,
          // installIfNotAvailable
          // minimumVersion
        );
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: parentEmailController.text.trim().toLowerCase(), password: '123456')
            .then((value) async {
          await FirebaseFirestore.instance
              .collection('parents')
              .doc(parentEmailController.text.trim().toLowerCase())
              .set({
            'id': parentEmailController.text.trim().toLowerCase(),
            'studentReference': id,
          });
        });
        var response = await http.post(
          Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
          headers: {
            'Content-Type': "application/json",
          },
          body: json.encode({
            'service_id': "service_hz76xfb",
            'template_id': "template_1ro0yvz",
            'user_id': "2QByaSzIidfViDpTb",
            'template_params': {
              'from_name': 'Education System',
              'from_email': emailController.text,
              'from_number': phoneController.text,
              'from_subject': 'Your password is : 123456',
              'reply_to': 'doha.kroz0@gmail.com',
              'to_email': parentEmailController.text,
            },
          }),
        );
        emit(SignUpSuccessfully());
        Navigator.pop(context);
      }).catchError((onError) {
        emit(SignUpError());
        Fluttertoast.showToast(msg: onError.toString());
      });
    }).catchError((onError) {
      emit(SignUpError());
      Fluttertoast.showToast(msg: onError.toString());
      print(onError.toString());
    });
  }
}
