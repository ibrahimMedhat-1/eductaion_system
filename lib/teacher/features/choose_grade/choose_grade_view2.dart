import 'package:flutter/material.dart';

import '../../../components/locale/applocale.dart';
import '../../../shared/constants.dart';
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
          if (Constants.teacherModel!.years!.contains('first Secondary'))
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddMaterialPage(year: 'first Secondary'),
                    ));
                  },
                  tileColor: ColorsAsset.kLightPurble,
                  subtitle:Text('${getLang(context,  "View Material")}'),
                  leading: Image.asset("assets/images/icons8-graduation-50.png"),
                  title:  Text('${getLang(context,  "First year of secondary school")}'),
                ),
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          if (Constants.teacherModel!.years!.contains('second Secondary'))
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddMaterialPage(year: 'second Secondary'),
                    ));
                  },
                  tileColor: ColorsAsset.kLightPurble,
                  subtitle:  Text('${getLang(context,  "View Material")}'),
                  leading: Image.asset("assets/images/icons8-graduation-50.png"),
                  title:  Text('${getLang(context,  "Second year of secondary school")}'),
                ),
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          if (Constants.teacherModel!.years!.contains('third Secondary'))
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddMaterialPage(year: 'third Secondary'),
                    ));
                  },
                  tileColor: ColorsAsset.kLightPurble,
                  subtitle:  Text(
                      '${getLang(context,  "View Material")}'
                      ),
                  leading: Image.asset("assets/images/icons8-graduation-50.png"),
                  title:  Text( '${getLang(context,  "Third year of secondary school")}'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
