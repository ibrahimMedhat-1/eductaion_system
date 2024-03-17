import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit() : super(CourseDetailsInitial());

  DocumentSnapshot<Map<String, dynamic>>? teacherData;
  static CourseDetailsCubit get(context) => BlocProvider.of(context);
  void getProfessorDetails(DocumentReference<Map<String, dynamic>> teacherReference) async {
    emit(GetTeacherDataLoading());
    teacherData = await teacherReference.get();
    emit(GetTeacherDataSuccessfully());
    print(teacherData!.data());
  }
}
