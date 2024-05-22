part of 'view_lesson_cubit.dart';

@immutable
sealed class ViewLessonState {}

final class SelectLessonVideo extends ViewLessonState {}
final class ViewLessonInitial extends ViewLessonState {}

final class GetLessonLoading extends ViewLessonState {}

final class UploadVideoLoading extends ViewLessonState {}

final class LessonAddedSuccessfully extends ViewLessonState {}
final class LessonAddedLoading extends ViewLessonState {}
