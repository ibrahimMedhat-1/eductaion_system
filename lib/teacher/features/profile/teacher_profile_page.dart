import 'package:cached_network_image/cached_network_image.dart';
import 'package:eductaion_system/student/features/profile/manager/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/utils/colors.dart';
import '../../../student/features/payment/widgets/my_text_field.dart';

class TeacherProfilePage extends StatelessWidget {
  const TeacherProfilePage({super.key});

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
            title: const Text(
              'My Profile',
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
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: cubit.profileImage,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 80,
                      backgroundColor: Color(0xFF6E85B7),
                      backgroundImage: imageProvider,
                    ),
                    errorWidget: (context, url, error) => const CircleAvatar(
                      radius: 80,
                      backgroundColor: Color(0xFF6E85B7),
                      backgroundImage: NetworkImage("assets/images/profile purple.png"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cubit.changeProfileImage(isTeacher: true);
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorsAsset.kLight2,
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          color: ColorsAsset.kPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text("Personal Data"),
                tileColor: ColorsAsset.kLightPurble,
                leading: Icon(
                  Icons.person,
                  color: ColorsAsset.kPrimary,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    MyTextField(
                      controller: cubit.nameController,
                      labelText: "Name",
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MyTextField(
                      controller: cubit.passwordController,
                      labelText: "Certificate",
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MyTextField(
                      controller: cubit.parentPhoneController,
                      labelText: "Experience",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    MyTextField(
                      controller: cubit.parentNameController,
                      labelText: "Center Name",
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MyTextField(
                      controller: cubit.phoneController,
                      labelText: "Center Number",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              state is UpdateDataLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        cubit.updateData(context, isTeacher: true);
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
    );
  }
}
