import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/constants.dart';

part 'add_pdf_state.dart';

class AddPdfCubit extends Cubit<AddPdfState> {
  AddPdfCubit() : super(AddPdfInitial());

  static AddPdfCubit get(context) => BlocProvider.of(context);
  Uint8List? pdfFile;
  TextEditingController pdfNameController = TextEditingController();
  Future<void> pickAndUploadPdf(context, String year) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'pptx'],
    );

    if (result != null) {
      String fileName = result.files.single.name;
      pdfNameController.text = fileName;
      emit(UploadfileLoading());

      pdfFile = result.files.single.bytes;
      if (pdfFile != null) {
        emit(UploadfileSuccess());
      }
    }
  }

  Future<void> addPdf(
    context, {
    required String year,
    required String subject,
    required String courseId,
    required String name,
    required Uint8List? file,
    required DocumentReference<Map<String, dynamic>> courseReference,
  }) async {
    emit(PdfAddedLoading());
    var quiz = FirebaseFirestore.instance
        .collection('secondary years')
        .doc(year)
        .collection(subject)
        .doc(courseId.trim())
        .collection('material')
        .doc();
    print(courseReference);
    print(quiz.id);
    print(name);
    print(quiz);
    await FirebaseStorage.instance
        .ref()
        .child('pdf/${Constants.teacherModel!.courseId.toString().trim()}')
        .putData(
          file!,
        )
        .then((p0) {
      p0.ref.getDownloadURL().then((value) async {
        await quiz.set({
          'courseReference': courseReference,
          'id': quiz.id,
          'name': name,
          'reference': quiz,
          'pdf': value,
          'type': 'pdf',
          'date': DateTime.now().toString(),
        }).then((value) {
          emit(PdfAddedSuccessfully());
        });
      });
    });

    Navigator.pop(context);
    emit(PdfAddedSuccessfully());
  }
}
