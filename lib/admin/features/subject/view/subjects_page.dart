import 'package:education_system/admin/features/subject/manager/subjects_cubit.dart';
import 'package:education_system/admin/features/subject/view/widgets/course_dialog.dart';
import 'package:education_system/admin/features/subject/view/widgets/subject_dialog.dart';
import 'package:education_system/shared/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../course_details/view/course_details.dart';

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubjectsCubit, SubjectsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final SubjectsCubit cubit = SubjectsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          value: cubit.selectedSubject,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorsAsset.kPrimary,
                              ),
                            ),
                            labelText: "Choose Subject",
                          ),
                          items: cubit.subjects.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            cubit.handleSubjectChange(newValue!);
                            cubit.getCourses(newValue);
                          },
                        ),
                      ),
                    ),
                    const SubjectDialog(),
                  ],
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: state is GetCoursesLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.courses.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => CourseDetails(
                                          courseModel: cubit.courses[index],
                                          subject: cubit.selectedSubject,
                                        ),
                                      ));
                                    },
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      child: Card(
                                        elevation: 2,
                                        color: ColorsAsset.kLight2,
                                        child: Column(
                                          children: [
                                            Image.network(
                                              cubit.courses[index].image ?? '',
                                              height: MediaQuery.of(context).size.height * 0.35,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(cubit.courses[index].courseName ?? ''),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  const CourseDialog(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
