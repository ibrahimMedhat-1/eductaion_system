import 'package:eductaion_system/teacher/features/upload_material/manager/add_material_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/utils/colors.dart';
import '../widgets/material_dialog.dart';

class AddMaterialPage extends StatelessWidget {
  final String year;

  const AddMaterialPage({
    super.key,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddMaterialCubit()..getCourseMaterial(year),
      child: BlocConsumer<AddMaterialCubit, AddMaterialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<AddMaterialCubit, AddMaterialState>(
            listener: (context, state) {},
            builder: (context, state) {
              final AddMaterialCubit cubit = AddMaterialCubit.get(context);
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: cubit.material.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {},
                              leading: Image.asset("assets/images/icons8-study-50.png"),
                              tileColor: ColorsAsset.kLightPurble,
                              title: Text(
                                cubit.material[index]['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, color: ColorsAsset.kTextcolor),
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
            },
          );
        },
      ),
    );
  }
}
