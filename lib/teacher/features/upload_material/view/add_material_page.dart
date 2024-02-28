import 'package:flutter/material.dart';

import '../../../../shared/utils/colors.dart';
import '../widgets/material_dialog.dart';

class AddMaterialPage extends StatelessWidget {
  const AddMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Questions',
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
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {},
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
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: ColorsAsset.kPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const MaterialDialog();
                  },
                );
              },
              child: const Text("Add Material"))
        ],
      ),
    );
  }
}
