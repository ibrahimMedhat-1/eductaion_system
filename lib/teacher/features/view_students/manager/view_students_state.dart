part of 'view_students_cubit.dart';

@immutable
sealed class ViewStudentsState {}

final class ViewStudentsInitial extends ViewStudentsState {}

final class GetCourseStudents extends ViewStudentsState {}

final class IsSearching extends ViewStudentsState {}

final class IsNotSearching extends ViewStudentsState {}
