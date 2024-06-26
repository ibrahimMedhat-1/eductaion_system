import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/models/student_model.dart';
import 'package:education_system/models/teacher_model.dart';
import 'package:education_system/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController   = TextEditingController();
  TextEditingController idController      = TextEditingController();
  TextEditingController phoneController    = TextEditingController();
  TextEditingController passwordController  = TextEditingController();
  TextEditingController parentNameController = TextEditingController();
  TextEditingController parentPhoneController = TextEditingController();
  TextEditingController parentEmailController  = TextEditingController();

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
                courseId: Constants.teacherModel!.courseId,
                subject: Constants.teacherModel!.subject,
                years: Constants.teacherModel!.years,
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
              courseId: Constants.teacherModel!.courseId,
              subject: Constants.teacherModel!.subject,
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

  void changeProfileImage(context, {bool isTeacher = false}) async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) async {
      ImageCropper().cropImage(sourcePath: value!.path, cropStyle: CropStyle.circle, uiSettings: [
        WebUiSettings(
          viewPort: CroppieViewPort(
              height: (MediaQuery.of(context).size.height *0.6).toInt(),width: (MediaQuery.of(context).size.height *0.6).toInt()

          ),
          boundary: CroppieBoundary(
            height: (MediaQuery.of(context).size.height *0.55).toInt(),width: (MediaQuery.of(context).size.height *0.6).toInt()
          ),
          context: context,
        )
      ]).then((value) async {
        emit(ImageLoading());
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
      });
    }).catchError((onError) {
      print('1');
      print(onError);
    });
  }

  List<TextEditingController> planTitles = [
    TextEditingController(),
  ];
  List<TextEditingController> planSubject1 = [
    TextEditingController(),
  ];
  List<TextEditingController> planSubject2 = [
    TextEditingController(),
  ];
  List<TextEditingController> planSubject3 = [
    TextEditingController(),
  ];
  List<TextEditingController> planSubject4 = [
    TextEditingController(),
  ];

  void addMonth() {
    planTitles.add(TextEditingController());
    planSubject1.add(TextEditingController());
    planSubject2.add(TextEditingController());
    planSubject3.add(TextEditingController());
    planSubject4.add(TextEditingController());
    emit(AddPlan());
  }

  void removeMonth(TextEditingController titleController, TextEditingController subjectController) {
    planTitles.remove(titleController);
    planSubject1.remove(subjectController);
    planSubject2.remove(subjectController);
    planSubject3.remove(subjectController);
    planSubject4.remove(subjectController);
    emit(RemovePlan());
  }

  void savePlan() async {
    emit(SavePlanLoading());
    List<Map<String, dynamic>> plan = [];
    for (int i = 0; i < planTitles.length; i++) {
      plan.add({
        'title': planTitles[i].text,
        'plan': planSubject1[i].text,
        'plan2':planSubject2[i].text,
        'plan3':planSubject3[i].text,
        'plan4':planSubject4[i].text,
      });
    }
    await FirebaseFirestore.instance
        .collection('secondary years')
        .doc(Constants.teacherModel!.years!.first)
        .collection(Constants.teacherModel!.subject!)
        .doc(Constants.teacherModel!.courseId!.toString().trim())
        .update({
      'study plan': plan,
    }).then((value) {
      emit(SavePlanSuccessfully());
    }).catchError((onError) {
      emit(SavePlanError());
      print(onError);
    });
  }
}
