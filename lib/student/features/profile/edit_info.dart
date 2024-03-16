import 'package:eductaion_system/student/features/profile/manager/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/utils/colors.dart';
import '../payment/widgets/my_text_field.dart';

class EditInfoPage extends StatelessWidget {
  const EditInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..initializeControllers(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final ProfileCubit cubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit My Data',
                style: TextStyle(color: ColorsAsset.kPrimary),
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
                const ListTile(
                  title: Text("Personal Data"),
                  tileColor: ColorsAsset.kLightPurble,
                  leading: Icon(
                    Icons.person,
                    color: ColorsAsset.kPrimary,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      MyTextField(
                        controller: cubit.nameController,
                        labelText: "Student Name",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MyTextField(
                        controller: cubit.idController,
                        labelText: "Student ID",
                      ),
                      SizedBox(
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
                        controller: cubit.phoneController,
                        labelText: "Phone Number",
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyTextField(
                        controller: cubit.passwordController,
                        labelText: "Password",
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: DropdownButtonFormField<String>(
                          value: cubit.selectedGender,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorsAsset.kPrimary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorsAsset.kPrimary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorsAsset.kPrimary),
                            ),
                            labelText: 'Gender',
                          ),
                          items: cubit.genders.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            cubit.setSelectGender(newValue!);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const ListTile(
                  title: Text("Parent Data"),
                  tileColor: ColorsAsset.kLightPurble,
                  leading: Icon(
                    Icons.family_restroom,
                    color: ColorsAsset.kPrimary,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      MyTextField(
                        controller: cubit.parentNameController,
                        labelText: "Name",
                      ),
                      SizedBox(width: 10),
                      MyTextField(
                        controller: cubit.parentPhoneController,
                        labelText: "Phone Number",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MyTextField(
                        controller: cubit.parentEmailController,
                        labelText: "Email",
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
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
