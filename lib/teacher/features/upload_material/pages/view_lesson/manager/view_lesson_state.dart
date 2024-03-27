part of 'view_lesson_cubit.dart';

@immutable
sealed class ViewLessonState {}

final class ViewLessonInitial extends ViewLessonState {}

final class GetLessonLoading extends ViewLessonState {}

final class GetLessonError extends ViewLessonState {}

final class GetLessonSuccessfully extends ViewLessonState {}
