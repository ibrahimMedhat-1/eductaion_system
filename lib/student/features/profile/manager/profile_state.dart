part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ImageLoading extends ProfileState {}

final class InitializeControllers extends ProfileState {}

final class ChangeProfileImage extends ProfileState {}

final class UpdateDataError extends ProfileState {}

final class UpdateDataLoading extends ProfileState {}

final class UpdateDataSuccessfully extends ProfileState {}

final class CheckIsNumber extends ProfileState {}

final class AddPlan extends ProfileState {}

final class RemovePlan extends ProfileState {}

final class SavePlanLoading extends ProfileState {}

final class SavePlanSuccessfully extends ProfileState {}

final class SavePlanError extends ProfileState {}
