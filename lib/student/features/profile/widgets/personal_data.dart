import 'package:flutter/material.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/utils/colors.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({super.key});

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
                DataCell(Text(Constants.studentModel!.name ?? '')),
                DataCell(Text(Constants.studentModel!.id ?? '')),
                DataCell(Text(Constants.studentModel!.phone ?? '')),
              ])
            ]),
      ],
    );
  }
}
