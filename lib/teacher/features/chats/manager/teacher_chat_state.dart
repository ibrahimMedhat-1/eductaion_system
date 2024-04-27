part of 'teacher_chat_cubit.dart';

@immutable
sealed class TeacherChatState {}

final class TeacherChatInitial extends TeacherChatState {}
final class GetCourseStudents extends TeacherChatState {}
final class GetAllMessagesSuccessfully extends TeacherChatState {}
