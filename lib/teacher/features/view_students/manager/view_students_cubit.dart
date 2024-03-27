import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'view_students_state.dart';

class ViewStudentsCubit extends Cubit<ViewStudentsState> {
  ViewStudentsCubit() : super(ViewStudentsInitial());
  static ViewStudentsCubit get(context) => BlocProvider.of(context);

  List<Map<String, dynamic>> students = [];
  void getCourseStudents(String year) async {
    await FirebaseFirestore.instance
        .collection('secondary years')
        .doc(year)
        .collection(Constants.teacherModel!.subject!)
        .doc(Constants.teacherModel!.courseId!.trim())
        .collection('students')
        .get()
        .then((value) async {
      for (var element in value.docs) {
        DocumentReference<Map<String, dynamic>> reference = await element.data()['reference'];
        await reference.get().then((value) {
          students.add(value.data()!);
        });
        print(students.length);
      }
      emit(GetCourseStudents());
    });
  }
}
