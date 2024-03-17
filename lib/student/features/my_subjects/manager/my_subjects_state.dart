part of 'my_subjects_cubit.dart';

@immutable
sealed class MySubjectsState {}

final class MySubjectsInitial extends MySubjectsState {}

final class GetMyCoursesLoading extends MySubjectsState {}

final class GetMyCoursesSuccessfully extends MySubjectsState {}
