import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit() : super(CourseDetailsInitial());
  static CourseDetailsCubit get(context) => BlocProvider.of(context);
  bool isFirstYearSelected = false;
  bool isSecondYearSelected = false;
  bool isThirdYearSelected = false;
  String? selectedTeacher ;


  void handleTeacherChange(String newValue) {
    selectedTeacher=newValue;
    emit(ChangeValue());
  }
  final List<String> Teachers = [
    'Teacher1',
    'Teacher2',
    'Teacher3',

  ];

}

