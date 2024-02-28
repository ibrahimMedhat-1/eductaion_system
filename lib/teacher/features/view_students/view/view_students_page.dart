import 'package:flutter/material.dart';

import '../../../../auth/login/widgets/main_text_field.dart';
import '../../../../shared/utils/colors.dart';
import '../../student_view/view/student_page.dart';

class ViewStudentsPage extends StatelessWidget {
  const ViewStudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'total students = 100',
              style: TextStyle(color: ColorsAsset.kPrimary),
            ),
            const SizedBox(
              width: 30,
            ),
            MainTextField(
              hintText: "Search",
              prefixIcon: const Icon(Icons.search),
            ),
          ],
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const StudentPage(),
                        ));
                      },
                      leading: Image.asset("assets/images/icons8-student-50.png"),
                      tileColor: ColorsAsset.kLightPurble,
                      title: const Text(
                        "Student Name",
                        style: TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kTextcolor),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
