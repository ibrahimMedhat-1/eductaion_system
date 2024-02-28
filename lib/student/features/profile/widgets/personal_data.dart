import 'package:flutter/material.dart';

import '../../../../shared/utils/colors.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({super.key,});


  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> PersonalData = [
      {
        "Name": "Student Name",
        "ID": "123",
        "Gender": "female",
        "Phone Number": "573849759829",
      },
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         SizedBox(
           width: MediaQuery.of(context).size.width*0.4,
           child: const ListTile(
            title: Text("Personal Data"),
            tileColor: ColorsAsset.kLightPurble,
            leading: Icon(Icons.person,color: ColorsAsset.kPrimary,),

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
            DataColumn(label: Text('Gender')),
            DataColumn(label: Text('Phone Number')),
          ],
          rows: PersonalData.map((item) {
            return DataRow(cells: [
              DataCell(Text(item["Name"] ?? '')),
              DataCell(Text(item["ID"] ?? '')),
              DataCell(Text(item["Gender"] ?? '')),
              DataCell(Text(item["Phone Number"] ?? '')),
            ]);
          }).toList(),
        ),
      ],
    );
  }
}