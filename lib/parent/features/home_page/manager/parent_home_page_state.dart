part of 'parent_home_page_cubit.dart';

@immutable
sealed class ParentHomePageState {}

final class ParentHomePageInitial extends ParentHomePageState {}

final class GetStudentsData extends ParentHomePageState {}

final class GetChildQuizzesLoading extends ParentHomePageState {}

final class GetChildQuizzesSuccessfully extends ParentHomePageState {}
