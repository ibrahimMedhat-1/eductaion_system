import 'package:education_system/admin/features/subject/view/subjects_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

import '../../../../auth/login/login page.dart';
import '../../../../components/locale/applocale.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/main_cubit/main_cubit.dart';
import '../../../../shared/utils/colors.dart';
import '../../teacher/view/add_teacher.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Row(
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
            const SizedBox(width: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: ColorsAsset.kPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Constants.teacherModel = null;
                Constants.studentModel = null;
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
                Restart.restartApp();
              },
              child:  Text('${getLang(context,  "Logout")}'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              '${getLang(context,  "Choose what you want to do")}'
              ,style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 30),),
             Text(
                '${getLang(context,  "If you want to edit or add teacher or subject")}'
                ,style: const TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SubjectsPage(),));

                  },
                  child: Container(
                    decoration: const BoxDecoration(

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/Cream and Black Simple Education Logo (5).png",height: 300,),
                         Text(
                          '${getLang(context,  "Subject")}'
                          ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 50,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTeacher(),));
                  },
                  child: Container(
                    decoration: const BoxDecoration(

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/Cream and Black Simple Education Logo (6).png",height: 300,),
                         Text(
                          '${getLang(context,  "Teacher")}'
                          ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),

    );
  }
}
