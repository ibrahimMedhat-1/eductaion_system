import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'view_lesson_state.dart';

class ViewLessonCubit extends Cubit<ViewLessonState> {
  ViewLessonCubit() : super(ViewLessonInitial());
  static ViewLessonCubit get(context) => BlocProvider.of(context);
}
