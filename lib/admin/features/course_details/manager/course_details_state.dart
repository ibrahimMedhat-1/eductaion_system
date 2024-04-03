part of 'course_details_cubit.dart';

@immutable
abstract class CourseDetailsState {}

class CourseDetailsInitial extends CourseDetailsState {}

class ChangeValue extends CourseDetailsState {}

class GetCourseDetails extends CourseDetailsState {}

class GetTeachers extends CourseDetailsState {}

class AssignTeacherLoading extends CourseDetailsState {}

class AssignTeacherDone extends CourseDetailsState {}
