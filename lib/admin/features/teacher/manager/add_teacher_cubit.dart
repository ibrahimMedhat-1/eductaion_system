import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'add_teacher_state.dart';

class AddTeacherCubit extends Cubit<AddTeacherState> {
  AddTeacherCubit() : super(AddTeacherInitial());
  static AddTeacherCubit get(context) => BlocProvider.of(context);
  TextEditingController teacherNameController = TextEditingController();
  TextEditingController teacherEmailController = TextEditingController();
  TextEditingController teacherPasswordController = TextEditingController();

  String? selectedSubject ;

  final List<String> subjects = [
    'Mathematics',
    'Science',
    'English',
    'History',
    'Geography',
    'Computer Science',
  ];

  void handleSubjectChange(String newValue) {
    selectedSubject=newValue;
      emit(ChangeValue());
    }
  }



