import 'package:education_system/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/colors.dart';

class FamilyDataSection extends StatelessWidget {
  final Map<String, dynamic>? parentData;
  const FamilyDataSection({
    super.key,
    this.parentData,
  });

  @override
  Widget build(BuildContext context) {
    print(parentData);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: const ListTile(
            title: Text("Parent Data"),
            tileColor: ColorsAsset.kLightPurble,
            leading: Icon(
              Icons.family_restroom,
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
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Phone No.')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text(Constants.studentModel?.parentData?.name ?? parentData?['name'] ?? '')),
              DataCell(Text(Constants.studentModel?.parentData?.email ?? parentData?['email'] ?? '')),
              DataCell(Text(Constants.studentModel?.parentData?.phone ?? parentData?['phone'] ?? '')),
            ])
          ],
        ),
      ],
    );
  }
}
