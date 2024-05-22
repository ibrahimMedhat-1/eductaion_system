import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'question_view_state.dart';

class QuestionViewCubit extends Cubit<QuestionViewState> {
  QuestionViewCubit() : super(QuestionViewInitial());
  static QuestionViewCubit get(context) => BlocProvider.of(context);
  TextEditingController questionController = TextEditingController();
  TextEditingController answer1Controller = TextEditingController();
  TextEditingController answer2Controller = TextEditingController();
  TextEditingController answer3Controller = TextEditingController();
  TextEditingController modelAnswerController = TextEditingController();
}
