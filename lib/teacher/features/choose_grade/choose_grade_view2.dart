import 'package:flutter/material.dart';

import '../../../shared/utils/colors.dart';
import '../upload_material/view/add_material_page.dart';

class ChooseGradePage2 extends StatelessWidget {
  const ChooseGradePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    builder: (context) => const AddMaterialPage(),
                  ));
                },
                tileColor: ColorsAsset.kLightPurble,
                subtitle: const Text("View Material"),
                leading: Image.asset("assets/images/icons8-graduation-50.png"),
                title: const Text("First secondary"),
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
                subtitle: const Text("View Material"),
                leading: Image.asset("assets/images/icons8-graduation-50.png"),
                title: const Text("Second secondary"),
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
                subtitle: const Text("View Material"),
                leading: Image.asset("assets/images/icons8-graduation-50.png"),
                title: const Text("Third secondary"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
