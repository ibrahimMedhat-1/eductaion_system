import 'package:eductaion_system/student/features/profile/widgets/parent_data.dart';
import 'package:eductaion_system/student/features/profile/widgets/personal_data.dart';
import 'package:flutter/material.dart';

import '../../../auth/login/login page.dart';
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
                  const Stack(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: Color(0xFF6E85B7),
                        backgroundImage: AssetImage("assets/images/profile purple.png"),
                      ),
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: ColorsAsset.kLight2,
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            color: ColorsAsset.kPrimary,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
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
  }
}
