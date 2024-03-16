import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../../../../models/course_model.dart';
import '../../../../models/offer_model.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());

  static HomePageCubit get(context) => BlocProvider.of(context);

  List<CourseModel> courses = [];
  List<OfferModel> offers = [];
  List<CourseModel> searchList = [];

  void getCourses(value) async {
    emit(GetCoursesLoading());
    courses.clear();
    String year = 'first secondary';
    if (value == 'الصف الاول' || value == 'first secondary') {
      year = 'first Secondary';
    } else if (value == 'الصف الثاني' || value == 'second secondary') {
      year = 'second Secondary';
    } else if (value == 'الصف الثالث' || value == 'third secondary') {
      year = 'third Secondary';
    }
    await FirebaseFirestore.instance.collection('secondary years').doc(year).get().then((value) {
      print('1');
      for (var subject in value.data()!['subjects']) {
        FirebaseFirestore.instance
            .collection('secondary years')
            .doc(year)
            .collection(subject)
            .get()
            .then((value) {
          value.docs.forEach((element) {
            courses.add(CourseModel.fromJson(element.data()));
          });
          emit(GetCoursesSuccessfully());
        }).catchError((onError) {
          emit(GetCoursesError());
          print(onError.toString());
          Fluttertoast.showToast(msg: onError.toString());
        });
      }
      emit(GetCoursesSuccessfully());
    }).catchError((onError) {
      print('2');
      emit(GetCoursesError());
      print(onError.toString());
      Fluttertoast.showToast(msg: onError.toString());
    });
  }

  void getOffers() {}

  void search() {}
}
