import 'package:education_system/admin/features/course_details/manager/course_details_cubit.dart';
import 'package:education_system/models/course_model.dart';
import 'package:education_system/models/teacher_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/utils/colors.dart';

class CourseDetails extends StatelessWidget {
  final CourseModel courseModel;
  final subject;

  const CourseDetails({super.key, required this.courseModel, required this.subject});

  @override
  Widget build(BuildContext context) {
    print('fgdhsjk ${courseModel.id}');
    return BlocProvider(
      create: (context) => CourseDetailsCubit()
        ..getTeachers()
        ..getCourseDetails(
          courseModel.years!.first.trim(),
          subject.toString().trim(),
          courseModel.id!.trim(),
        ),
      child: BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final CourseDetailsCubit cubit = CourseDetailsCubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Please Assign Teacher to This Course",
                  style: TextStyle(color: ColorsAsset.kPrimary, fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 35,
                ),
                if (cubit.courseModel?.teacher == null)
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: DropdownButtonFormField<TeacherModel>(
                      value: cubit.selectedTeacher,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorsAsset.kPrimary,
                          ),
                        ),
                        labelText: "Choose Teacher",
                      ),
                      items: cubit.teachers.map((teacher) {
                        return DropdownMenuItem<TeacherModel>(
                          value: teacher,
                          child: Text(teacher.name ?? ''),
                        );
                      }).toList(),
                      onChanged: (TeacherModel? newValue) {
                        cubit.handleTeacherChange(newValue!);
                      },
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                DataTable(
                  dataTextStyle: const TextStyle(color: ColorsAsset.kPrimary),
                  columns: const [
                    DataColumn(label: Expanded(child: Text('Course Name'))),
                    DataColumn(label: Expanded(child: Text('Course ID'))),
                    DataColumn(label: Expanded(child: Text('Course Reference'))),
                    DataColumn(label: Expanded(child: Text('Teacher Name'))),
                    DataColumn(label: Expanded(child: Text('Teacher ID'))),
                    DataColumn(label: Expanded(child: Text('Teacher Reference'))),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text(cubit.courseModel?.courseName ?? '')),
                      DataCell(Text(cubit.courseModel?.id ?? '')),
                      DataCell(Text(cubit.courseModel?.reference?.path ?? '')),
                      DataCell(Text(cubit.courseModel?.teacherName ?? '')),
                      DataCell(Text(cubit.courseModel?.teacher?.id ?? '')),
                      DataCell(Text(cubit.courseModel?.teacher?.path ?? '')),
                    ]),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: courseModel.years?.contains('first Secondary'),
                      onChanged: null,
                    ),
                    const Text('First Secondary Year'),
                    const SizedBox(width: 16.0),
                    Checkbox(
                      value: courseModel.years?.contains('second Secondary'),
                      onChanged: null,
                    ),
                    const Text('Second Secondary Year'),
                    const SizedBox(width: 16.0),
                    Checkbox(
                      value: courseModel.years?.contains('third Secondary'),
                      onChanged: null,
                    ),
                    const Text('Third Secondary Year'),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                if (cubit.courseModel?.teacher == null)
                  state is AssignTeacherLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            cubit.assignTeacher(courseModel.reference!).then((value) {
                              cubit.getCourseDetails(courseModel.years!.first, subject, courseModel.id);
                            });
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
          );
        },
      ),
    );
  }
}
