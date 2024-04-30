part of 'course_details_cubit.dart';

@immutable
abstract class CourseDetailsState {}

class CourseDetailsInitial extends CourseDetailsState {}

class ChangeValue extends CourseDetailsState {}

class GetCourseDetails extends CourseDetailsState {}

class GetTeachers extends CourseDetailsState {}

class AssignTeacherLoading extends CourseDetailsState {}
class ImageLoading extends CourseDetailsState {}
class GetImageSuccess extends CourseDetailsState {}
class Loading extends CourseDetailsState {}

class AssignTeacherDone extends CourseDetailsState {}
