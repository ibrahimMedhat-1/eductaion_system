part of 'view_course_cubit.dart';

@immutable
sealed class ViewCourseState {}

final class ViewCourseInitial extends ViewCourseState {}

final class GetMaterialLoading extends ViewCourseState {}

final class GetMaterialSuccessfully extends ViewCourseState {}

final class GetMaterialError extends ViewCourseState {}

final class SelectMaterial extends ViewCourseState {}
