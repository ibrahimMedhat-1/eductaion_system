part of 'subjects_cubit.dart';

@immutable
abstract class SubjectsState {}

class SubjectsInitial extends SubjectsState {}

class ChangeValue extends SubjectsState {}

class GetSubjects extends SubjectsState {}

class GetSubjectsLoading extends SubjectsState {}

class GetCoursesLoading extends SubjectsState {}

class GetCoursesError extends SubjectsState {}

class GetCoursesSuccessfully extends SubjectsState {}
