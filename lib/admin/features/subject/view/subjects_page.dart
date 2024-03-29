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
    return BlocProvider(
      create: (context) => SubjectsCubit(),
      child: BlocConsumer<SubjectsCubit, SubjectsState>(
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
                        child: ExpansionTile(
                          title: const Text('selected year Subjects'),
                          children:
                              List.generate(cubit.subjects.length, (index) {
                            String subject = cubit.subjects[index];
                            return ListTile(
                              title: Text(subject),
                              onTap: () {

                              },
                            );
                          }),
                        ),
                      ),
                      const SubjectDialog(),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:2
                        ,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:  GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CourseDetails(),));

                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Card(
                                  elevation: 2,
                                  color: ColorsAsset.kLight2,
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/Cream and Black Simple Education Logo (8).png"
                                        ,
                                        height: MediaQuery.of(context).size.height * 0.35,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text("Course Name"),
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
                    const CourseDialog(),
                  ],
                ),

                

              ],
            ),
          );
        },
      ),
    );
  }
}

