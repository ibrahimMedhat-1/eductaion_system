part of 'add_pdf_cubit.dart';

@immutable
sealed class AddPdfState {}

final class AddPdfInitial extends AddPdfState {}

final class UploadfileLoading extends AddPdfState {}

final class UploadfileSuccess extends AddPdfState {}

final class UploadfileFail extends AddPdfState {}

final class PdfAddedSuccessfully extends AddPdfState {}

final class PdfAddedLoading extends AddPdfState {}

final class RemovePdf extends AddPdfState {}
