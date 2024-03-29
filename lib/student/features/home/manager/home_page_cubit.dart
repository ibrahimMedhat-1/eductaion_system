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
  List<String> subjects = [];
  List<OfferModel> offers = [];
  List<CourseModel> searchList = [];
  String year = 'first secondary';

  void getCourses(value) async {
    emit(GetCoursesLoading());
    courses.clear();
    subjects.clear();
    if (value == 'الصف الاول' || value == 'first secondary') {
      year = 'first Secondary';
    } else if (value == 'الصف الثاني' || value == 'second secondary') {
      year = 'second Secondary';
    } else if (value == 'الصف الثالث' || value == 'third secondary') {
      year = 'third Secondary';
    }
    await FirebaseFirestore.instance.collection('secondary years').doc(year).get().then((value) {
      for (var subject in value.data()!['subjects']) {
        subjects.add(subject);
        getCoursesOfSubject(subject, year);
      }
    }).catchError((onError) {
      emit(GetCoursesError());
      Fluttertoast.showToast(msg: onError.toString());
    });
  }

  void getCoursesOfSubject(subject, year) {
    courses.clear();
    emit(GetCoursesLoading());
    FirebaseFirestore.instance
        .collection('secondary years')
        .doc(year)
        .collection(subject)
        .get()
        .then((value) {
      for (var element in value.docs) {
        courses.add(CourseModel.fromJson(element.data()));
      }
      emit(GetCoursesSuccessfully());
    }).catchError((onError) {
      emit(GetCoursesError());
      print('fdf ${onError.toString()}');
      Fluttertoast.showToast(msg: onError.toString());
    });
  }

  void getOffers() {}
  void isSearching() {
    emit(IsSearching());
  }

  void isNotSearching() {
    emit(IsNotSearching());
  }

  void search(String value) {
    searchList.clear();
    for (var course in courses) {
      if (course.courseName!.toLowerCase().contains(value.toLowerCase())) {
        searchList.add(course);
        emit(SearchCourse());
      }
    }
  }
}
