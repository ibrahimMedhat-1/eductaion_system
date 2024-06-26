import 'package:education_system/student/features/my_grades/manager/my_grades_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/locale/applocale.dart';
import '../../../../shared/utils/colors.dart';
import '../../../widgets/cutom_appbar.dart';
import 'my_grades_details.dart';

class MyGradesPage extends StatelessWidget {
  const MyGradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyGradesCubit()..myCoursesGrades(),
      child: BlocConsumer<MyGradesCubit, MyGradesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final MyGradesCubit cubit = MyGradesCubit.get(context);
          return Scaffold(
            appBar: customAppBar(context),
            body: state is GetMyCoursesGradesLoading
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
                                                  builder: (context) =>
                                                      MyGradesDetails(id: cubit.courses[index].id!),
                                                ));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor: ColorsAsset.kPrimary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child:  Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                                                child: Text( '${getLang(context, "See my Grades ")}'),
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
