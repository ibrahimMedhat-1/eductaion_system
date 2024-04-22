import 'package:education_system/models/student_model.dart';
import 'package:flutter/material.dart';

import '../../../../components/locale/applocale.dart';
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
          child:  ListTile(
            title: Text(
                '${getLang(context,  "Personal Data")}'
                ),
            tileColor: ColorsAsset.kLightPurble,
            leading: const Icon(
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
            columns:  [
              DataColumn(label: Text( '${getLang(context,  "Name")}')),
              DataColumn(label: Text('${getLang(context,  "ID")}')),
              DataColumn(label: Text('${getLang(context,  "Phone No.")}')),
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
