part of 'home_page_cubit.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

final class GetCoursesError extends HomePageState {}

final class GetCoursesLoading extends HomePageState {}

final class GetCoursesSuccessfully extends HomePageState {}
