import 'package:education_system/student/features/profile/manager/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/locale/applocale.dart';
import '../../../shared/constants.dart';
import '../../../shared/utils/colors.dart';
import '../payment/widgets/my_text_field.dart';

class EditInfoPage extends StatelessWidget {
  const EditInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileCubit.get(context).initializeControllers();
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final ProfileCubit cubit = ProfileCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:  Text(
              '${getLang(context, "Edit Data")}',
              style: const TextStyle(color: ColorsAsset.kPrimary),
            ),
            backgroundColor: ColorsAsset.kLight2,
            actions: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset("assets/images/logo2.png"),
              ),
            ],
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
               ListTile(
                title: Text( '${getLang(context,  "Personal Data")}'),
                tileColor: ColorsAsset.kLightPurble,
                leading: const Icon(
                  Icons.person,
                  color: ColorsAsset.kPrimary,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    MyTextField(
                      controller: cubit.nameController,
                      labelText: '${getLang(context,  "Name")}',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // MyTextField(
                    //   controller: cubit.idController,
                    //   labelText: "Student ID",
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    MyTextField(
                      onChanged: (value) {
                        if (!isNumber(value)) {
                          cubit.phoneController.clear();
                          cubit.emit(CheckIsNumber());
                        }
                      },
                      controller: cubit.phoneController,
                      labelText: '${getLang(context,  "Phone No.")}',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MyTextField(
                      controller: cubit.passwordController,
                      labelText: '${getLang(context,  "Password")}'
                      ,
                    ),
                    const SizedBox(width: 10),
                    // Flexible(
                    //   child: DropdownButtonFormField<String>(
                    //     value: cubit.selectedGender,
                    //     hint: Text('Gender'),
                    //     decoration: const InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(color: ColorsAsset.kPrimary),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: ColorsAsset.kPrimary),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: ColorsAsset.kPrimary),
                    //       ),
                    //       labelText: 'Gender',
                    //     ),
                    //     items: cubit.genders.map((String value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value,
                    //         child: Text(value),
                    //       );
                    //     }).toList(),
                    //     onChanged: (String? newValue) {
                    //       cubit.setSelectGender(newValue!);
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
               ListTile(
                title: Text( '${getLang(context,  "Parent Data")}'),
                tileColor: ColorsAsset.kLightPurble,
                leading: const Icon(
                  Icons.family_restroom,
                  color: ColorsAsset.kPrimary,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    MyTextField(
                      controller: cubit.parentNameController,
                      labelText: '${getLang(context,  "Name")}',
                    ),
                    const SizedBox(width: 10),
                    MyTextField(
                      onChanged: (value) {
                        if (!isNumber(value)) {
                          cubit.parentPhoneController.clear();
                          cubit.emit(CheckIsNumber());
                        }
                      },
                      controller: cubit.parentPhoneController,
                      labelText: '${getLang(context,  "Phone No.")}',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MyTextField(
                      controller: cubit.parentEmailController,
                      labelText: '${getLang(context,  "Email")}',
                    ),
                  ],
                ),
              ),
              state is UpdateDataLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        cubit.updateData(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsAsset.kPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Border radius
                        ),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                        child: Text(
                          '${getLang(context,  "Update")}'
                          ,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
