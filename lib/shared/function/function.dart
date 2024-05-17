import 'package:education_system/auth/login/login%20page.dart';
import 'package:education_system/shared/constants.dart';
import 'package:flutter/material.dart';

abstract class AppFunctions {
  static void checkLoggedIn(VoidCallback isLoggedIn, BuildContext context) {
    if (Constants.studentModel != null) {
      isLoggedIn();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ));
    }
  }
}
