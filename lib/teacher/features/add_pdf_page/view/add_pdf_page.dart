import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/teacher/features/add_pdf_page/manager/add_pdf_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/locale/applocale.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/utils/colors.dart';
import '../../../../student/features/payment/widgets/my_text_field.dart';

class AddPdfPag extends StatelessWidget {
  final String year;

  const AddPdfPag({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPdfCubit(),
      child: BlocConsumer<AddPdfCubit, AddPdfState>(
        listener: (context, state) {},
        builder: (context, state) {
          final AddPdfCubit cubit = AddPdfCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title:  Text(
                '${getLang(context, "Add Pdf")}'
                ,
                style: const TextStyle(color: ColorsAsset.kPrimary),
              ),
              backgroundColor: ColorsAsset.kLight2,
              actions: [
                Padding(padding: const EdgeInsets.all(5.0), child: Image.asset("assets/images/logo2.png")),
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          cubit.pickAndUploadPdf(context, year);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            color: ColorsAsset.kLight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: cubit.pdfFile != null
                                  ? Image.asset('assets/images/pdf_image.jpeg')
                                  : Center(child: Image.asset("assets/images/icons8-add-100.png")),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      if (cubit.pdfFile != null)
                        MaterialButton(
                          onPressed: () {
                            cubit.pdfFile = null;
                            cubit.pdfNameController.clear();
                            cubit.emit(RemovePdf());
                          },
                          child:  Text(
                              '${getLang(context, "Remove Pdf")}'
                              ),
                        ),
                      Row(
                        children: [
                          MyTextField(
                            hintText:
                            '${getLang(context,  "Pdf Name")}'
                           ,
                            controller: cubit.pdfNameController,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                if (state is PdfAddedLoading) const Center(child: CircularProgressIndicator())
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.pdfFile != null) {
                  cubit.addPdf(
                    context,
                    file: cubit.pdfFile,
                    courseId: Constants.teacherModel!.courseId!,
                    year: year,
                    name: cubit.pdfNameController.text,
                    subject: Constants.teacherModel!.subject!,
                    courseReference: FirebaseFirestore.instance
                        .collection('secondary years')
                        .doc(year)
                        .collection(Constants.teacherModel!.subject!)
                        .doc(Constants.teacherModel!.courseId.toString().trim()),
                  );
                }
              },
              child:  Text(
                  '${getLang(context,  "Add Pdf")}'
                  ),
            ),
          );
        },
      ),
    );
  }
}
