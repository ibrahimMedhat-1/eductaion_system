import 'package:education_system/teacher/features/upload_material/manager/add_material_cubit.dart';
import 'package:education_system/teacher/features/upload_material/pages/pdf_page/view/edit_pdf_view.dart';
import 'package:education_system/teacher/features/upload_material/pages/view_lesson/view/view_lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/locale/applocale.dart';
import '../../../../shared/utils/colors.dart';
import '../pages/question_page/view/question_page.dart';
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
                  title: Text(
                    '${getLang(context, "Add Material")}',
                    style: const TextStyle(color: ColorsAsset.kPrimary),
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
                              onTap: () {
                                if (cubit.material[index]['type'] == 'lesson') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewLesson(
                                          videoID: cubit.material[index]['id'],
                                          year: year,
                                          videoLink: cubit.material[index]['video'],
                                          lessonTitle: cubit.material[index]['name'],
                                        ),
                                      ));
                                } else if (cubit.material[index]['type'] == 'quiz' ||
                                    cubit.material[index]['type'] == 'assignment') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TeacherQuestionPage(
                                          year: year,
                                          quizId: cubit.material[index]['id'],
                                        ),
                                      ));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditPdfView(
                                          pdfId: cubit.material[index]['id'],
                                          pdfName: cubit.material[index]['name'],
                                          year: year,
                                        ),
                                      ));
                                }
                              },
                              leading: Image.asset("assets/images/icons8-study-50.png"),
                              tileColor: ColorsAsset.kLightPurble,
                              title: Text(
                                cubit.material[index]['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, color: ColorsAsset.kTextcolor),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  cubit.deleteMaterial(year, cubit.material[index]['id']);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
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
                              return MaterialDialog(
                                year: year,
                              );
                            },
                          );
                        },
                        child: Text('${getLang(context, "Add Material")}'))
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
