import 'package:eductaion_system/models/course_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'view_course_state.dart';

class ViewCourseCubit extends Cubit<ViewCourseState> {
  ViewCourseCubit() : super(ViewCourseInitial());
  static ViewCourseCubit get(context) => BlocProvider.of(context);

  List<Map<String, dynamic>> material = [];
  void getCourseMaterial(CourseModel courseModel) async {
    emit(GetMaterialLoading());
    await courseModel.reference!.collection('material').snapshots().listen((value) {
      material.clear();
      for (var element in value.docs) {
        material.add(element.data());
      }
      emit(GetMaterialSuccessfully());
    });
  }

  int index = 0;
  void select(Map<String, dynamic>? selectedItem, index) {
    this.index = index;
    emit(SelectMaterial());
  }
}
