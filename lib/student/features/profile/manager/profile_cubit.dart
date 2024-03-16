import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eductaion_system/models/student_model.dart';
import 'package:eductaion_system/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController parentNameController = TextEditingController();
  TextEditingController parentPhoneController = TextEditingController();
  TextEditingController parentEmailController = TextEditingController();

  void initializeControllers() {
    nameController.text = Constants.studentModel!.name!;
    idController.text = Constants.studentModel!.id!;
    phoneController.text = Constants.studentModel!.phone!;
    passwordController.text = Constants.studentModel!.password!;
    parentNameController.text = Constants.studentModel!.parentData!.name!;
    parentPhoneController.text = Constants.studentModel!.parentData!.phone!;
    parentEmailController.text = Constants.studentModel!.parentData!.email!;
    selectedGender = Constants.studentModel!.gender!;
    emit(InitializeControllers());
  }

  List<String> genders = [
    "Male",
    "Female",
  ];
  String? selectedGender;

  void setSelectGender(String newValue) {
    selectedGender = newValue;
    emit(ChangeGender());
  }

  void updateData(context) async {
    emit(UpdateDataLoading());
    await FirebaseFirestore.instance
        .collection('students')
        .doc(Constants.studentModel!.id)
        .update(StudentModel(
          name: nameController.text,
          email: Constants.studentModel!.email!,
          phone: phoneController.text,
          id: idController.text,
          password: passwordController.text,
          parentData: StudentParentData(
            parentNameController.text,
            parentEmailController.text,
            parentPhoneController.text,
          ),
          gender: selectedGender,
        ).toMap())
        .then((value) {
      Constants.studentModel = StudentModel(
        name: nameController.text,
        email: Constants.studentModel!.email!,
        phone: phoneController.text,
        id: idController.text,
        password: passwordController.text,
        parentData: StudentParentData(
          parentNameController.text,
          parentEmailController.text,
          parentPhoneController.text,
        ),
        gender: selectedGender,
      );
      emit(UpdateDataSuccessfully());
      Navigator.pop(context);
    }).catchError((onError) {
      emit(UpdateDataError());
      Fluttertoast.showToast(msg: onError.toString());
    });
  }
}
