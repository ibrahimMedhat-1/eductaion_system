import 'package:eductaion_system/models/course_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'view_course_state.dart';

class ViewCourseCubit extends Cubit<ViewCourseState> {
  ViewCourseCubit() : super(ViewCourseInitial());
  static ViewCourseCubit get(context) => BlocProvider.of(context);

  void getCourseMaterial(CourseModel courseModel) async {
    await courseModel.reference!.collection('material').get().then((value) {});
  }
}
