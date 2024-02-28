import 'package:flutter/material.dart';

import '../../../shared/utils/colors.dart';
import '../../../student/features/payment/widgets/my_text_field.dart';

class TeacherProfilePage extends StatelessWidget {
  const TeacherProfilePage({super.key});

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
      body: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              CircleAvatar(
                radius: 120,
                backgroundColor: Color(0xFF6E85B7),
                backgroundImage: AssetImage(
                    "assets/images/profile purple.png"
                ),
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: ColorsAsset.kLight2,
                child: Center(
                  child: Icon(
                    Icons.edit,color: ColorsAsset.kPrimary,
                  ),
                ),
              ),


            ],
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text("Personal Data"),
            tileColor: ColorsAsset.kLightPurble,
            leading: Icon(
              Icons.person,
              color: ColorsAsset.kPrimary,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                MyTextField(
                  labelText: "Name",
                ),
                SizedBox(
                  width: 10,
                ),
                MyTextField(
                  labelText: "Certificate",
                ),
                SizedBox(
                  width: 10,
                ),
                MyTextField(
                  labelText: "Experience",
                ),

              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [

                MyTextField(
                  labelText: "Center Name",
                ),
                SizedBox(
                  width: 10,
                ),
                MyTextField(
                  labelText: "Center Number",
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
