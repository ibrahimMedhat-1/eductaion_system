import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'student_chat_state.dart';

class StudentChatCubit extends Cubit<StudentChatState> {
  StudentChatCubit() : super(StudentChatInitial());
}
