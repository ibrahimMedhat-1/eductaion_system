part of 'course_quiz_cubit.dart';

@immutable
sealed class CourseQuizState {}

final class CourseQuizInitial extends CourseQuizState {}

final class GetQuizzesSuccessfully extends CourseQuizState {}

final class GetQuizzesLoading extends CourseQuizState {}
