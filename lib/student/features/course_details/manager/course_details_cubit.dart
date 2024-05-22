import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/models/course_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/constants.dart';

part 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit() : super(CourseDetailsInitial());

  DocumentSnapshot<Map<String, dynamic>>? teacherData;
  static CourseDetailsCubit get(context) => BlocProvider.of(context);
  void getProfessorDetails(DocumentReference<Map<String, dynamic>>? teacherReference) async {
    emit(GetTeacherDataLoading());
    teacherData = teacherReference != null ? await teacherReference.get() : null;
    emit(GetTeacherDataSuccessfully());
  }

  bool isMyCourse = false;
  void checkIfMyCourse(CourseModel courseModel) async {
    await Constants.studentModel!.reference!.collection('courses').get().then((value) async {
      for (var element in value.docs) {
        DocumentReference<Map<String, dynamic>> course = await element.data()['reference'];
        if (courseModel.id == course.id) {
          isMyCourse = true;
          print(isMyCourse);
          emit(GetTeacherDataSuccessfully());
        }
      }
    });
  }
}
