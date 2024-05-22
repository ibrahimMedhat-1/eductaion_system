import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/components/locale/applocale.dart';
import 'package:education_system/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/constants.dart';

part 'view_course_state.dart';

class ViewCourseCubit extends Cubit<ViewCourseState> {
  ViewCourseCubit() : super(ViewCourseInitial());
  static ViewCourseCubit get(context) => BlocProvider.of(context);

  List<Map<String, dynamic>> material = [];
  List<bool> watched = [];
  void getCourseMaterial(CourseModel courseModel) async {
    emit(GetMaterialLoading());
    courseModel.reference!.collection('material').orderBy('date').snapshots().listen((value) {
      material.clear();
      for (var element in value.docs) {
        material.add(element.data());
        watched.add(false);
      }
      emit(GetMaterialSuccessfully());
    });
    FirebaseFirestore.instance
        .collection('students')
        .doc(Constants.studentModel!.id)
        .collection('courses')
        .doc(courseModel.id)
        .snapshots()
        .listen((value) {
      for (int i = 0; i < value.data()!['watched']; i++) {
        watched[i] = true;
        emit(GetMaterialSuccessfully());
      }
    });
  }

  int index = 0;
  void select(index) {
    this.index = index;
    print(this.index);
    emit(SelectMaterial());
  }

  void courseWatched(CourseModel courseModel, context) async {
    print(index);
    await FirebaseFirestore.instance
        .collection('students')
        .doc(Constants.studentModel!.id)
        .collection('courses')
        .doc(courseModel.id)
        .update({'watched': index + 2}).then((value) {
      emit(ViewCourseInitial());
      showDialog(
        context: context,
        builder: (context) =>  AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check,color: Colors.green,),
              Text(getLang(context, "Done"),style: const TextStyle(color: Colors.green),),
            ],
          ),
        ),
      );
    });
  }
}
