import 'package:education_system/admin/features/subject/view/subjects_page.dart';
import 'package:flutter/material.dart';

import '../../teacher/view/add_teacher.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Choose what you want to do",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 30),),
            const Text("If you want to edit or add to the teacher or subject",style: TextStyle(fontSize: 20)),
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
                        const Text("Subject",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
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
                        const Text("Teacher",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
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
