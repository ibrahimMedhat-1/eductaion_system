import 'package:education_system/admin/features/course_details/manager/course_details_cubit.dart';
import 'package:education_system/models/course_model.dart';
import 'package:education_system/models/teacher_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/locale/applocale.dart';
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
        ..getTeachers(
          courseModel.years!.first.trim(),
          subject,
        )
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
                Text(
                  '${getLang(context, "Please Assign Teacher to This Course")}',
                  style:
                      const TextStyle(color: ColorsAsset.kPrimary, fontWeight: FontWeight.bold, fontSize: 20),
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
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorsAsset.kPrimary,
                          ),
                        ),
                        labelText: '${getLang(context, "Choose Teacher")}',
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
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape:  WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ) ,
                        backgroundColor: WidgetStateProperty.all<Color>(ColorsAsset.kPrimary),

                  ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider(
                            create: (context) => CourseDetailsCubit(),
                            child: BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return AlertDialog(
                                  title: Text('${getLang(context, "Add Advertisement")}',),
                                  content: Stack(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(),
                                        child: CourseDetailsCubit.get(context).image == null
                                            ? const SizedBox()
                                            : Image.memory(CourseDetailsCubit.get(context).image!),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          CourseDetailsCubit.get(context).addAdvertisement();
                                        },
                                        child: state is ImageLoading
                                            ? const Center(
                                                child: CircularProgressIndicator(),
                                              )
                                            : const CircleAvatar(
                                                radius: 22,
                                                backgroundColor: ColorsAsset.kLight2,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: ColorsAsset.kPrimary,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    state is Loading
                                        ? const CircularProgressIndicator()
                                        : TextButton(
                                            child: Text('${getLang(context, "Add")}'),
                                            onPressed: () async {
                                              CourseDetailsCubit.get(context)
                                                  .uploadBanner(courseModel.reference!, context);
                                            },
                                          ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child:  Text(getLang(context, "Add Advertisement"),style: const TextStyle(color: Colors.white))),
                const SizedBox(
                  height: 20,
                ),
                DataTable(
                  dataTextStyle: const TextStyle(color: ColorsAsset.kPrimary),
                  columns: [
                    DataColumn(label: Expanded(child: Text('${getLang(context, "Course Name")}'))),
                    DataColumn(label: Expanded(child: Text('${getLang(context, "Course ID")}'))),
                    DataColumn(label: Expanded(child: Text('${getLang(context, "Course Reference")}'))),
                    DataColumn(label: Expanded(child: Text('${getLang(context, "Teacher Name")}'))),
                    DataColumn(label: Expanded(child: Text('${getLang(context, "Teacher ID")}'))),
                    DataColumn(label: Expanded(child: Text('${getLang(context, "Teacher Reference")}'))),
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
                    Text('${getLang(context, "First year of secondary school")}'),
                    const SizedBox(width: 16.0),
                    Checkbox(
                      value: courseModel.years?.contains('second Secondary'),
                      onChanged: null,
                    ),
                    Text('${getLang(context, "Second year of secondary school")}'),
                    const SizedBox(width: 16.0),
                    Checkbox(
                      value: courseModel.years?.contains('third Secondary'),
                      onChanged: null,
                    ),
                    Text('${getLang(context, "Third year of secondary school")}'),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                            child: Text(
                              '${getLang(context, "Save")}',
                              style: const TextStyle(color: Colors.white),
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
