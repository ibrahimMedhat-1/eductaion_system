import 'package:eductaion_system/student/features/my_subjects/manager/my_subjects_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/utils/colors.dart';
import '../../widgets/cutom_appbar.dart';
import '../view_course/view_course_page.dart';

class MySubjectsPage extends StatelessWidget {
  const MySubjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MySubjectsCubit()..getMyCourses(),
      child: BlocConsumer<MySubjectsCubit, MySubjectsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final MySubjectsCubit cubit = MySubjectsCubit.get(context);
          return Scaffold(
            appBar: customAppBar(context),
            body: state is GetMyCoursesLoading
                ? const Center(child: CircularProgressIndicator())
                : cubit.myCourses.isEmpty
                    ? const Text('No Courses')
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
                        child: GridView.builder(
                          itemCount: cubit.myCourses.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.transparent,
                                elevation: 1,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: ColorsAsset.kLight, borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.2,
                                        width: MediaQuery.of(context).size.width * 0.15,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(cubit.myCourses[index].image ?? ''))),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              cubit.myCourses[index].courseName ?? '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold, color: ColorsAsset.kTextcolor),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewCoursePage(courseModel: cubit.myCourses[index]),
                                                ));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor: ColorsAsset.kPrimary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                                                child: Text('Start the Course'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          );
        },
      ),
    );
  }
}
