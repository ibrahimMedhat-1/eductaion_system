part of 'add_teacher_cubit.dart';

@immutable
abstract class AddTeacherState {}

class AddTeacherInitial extends AddTeacherState {}

class ChangeValue extends AddTeacherState {}

class GetSubjects extends AddTeacherState {}

class AddTeacherLoading extends AddTeacherState {}

class AddTeacherSuccessfully extends AddTeacherState {}

class AddTeacherError extends AddTeacherState {}
