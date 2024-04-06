import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/models/course_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../models/teacher_model.dart';

part 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit() : super(CourseDetailsInitial());

  static CourseDetailsCubit get(context) => BlocProvider.of(context);
  bool isFirstYearSelected = false;
  bool isSecondYearSelected = false;
  bool isThirdYearSelected = false;
  TeacherModel? selectedTeacher;

  void handleTeacherChange(TeacherModel newValue) {
    selectedTeacher = newValue;
    emit(ChangeValue());
  }

  CourseModel? courseModel;

  void getCourseDetails(year, subject, courseId) async {
    await FirebaseFirestore.instance
        .collection('secondary years')
        .doc(isFirstYearSelected
            ? 'first Secondary'
            : isSecondYearSelected
                ? 'second Secondary'
                : 'third Secondary')
        .collection(subject)
        .doc(courseId.toString().trim())
        .get()
        .then((value) {
      print(value.data());
      courseModel = CourseModel.fromJson(value.data());
      emit(GetCourseDetails());
    }).catchError((onError) {
      print(onError);
    });
  }

  List<TeacherModel> teachers = [];

  void getTeachers() async {
    await FirebaseFirestore.instance.collection('teachers').get().then((value) {
      for (var teacher in value.docs) {
        teachers.add(TeacherModel.fromJson(teacher.data()));
        print(teacher.data());
      }
      emit(GetTeachers());
    });
  }

  Future<void> assignTeacher(DocumentReference<Map<String, dynamic>> courseRef) async {
    emit(AssignTeacherLoading());
    await courseRef.update({
      'teacher name': selectedTeacher!.name,
      'teacher': FirebaseFirestore.instance.collection('teachers').doc(selectedTeacher!.id),
    });

    await FirebaseFirestore.instance
        .collection('teachers')
        .doc(selectedTeacher!.id!.trim())
        .update({'courseId': courseModel!.id, 'courseReference': courseModel!.reference});

    emit(AssignTeacherDone());
  }
}
