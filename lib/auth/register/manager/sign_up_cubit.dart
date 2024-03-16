import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text)
        .then((value) {
      FirebaseFirestore.instance.collection('students').doc(value.user!.uid).set({
        'name': fullNameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'parentName': parentNameController.text,
        'parentEmail': parentEmailController.text,
        'parentPhone': parentPhoneController.text,
      }).then((value) {
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
