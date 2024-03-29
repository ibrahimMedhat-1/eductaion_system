import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  SubjectsCubit() : super(SubjectsInitial());
  static SubjectsCubit get(context) => BlocProvider.of(context);


  final List<String> subjects = [
    'Mathematics',
    'Science',
    'English',
    'History',
    'Geography',
    'Computer Science',
  ];


}
