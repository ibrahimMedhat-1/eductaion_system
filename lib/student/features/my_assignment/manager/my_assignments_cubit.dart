import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../models/course_model.dart';
import '../../../../shared/constants.dart';

part 'my_assignments_state.dart';

class MyAssignmentsCubit extends Cubit<MyAssignmentsState> {
  MyAssignmentsCubit() : super(MyAssignmentsInitial());
  static MyAssignmentsCubit get(context) => BlocProvider.of(context);
  List<CourseModel> courses = [];
  void myCoursesAssignments() async {
    emit(GetMyCoursesAssignmentsLoading());
    await FirebaseFirestore.instance
        .collection('students')
        .doc(Constants.studentModel!.id)
        .collection('assignment')
        .get()
        .then((value) async {
      for (var element in value.docs) {
        DocumentReference<Map<String, dynamic>> course = element.data()['reference'];
        await course.get().then((value) {
          courses.add(CourseModel.fromJson(value.data()));
          print(courses);
        }).catchError((onError) {
          print(onError.toString());
          emit(GetMyCoursesAssignmentsError());
        });
      }
      emit(GetMyCoursesAssignmentsSuccessfully());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetMyCoursesAssignmentsError());
    });
  }

  final List<Map<String, dynamic>> assignments = [];
  List<List<String>> selectedAnswers = [];
  List<List<String>> groupAnswers = [];

  void myAssignments(String id) async {
    print(id);
    print(Constants.studentModel!.id);
    emit(GetMyAssignmentsLoading());

    await FirebaseFirestore.instance
        .collection('students')
        .doc(Constants.studentModel!.id)
        .collection('assignment')
        .doc(id.trim())
        .collection('assignment')
        .get()
        .then((value) {
      print(value.docs);
      print('value.docs');
      for (var element in value.docs) {
        assignments.add(element.data());
      }
    }).catchError((onError) {
      print(onError.toString());
    });

    for (var element in assignments) {
      List<String> answers = [];

      for (var question in element['questions']) {
        List<String> allAnswers = [];
        allAnswers.add(question['answer1']);
        allAnswers.add(question['answer2']);
        allAnswers.add(question['answer3']);
        answers.add(question['myAnswer']);
        groupAnswers.add(allAnswers);
      }
      selectedAnswers.add(answers);
    }
    print(selectedAnswers);
    emit(GetMyAssignmentsSuccessfully());
  }
}
