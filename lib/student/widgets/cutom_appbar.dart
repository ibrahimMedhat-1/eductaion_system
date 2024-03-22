import 'package:cached_network_image/cached_network_image.dart';
import 'package:eductaion_system/student/features/profile/manager/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/locale/applocale.dart';
import '../../shared/main_cubit/main_cubit.dart';
import '../../shared/utils/colors.dart';
import '../features/chats/choose_chat.dart';
import '../features/home/student_home_page.dart';
import '../features/my_assignment/my_assignments_page.dart';
import '../features/my_grades/view/my_grades_page.dart';
import '../features/my_subjects/my_subjects_page.dart';
import '../features/profile/profile_page.dart';

PreferredSizeWidget customAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 80,
    centerTitle: false,
    backgroundColor: ColorsAsset.kLight2,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (MainCubit.get(context).lang == "en") {
              MainCubit.get(context).changeLang('ar');
            } else {
              MainCubit.get(context).changeLang('en');
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ColorsAsset.kPrimary),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${getLang(context, "EN")}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: ColorsAsset.kPrimary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return CachedNetworkImage(
                imageUrl: ProfileCubit.get(context).profileImage,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundColor: Color(0xFF6E85B7),
                  backgroundImage: imageProvider,
                ),
                errorWidget: (context, url, error) => const CircleAvatar(
                  backgroundColor: Color(0xFF6E85B7),
                  backgroundImage: AssetImage("assets/images/profile purple.png"),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Text(
              ProfileCubit.get(context).name,
              style: const TextStyle(fontSize: 12),
            );
          },
        ),
        const SizedBox(width: 50),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Studentlayout()),
            );
          },
          child: Text(
            '${getLang(context, "Home")}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorsAsset.kPrimary,
            ),
          ),
        ),
        const SizedBox(width: 5),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MySubjectsPage()),
            );
          },
          child: Text(
            '${getLang(context, "My Subjects")}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorsAsset.kPrimary,
            ),
          ),
        ),
        const SizedBox(width: 5),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MyGradesPage()),
            );
          },
          child: Text(
            '${getLang(context, "My Grades")}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorsAsset.kPrimary,
            ),
          ),
        ),
        const SizedBox(width: 5),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MyAssigmentsPage()),
            );
          },
          child: Text(
            '${getLang(context, "Assignments")}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorsAsset.kPrimary,
            ),
          ),
        ),
        const SizedBox(width: 5),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ChooseChatPage()),
            );
          },
          child: Text(
            '${getLang(context, "Chats")}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorsAsset.kPrimary,
            ),
          ),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset("assets/images/logo2.png"),
      ),
    ],
  );
}
