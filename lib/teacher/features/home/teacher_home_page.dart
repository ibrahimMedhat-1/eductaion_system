import 'package:eductaion_system/teacher/features/home/row_list.dart';
import 'package:flutter/material.dart';

import '../../../auth/login/login page.dart';
import '../../../components/locale/applocale.dart';
import '../../../shared/main_cubit/main_cubit.dart';
import '../../../shared/utils/colors.dart';
import '../choose_grade/choose_grade_view2.dart';
import '../profile/teacher_profile_page.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  Widget selectedWidget = const ChooseGradePage2();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage("assets/images/profile purple.png"),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const TeacherProfilePage(),
                          ));
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          const Text("Teacher Name"),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
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
                                  padding: const EdgeInsets.all(8),
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
                              const SizedBox(
                                width: 3,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: ColorsAsset.kPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ));
                                },
                                child: const Text("Logout"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: TeacherRowList.rowList.length,
                    itemBuilder: (context, index) {
                      var item = TeacherRowList.rowList[index];
                      return ListTile(
                        selected: item.isSelected,
                        selectedColor: Colors.white,
                        selectedTileColor: ColorsAsset.kTextcolor,
                        // autofocus: true,
                        leading: Icon(
                          item.icon,
                          color: ColorsAsset.kbackgorund,
                        ),
                        title: Text(
                          item.title,
                          style: const TextStyle(),
                        ),
                        onTap: () {
                          updateSelectedWidget(index);
                        },
                      );
                    },
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Image.asset("assets/images/logo2.png"),
                ),
              ],
            ),
          ),
          const VerticalDivider(),
          Expanded(
            flex: 6,
            child: selectedWidget,
          ),
        ],
      ),
    );
  }

  void updateSelectedWidget(int index) {
    setState(() {
      for (var element in TeacherRowList.rowList) {
        element.isSelected = false;
      }
      TeacherRowList.rowList[index].isSelected = true;
      selectedWidget = TeacherRowList.rowList[index].widgetBuilder();
    });
  }
}
