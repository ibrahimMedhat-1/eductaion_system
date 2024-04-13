import 'package:education_system/parent/features/course_quiz/view/course_quiz.dart';
import 'package:education_system/parent/features/home_page/manager/parent_home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/locale/applocale.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/utils/colors.dart';
import '../../../../student/features/profile/widgets/parent_data.dart';
import '../../../../student/features/profile/widgets/personal_data.dart';

class ParentHomePage extends StatelessWidget {
  const ParentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student details',
          style: TextStyle(color: ColorsAsset.kPrimary),
        ),
        backgroundColor: ColorsAsset.kLight2,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset("assets/images/logo2.png"),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => ParentHomePageCubit()
          ..getStudentDetails(Constants.parentModel!.studentReference!)
          ..getStudentGrades(Constants.parentModel!.studentReference!.id),
        child: BlocConsumer<ParentHomePageCubit, ParentHomePageState>(
          listener: (context, state) {},
          builder: (context, state) {
            final ParentHomePageCubit cubit = ParentHomePageCubit.get(context);
            return cubit.studentModel == null || state is GetChildQuizzesLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Flexible(
                            flex: 3,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 80,
                                    backgroundColor: const Color(0xFF6E85B7),
                                    backgroundImage: NetworkImage(cubit.studentModel?.image ?? ''),
                                  ),
                                  const SizedBox(height: 30),
                                  PersonalData(studentModel: cubit.studentModel!),
                                  FamilyDataSection(parentData: cubit.studentModel!.parentData!),
                                ],
                              ),
                            )),
                        Flexible(
                          flex: 4,
                          child: state is GetChildQuizzesLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : cubit.courses.isEmpty
                                  ? const Center(
                                      child: Text('No Quizzes taken yet'),
                                    )
                                  : ListView.builder(
                                      itemCount: cubit.courses.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                              elevation: 1,
                                              color: Colors.transparent,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: ColorsAsset.kLight,
                                                    borderRadius: BorderRadius.circular(12)),
                                                width: MediaQuery.of(context).size.width * 0.6,
                                                padding: const EdgeInsets.all(12),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 120,
                                                      width: 180,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  cubit.courses[index].image ?? ''))),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            cubit.courses[index].courseName ?? '',
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorsAsset.kTextcolor),
                                                          ),
                                                          Text(
                                                            '${getLang(context, "Enrolled")}',
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorsAsset.kPrimary),
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                builder: (context) => ParentCourseQuizPage(
                                                                    courseModel: cubit.courses[index]),
                                                              ));
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              foregroundColor: Colors.white,
                                                              backgroundColor: ColorsAsset.kPrimary,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(
                                                                  horizontal: 12.0, vertical: 8),
                                                              child: Text(
                                                                  '${getLang(context, "See my Grades ")}'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
