import 'package:cached_network_image/cached_network_image.dart';
import 'package:education_system/student/features/profile/manager/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/locale/applocale.dart';
import '../../../shared/constants.dart';
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
            title: Text(
              '${getLang(context, "My Profile")}',
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: cubit.profileImage,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 80,
                        backgroundColor: const Color(0xFF6E85B7),
                        backgroundImage: imageProvider,
                      ),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        radius: 80,
                        backgroundColor: Color(0xFF6E85B7),
                        backgroundImage:
                            NetworkImage("assets/images/profile purple.png"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cubit.changeProfileImage(context, isTeacher: true);
                      },
                      child:
                          state is ImageLoading?
                      const Center(
                        child: CircularProgressIndicator(),
                    ):
                      const CircleAvatar(
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
                  title: Text('${getLang(context, "Personal Data")}'),
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
                        labelText: '${getLang(context, "Name")}',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyTextField(
                        controller: cubit.passwordController,
                        labelText: '${getLang(context, "Certificate")}',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyTextField(
                        controller: cubit.parentPhoneController,
                        labelText: '${getLang(context, "Experience")}',
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
                        controller: cubit.parentNameController,
                        labelText: '${getLang(context, "Center Name")}',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyTextField(
                        onChanged: (value) {
                          if (!isNumber(value)) {
                            cubit.phoneController.clear();
                            cubit.emit(CheckIsNumber());
                          }
                        },
                        controller: cubit.phoneController,
                        labelText: '${getLang(context, "Center Number")}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
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
                            borderRadius:
                                BorderRadius.circular(8.0), // Border radius
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8),
                          child: Text(
                            '${getLang(context, "Update")}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                const SizedBox(height: 20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cubit.planTitles.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: cubit.planTitles[index],
                              decoration: InputDecoration(
                                hintText: '${getLang(context, "Title")}',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ],
                        )),
                        const SizedBox(width: 10),
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: cubit.planSubject1[index],
                                  decoration: InputDecoration(
                                    hintText:
                                        '${getLang(context, "Study Plan")}',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: cubit.planSubject2[index],
                                  decoration: InputDecoration(
                                    hintText:
                                        '${getLang(context, "Study Plan")}',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: cubit.planSubject3[index],
                                  decoration: InputDecoration(
                                    hintText:
                                        '${getLang(context, "Study Plan")}',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: cubit.planSubject4[index],
                                  decoration: InputDecoration(
                                    hintText:
                                        '${getLang(context, "Study Plan")}',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(height: 10),
                        MaterialButton(
                          shape: const CircleBorder(),
                          onPressed: () {
                            if (cubit.planTitles.length - 1 == index) {
                              cubit.addMonth();
                            } else {
                              cubit.removeMonth(cubit.planTitles[index],
                                  cubit.planSubject1[index]);
                            }
                          },
                          child: cubit.planTitles.length - 1 == index
                              ? const Icon(Icons.add)
                              : const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                ),
                const SizedBox(height: 20),
                state is SavePlanLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          cubit.savePlan();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsAsset.kPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8.0), // Border radius
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8),
                          child: Text(
                            '${getLang(context, "Save Study Plan")}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      },
    );
  }
}
