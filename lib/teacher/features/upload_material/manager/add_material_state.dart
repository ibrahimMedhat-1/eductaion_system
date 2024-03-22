part of 'add_material_cubit.dart';

sealed class AddMaterialState {}

final class AddMaterialInitial extends AddMaterialState {}

final class GetMaterialLoading extends AddMaterialState {}

final class GetMaterialSuccessfully extends AddMaterialState {}

final class GetMaterialError extends AddMaterialState {}
