import 'package:education_system/admin/features/course_details/manager/course_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/utils/colors.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseDetailsCubit(),
      child: BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final CourseDetailsCubit cubit = CourseDetailsCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
              
                children: [
                  const SizedBox(height: 50,),
                  const Text("Please Assign Teacher to This Course",style: TextStyle(color: ColorsAsset.kPrimary,fontWeight: FontWeight.bold,fontSize: 20),),
                  const SizedBox(height: 35,),
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width*0.3,
                    child: DropdownButtonFormField<String>(
                      value: cubit.selectedTeacher,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:ColorsAsset.kPrimary,
                          ),
                        ),
                        labelText: "Choose Teacher",
                      ),
                      items: cubit.Teachers.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        cubit.handleTeacherChange(newValue!);
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  DataTable(
              
                    dataTextStyle: const TextStyle(color: ColorsAsset.kPrimary),
                    columns: const [
                      DataColumn(label: Text('Course Name')),
                      DataColumn(label: Text('Course ID')),
                      DataColumn(label: Text('Course Reference')),
                      DataColumn(label: Text('Teacher Name')),
                      DataColumn(label: Text('Teacher ID')),
                      DataColumn(label: Text('Teacher Reference')),
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(Text('Mathematics')),
                        DataCell(Text('42343')),
                        DataCell(Text('subjects/courses/math/')),
                        DataCell(Text('Teacher1')),
                        DataCell(Text("fdffwef")),
                        DataCell(Text('Teachers/teacheID/')),
                      ]),
              
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: cubit.isFirstYearSelected,
                        onChanged: (value) {},
                      ),
                      const Text('First Secondary Year'),
                      const SizedBox(width: 16.0),
                      Checkbox(
                        value: cubit.isSecondYearSelected,
                        onChanged: (value) {},
                      ),
                      const Text('Second Secondary Year'),
                      const SizedBox(width: 16.0),
                      Checkbox(
                        value: cubit.isThirdYearSelected,
                        onChanged: (value) {},
                      ),
                      const Text('Third Secondary Year'),
                    ],
                  ),
                  const SizedBox(height: 50,),
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsAsset.kPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Border radius
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
