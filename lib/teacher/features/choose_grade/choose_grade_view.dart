import 'package:flutter/material.dart';

import '../../../shared/utils/colors.dart';
import '../view_students/view/view_students_page.dart';

class ChooseGradePage extends StatelessWidget {
  const ChooseGradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ViewStudentsPage(),
                ));
              },
              tileColor: ColorsAsset.kLightPurble,
              subtitle: const Text("View Students"),
              leading: Image.asset("assets/images/icons8-graduation-50.png"),
              title: const Text("First year of secondary school"),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: ListTile(
              tileColor: ColorsAsset.kLightPurble,
              subtitle: const Text("View Students"),
              leading: Image.asset("assets/images/icons8-graduation-50.png"),
              title: const Text("Second year of secondary school"),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: ListTile(
              tileColor: ColorsAsset.kLightPurble,
              subtitle: const Text("View Students"),
              leading: Image.asset("assets/images/icons8-graduation-50.png"),
              title: const Text("Third year of secondary school"),
            ),
          ),
        ),
      ],
    );
  }
}
