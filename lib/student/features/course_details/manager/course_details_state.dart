part of 'course_details_cubit.dart';

sealed class CourseDetailsState {}

final class CourseDetailsInitial extends CourseDetailsState {}

final class GetTeacherDataLoading extends CourseDetailsState {}

final class GetTeacherDataSuccessfully extends CourseDetailsState {}
