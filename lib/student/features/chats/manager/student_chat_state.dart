part of 'student_chat_cubit.dart';

@immutable
sealed class StudentChatState {}

final class StudentChatInitial extends StudentChatState {}

final class GetMyCoursesLoading extends StudentChatState {}

final class GetMyCoursesSuccessfully extends StudentChatState {}
