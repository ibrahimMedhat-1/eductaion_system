import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/models/student_model.dart';
import 'package:education_system/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'view_students_state.dart';

class ViewStudentsCubit extends Cubit<ViewStudentsState> {
  ViewStudentsCubit() : super(ViewStudentsInitial());
  static ViewStudentsCubit get(context) => BlocProvider.of(context);

  List<StudentModel> students = [];
  List<StudentModel> viewStudentsList = [];
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
          students.add(StudentModel.fromJson(value.data()));
        });
        print(students.length);
      }
      viewStudentsList = students;
      emit(GetCourseStudents());
    });
  }

  TextEditingController searchController = TextEditingController();
  List<StudentModel> searchStudentsList = [];

  void searchStudent(String name) {
    searchStudentsList.clear();
    for (StudentModel studentModel in students) {
      if (studentModel.name.toString().toLowerCase().startsWith(name.toLowerCase())) {
        searchStudentsList.add(studentModel);
      }
    }
    viewStudentsList = searchStudentsList;
    emit(IsSearching());
  }

  void isNotSearching() {
    viewStudentsList = students;
    emit(IsNotSearching());
  }
}
