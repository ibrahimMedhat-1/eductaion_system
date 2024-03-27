part of 'student_data_cubit.dart';

@immutable
sealed class StudentDataState {}

final class StudentDataInitial extends StudentDataState {}

final class GetStudentQuizzesLoading extends StudentDataState {}

final class GetStudentQuizzesError extends StudentDataState {}

final class GetStudentQuizzesSuccessfully extends StudentDataState {}
