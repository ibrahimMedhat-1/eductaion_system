import 'package:education_system/models/student_model.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/colors.dart';

class PersonalData extends StatelessWidget {
  final StudentModel studentModel;
  const PersonalData({super.key, required this.studentModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: const ListTile(
            title: Text("Personal Data"),
            tileColor: ColorsAsset.kLightPurble,
            leading: Icon(
              Icons.person,
              color: ColorsAsset.kPrimary,
            ),
          ),
        ),
        DataTable(
            border: const TableBorder(
              horizontalInside: BorderSide(color: ColorsAsset.kLight2),
              verticalInside: BorderSide(color: ColorsAsset.kLightPurble),
            ),
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Phone Number')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text(studentModel.name ?? '')),
                DataCell(Text(studentModel.id ?? '')),
                DataCell(Text(studentModel.phone ?? '')),
              ])
            ]),
      ],
    );
  }
}
