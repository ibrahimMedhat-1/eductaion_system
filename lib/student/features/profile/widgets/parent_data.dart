import 'package:flutter/material.dart';

import '../../../../shared/utils/colors.dart';

class FamilyDataSection extends StatelessWidget {
  const FamilyDataSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> familyData = [
      {
        "Name": "Parent Name",
        "Email": "dsfs@gmail.com",
        "Phone No.": "1324343242",
      },
    ];
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
          rows: familyData.map((item) {
            return DataRow(cells: [
              DataCell(Text(item["Name"] ?? '')),
              DataCell(Text(item["Email"] ?? '')),
              DataCell(Text(item["Phone No."] ?? '')),
            ]);
          }).toList(),
        ),
      ],
    );
  }
}
