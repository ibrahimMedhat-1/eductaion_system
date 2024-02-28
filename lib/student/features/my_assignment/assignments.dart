import 'package:flutter/material.dart';

import '../../../shared/utils/colors.dart';
import '../../widgets/cutom_appbar.dart';
import '../solve_assignment/solve_assignment_page.dart';

class ChooseCourseAssignment extends StatelessWidget {
  const ChooseCourseAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SolveAssignmentPage(),
                            ));
                      },
                      leading: Image.asset("assets/images/icons8-study-50.png"),
                      tileColor: ColorsAsset.kLightPurble,
                      title: const Text(
                        "Lesson 1",
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
