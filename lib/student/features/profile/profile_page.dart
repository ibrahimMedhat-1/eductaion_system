import 'package:cached_network_image/cached_network_image.dart';
import 'package:education_system/student/features/profile/manager/profile_cubit.dart';
import 'package:education_system/student/features/profile/widgets/parent_data.dart';
import 'package:education_system/student/features/profile/widgets/personal_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_app/restart_app.dart';

import '../../../auth/login/login page.dart';
import '../../../shared/constants.dart';
import '../../../shared/utils/colors.dart';
import 'edit_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
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
                              backgroundImage: NetworkImage("assets/images/profile purple.png"),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.changeProfileImage(context);
                            },
                            child: const CircleAvatar(
                              radius: 22,
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
                        height: 30,
                      ),
                      const PersonalData(),
                      const FamilyDataSection(),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const EditInfoPage(),
                                    ));
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: ColorsAsset.kPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                                child: Text('Edit Data'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                Constants.teacherModel = null;
                                Constants.studentModel = null;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ));
                                Restart.restartApp();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: ColorsAsset.kPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                                child: Text('Logout'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
