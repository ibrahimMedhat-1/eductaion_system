part of 'my_assignments_cubit.dart';

@immutable
sealed class MyAssignmentsState {}

final class MyAssignmentsInitial extends MyAssignmentsState {}

final class GetMyCoursesAssignmentsLoading extends MyAssignmentsState {}

final class GetMyCoursesAssignmentsSuccessfully extends MyAssignmentsState {}

final class GetMyCoursesAssignmentsError extends MyAssignmentsState {}

final class GetMyAssignmentsLoading extends MyAssignmentsState {}

final class GetMyAssignmentsSuccessfully extends MyAssignmentsState {}

final class GetMyAssignmentsError extends MyAssignmentsState {}
