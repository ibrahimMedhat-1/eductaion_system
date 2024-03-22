import 'package:eductaion_system/student/features/my_assignment/manager/my_assignments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/utils/colors.dart';
import '../../widgets/cutom_appbar.dart';
import 'assignments.dart';

class MyAssigmentsPage extends StatelessWidget {
  const MyAssigmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAssignmentsCubit()..myCoursesAssignments(),
      child: BlocConsumer<MyAssignmentsCubit, MyAssignmentsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final MyAssignmentsCubit cubit = MyAssignmentsCubit.get(context);
          return Scaffold(
            appBar: customAppBar(context),
            body: state is GetMyCoursesAssignmentsLoading
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
                                      color: ColorsAsset.kLight, borderRadius: BorderRadius.circular(12)),
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
                                                image: NetworkImage(cubit.courses[index].image!))),
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
                                              cubit.courses[index].courseName!,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorsAsset.kTextcolor),
                                            ),
                                            const Text(
                                              "Enrolled",
                                              style: TextStyle(
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
                                                  builder: (context) =>
                                                      MyAssignmentDetails(id: cubit.courses[index].id!),
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
                                                child: Text('See My Grades'),
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
          );
        },
      ),
    );
  }
}
