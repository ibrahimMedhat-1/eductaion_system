import 'package:flutter/material.dart';

import '../../../shared/utils/colors.dart';
import '../payment/widgets/my_text_field.dart';

class EditInfoPage extends StatelessWidget {
  const EditInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> genders = [
      "Male",
      "Female",
    ];

    String? selectedGender;

    void setSelectGender(String newValue) {
      selectedGender = newValue;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit My Data',
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
          const SizedBox(
            height: 20,
          ),
          const ListTile(
            title: Text("Personal Data"),
            tileColor: ColorsAsset.kLightPurble,
            leading: Icon(
              Icons.person,
              color: ColorsAsset.kPrimary,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                MyTextField(
                  labelText: "Student Name",
                ),
                SizedBox(
                  width: 10,
                ),
                MyTextField(
                  labelText: "Student ID",
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const MyTextField(
                  labelText: "Phone Number",
                ),
                const SizedBox(
                  width: 10,
                ),
                const MyTextField(
                  labelText: "Password",
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: DropdownButtonFormField<String>(
                    value: selectedGender,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorsAsset.kPrimary),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorsAsset.kPrimary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorsAsset.kPrimary),
                      ),
                      labelText: 'Gender',
                    ),
                    items: genders.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setSelectGender(newValue!);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const ListTile(
            title: Text("Parent Data"),
            tileColor: ColorsAsset.kLightPurble,
            leading: Icon(
              Icons.family_restroom,
              color: ColorsAsset.kPrimary,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                MyTextField(
                  labelText: "Name",
                ),
                SizedBox(width: 10),
                MyTextField(
                  labelText: "Phone Number",
                ),
                SizedBox(
                  width: 10,
                ),
                MyTextField(
                  labelText: "Email",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
