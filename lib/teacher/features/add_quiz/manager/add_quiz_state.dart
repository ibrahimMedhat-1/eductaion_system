part of 'add_quiz_cubit.dart';

abstract class AddQuizState {}

class AddQuizInitial extends AddQuizState {}

class AllQuizQuestionsGenerated extends AddQuizState {}

class QuizAddedSuccessfully extends AddQuizState {}

class QuizAddedLoading extends AddQuizState {}

class GetQuizDataSuccessfully extends AddQuizState {}
