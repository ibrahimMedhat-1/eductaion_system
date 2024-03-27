import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_material_state.dart';

class AddMaterialCubit extends Cubit<AddMaterialState> {
  AddMaterialCubit() : super(AddMaterialInitial());
  static AddMaterialCubit get(context) => BlocProvider.of(context);

  List<Map<String, dynamic>> material = [];
  void getCourseMaterial(String year) async {
    print(year);
    print(Constants.teacherModel!.subject!);
    print(Constants.teacherModel!.courseId!);
    emit(GetMaterialLoading());
    FirebaseFirestore.instance
        .collection('secondary years')
        .doc(year)
        .collection(Constants.teacherModel!.subject!)
        .doc(Constants.teacherModel!.courseId!.trim())
        .collection('material')
        .snapshots()
        .listen((value) {
      material.clear();
      for (var element in value.docs) {
        material.add(element.data());
      }
      print(material);
      emit(GetMaterialSuccessfully());
    });
  }

  void addMaterial(DocumentReference<Map<String, dynamic>> courseReference, String type, String year) {
    var doc = FirebaseFirestore.instance
        .collection('secondary years')
        .doc(year)
        .collection(Constants.teacherModel!.subject!)
        .doc(Constants.teacherModel!.courseId!)
        .collection('material')
        .doc();
    doc.set({
      'id': doc.id,
      'reference': doc,
    });
  }
}
