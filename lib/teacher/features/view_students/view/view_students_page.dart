import 'package:education_system/teacher/features/view_students/manager/view_students_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/login/widgets/main_text_field.dart';
import '../../../../components/locale/applocale.dart';
import '../../../../shared/utils/colors.dart';
import '../../student_view/view/student_page.dart';

class ViewStudentsPage extends StatelessWidget {
  final String year;

  const ViewStudentsPage({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewStudentsCubit()..getCourseStudents(year),
      child: BlocConsumer<ViewStudentsCubit, ViewStudentsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final ViewStudentsCubit cubit = ViewStudentsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title :SizedBox(
                height: 30,
                width: 300,
                child: MainTextField(
                  textInputType: TextInputType.text,
                  hintText: '${getLang(context,  "Search")}',
                  prefixIcon: const Icon(Icons.search),
                ),
              ),

              backgroundColor: ColorsAsset.kLight2,
              actions: [
                Text(

                  '${getLang(context,  "Total Students")} = ${cubit.students.length}',
                  style: const TextStyle(color: ColorsAsset.kPrimary),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset("assets/images/logo2.png"),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cubit.students.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => StudentPage(studentModel: cubit.students[index]),
                              ));
                            },
                            leading: cubit.students[index].image == ''
                                ? Image.asset("assets/images/icons8-student-50.png")
                                : Image.network(cubit.students[index].image!),
                            tileColor: ColorsAsset.kLightPurble,
                            title: Text(
                              cubit.students[index].name ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kTextcolor),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
