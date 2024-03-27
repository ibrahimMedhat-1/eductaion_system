import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../models/course_model.dart';

part 'my_subjects_state.dart';

class MySubjectsCubit extends Cubit<MySubjectsState> {
  MySubjectsCubit() : super(MySubjectsInitial());
  static MySubjectsCubit get(context) => BlocProvider.of(context);

  List<CourseModel> myCourses = [];
  void getMyCourses() async {
    emit(GetMyCoursesLoading());
    await Constants.studentModel!.reference!.collection('courses').get().then((value) async {
      for (var element in value.docs) {
        DocumentReference<Map<String, dynamic>> course = await element.data()['reference'];
        await course.get().then((value) {
          myCourses.add(CourseModel.fromJson(value.data()));
        });
      }
      emit(GetMyCoursesSuccessfully());
    });
  }
}
