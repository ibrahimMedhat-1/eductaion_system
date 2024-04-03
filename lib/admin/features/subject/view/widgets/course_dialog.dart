import 'package:cached_network_image/cached_network_image.dart';
import 'package:education_system/admin/features/subject/manager/subjects_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../auth/login/widgets/main_text_field.dart';
import '../../../../../shared/utils/colors.dart';

class CourseDialog extends StatelessWidget {
  const CourseDialog({super.key});

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<SubjectsCubit, SubjectsState>(
          listener: (context, state) {},
          builder: (context, state) {
            final SubjectsCubit cubit = SubjectsCubit.get(context);
            return AlertDialog(
              title: const Text('Add Course'),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: cubit.courseImage,
                          imageBuilder: (context, imageProvider) => CircleAvatar(
                            radius: 80,
                            backgroundColor: const Color(0xFF6E85B7),
                            backgroundImage: imageProvider,
                          ),
                          errorWidget: (context, url, error) => const CircleAvatar(
                            radius: 80,
                            backgroundColor: Color(0xFF6E85B7),
                            backgroundImage: NetworkImage("assets/images/profile purple.png"),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            cubit.changeCourseImage();
                            cubit.getCourses(cubit.selectedSubject);
                          },
                          child: const CircleAvatar(
                            radius: 30,
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
                    MainTextField(
                      hintText: "Course Name",
                      controller: cubit.courseNameController,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
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
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: cubit.firstYear,
                            onChanged: (value) {
                              cubit.firstYear = value!;
                              cubit.emit(ChangeValue());
                              cubit.selectYear(value, 'first Secondary');
                            }),
                        const Text('First Year'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: cubit.secondYear,
                            onChanged: (value) {
                              cubit.secondYear = value!;
                              cubit.emit(ChangeValue());
                              cubit.selectYear(value, 'second Secondary');
                            }),
                        const Text('Second Year'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: cubit.thirdYear,
                            onChanged: (value) {
                              cubit.thirdYear = value!;
                              cubit.emit(ChangeValue());
                              cubit.selectYear(value, 'third Secondary');
                            }),
                        const Text('Third Year'),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Add'),
                  onPressed: () async {
                    cubit.addCourse().then((value) {
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          _showAddDialog(context);
        },
        icon: const Icon(
          Icons.add_box,
          size: 50,
          color: ColorsAsset.kPrimary,
        ));
  }
}
