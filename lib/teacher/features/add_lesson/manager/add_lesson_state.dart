part of 'add_lesson_cubit.dart';

@immutable
sealed class AddLessonState {}

final class AddLessonInitial extends AddLessonState {}

final class LessonAddedSuccessfully extends AddLessonState {}

final class SelectLessonVideo extends AddLessonState {}
