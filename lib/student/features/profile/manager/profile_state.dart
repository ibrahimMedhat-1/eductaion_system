part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class InitializeControllers extends ProfileState {}

final class ChangeGender extends ProfileState {}

final class UpdateDataError extends ProfileState {}

final class UpdateDataLoading extends ProfileState {}

final class UpdateDataSuccessfully extends ProfileState {}
