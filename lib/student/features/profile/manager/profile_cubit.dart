import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eductaion_system/models/student_model.dart';
import 'package:eductaion_system/models/teacher_model.dart';
import 'package:eductaion_system/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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
    nameController.text = Constants.studentModel?.name ?? Constants.teacherModel!.name!;
    idController.text = Constants.studentModel?.id ?? Constants.teacherModel!.id!;
    phoneController.text = Constants.studentModel?.phone! ?? Constants.teacherModel!.centerNo!;
    passwordController.text = Constants.studentModel?.password ?? Constants.teacherModel!.degree!;
    parentNameController.text =
        Constants.studentModel?.parentData?.name ?? Constants.teacherModel!.centerName!;
    parentPhoneController.text = Constants.studentModel?.parentData?.phone ?? Constants.teacherModel!.bio!;
    parentEmailController.text = Constants.studentModel?.parentData?.email ?? '';
    emit(InitializeControllers());
  }

  List<String> genders = [
    "Male",
    "Female",
  ];
  String? selectedGender;

  void setSelectGender(String newValue) {
    selectedGender = newValue;
    emit(ChangeProfileImage());
  }

  String name = Constants.studentModel?.name ?? Constants.teacherModel!.name!;
  void updateData(context, {bool isTeacher = false}) async {
    emit(UpdateDataLoading());
    await FirebaseFirestore.instance
        .collection(isTeacher ? 'teachers' : 'students')
        .doc(Constants.studentModel?.id ?? Constants.teacherModel!.id)
        .update(isTeacher
            ? TeacherModel(
                image: Constants.teacherModel!.image,
                name: nameController.text,
                email: Constants.teacherModel!.email,
                degree: passwordController.text,
                centerNo: phoneController.text,
                centerName: parentNameController.text,
                bio: parentPhoneController.text,
                id: Constants.teacherModel!.id,
              ).toMap()
            : StudentModel(
                image: Constants.studentModel!.image,
                name: nameController.text,
                reference: Constants.studentModel!.reference,
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
      isTeacher
          ? Constants.teacherModel = TeacherModel(
              image: Constants.teacherModel!.image,
              name: nameController.text,
              email: Constants.teacherModel!.email,
              degree: passwordController.text,
              centerNo: phoneController.text,
              centerName: parentNameController.text,
              bio: parentPhoneController.text,
              id: Constants.teacherModel!.id,
            )
          : Constants.studentModel = StudentModel(
              image: Constants.studentModel!.image,
              name: nameController.text,
              reference: Constants.studentModel!.reference,
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
      name = isTeacher ? Constants.teacherModel!.name! : Constants.studentModel!.name!;
      emit(UpdateDataSuccessfully());
      Navigator.pop(context);
    }).catchError((onError) {
      emit(UpdateDataError());
      Fluttertoast.showToast(msg: onError.toString());
    });
  }

  String profileImage = Constants.studentModel?.image ?? Constants.teacherModel?.image ?? '';

  void changeProfileImage({bool isTeacher = false}) async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) async {
      final image = await value!.readAsBytes();
      await FirebaseStorage.instance
          .ref()
          .child(Constants.studentModel?.id ?? Constants.teacherModel!.id!)
          .putData(
            image,
            SettableMetadata(contentType: 'image/png'),
          )
          .then((p0) async {
        await p0.ref.getDownloadURL().then((value) async {
          await FirebaseFirestore.instance
              .collection(isTeacher ? 'teachers' : 'students')
              .doc(Constants.studentModel?.id ?? Constants.teacherModel!.id)
              .update({'image': value}).then((value) async {
            await FirebaseFirestore.instance
                .collection(isTeacher ? 'teachers' : 'students')
                .doc(Constants.studentModel?.id ?? Constants.teacherModel!.id)
                .get()
                .then((value) {
              isTeacher
                  ? Constants.teacherModel = TeacherModel.fromJson(value.data())
                  : Constants.studentModel = StudentModel.fromJson(value.data());
              profileImage = Constants.studentModel?.image ?? Constants.teacherModel!.image!;
              print(profileImage);
              emit(ChangeProfileImage());
            });
          });
        });
      }).catchError((onError) {
        print('2');
        print(onError);
      });
    }).catchError((onError) {
      print('1');
      print(onError);
    });
  }
}
