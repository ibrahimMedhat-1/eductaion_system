part of 'my_grades_cubit.dart';

@immutable
sealed class MyGradesState {}

final class MyGradesInitial extends MyGradesState {}

final class GetMyCoursesGradesLoading extends MyGradesState {}

final class GetMyCoursesGradesSuccessfully extends MyGradesState {}

final class GetMyCoursesGradesError extends MyGradesState {}

final class GetMyQuizzesLoading extends MyGradesState {}

final class GetMyQuizzesSuccessfully extends MyGradesState {}

final class GetMyQuizzesError extends MyGradesState {}
