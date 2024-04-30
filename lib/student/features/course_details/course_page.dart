import 'package:education_system/models/course_model.dart';
import 'package:education_system/student/features/course_details/manager/course_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/locale/applocale.dart';
import '../../../shared/utils/colors.dart';
import '../../widgets/cutom_appbar.dart';
import '../payment/payment_page.dart';

class CoursePage extends StatelessWidget {
  final CourseModel courseModel;

  const CoursePage({super.key, required this.courseModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseDetailsCubit()..getProfessorDetails(courseModel.teacher),
      child: BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final CourseDetailsCubit cubit = CourseDetailsCubit.get(context);
          return Scaffold(
            appBar: customAppBar(context),
            body: state is GetTeacherDataLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            color: ColorsAsset.kLight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                cubit.teacherData?.data()?['image'] ?? '' == ""
                                    ? Container(
                                        height: 200,
                                        width: 230,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  // cubit.teacherData?.data()?['image'] ==""?
                                                  AssetImage("assets/images/no-image-icon-6.png")

                                              // NetworkImage(cubit.teacherData?.data()?['image']))),
                                              ),
                                        ),
                                      )
                                    : Container(
                                        height: 200,
                                        width: 230,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(cubit.teacherData?.data()?['image'] ?? ''),
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${getLang(context, "Overview")}',
                                            style: const TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: ColorsAsset.kPrimary),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${getLang(context, "Price : ")}${courseModel.price}',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorsAsset.kPrimary),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${getLang(context, "Name : ")}',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: ColorsAsset.kPrimary),
                                          ),
                                          Text(
                                            cubit.teacherData?.data()?['name'] ?? '',
                                            style:
                                                const TextStyle(fontSize: 20, color: ColorsAsset.kTextcolor),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${getLang(context, "Certificate: ")}',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: ColorsAsset.kPrimary),
                                          ),
                                          Text(
                                            cubit.teacherData?.data()?['degree'] ?? '',
                                            style:
                                                const TextStyle(fontSize: 20, color: ColorsAsset.kTextcolor),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${getLang(context, "Experience: ")}',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: ColorsAsset.kPrimary),
                                          ),
                                          Text(
                                            cubit.teacherData?.data()?['bio'] ?? '',
                                            style:
                                                const TextStyle(fontSize: 20, color: ColorsAsset.kTextcolor),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${getLang(context, "Center Name: ")}',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: ColorsAsset.kPrimary),
                                          ),
                                          Text(
                                            cubit.teacherData?.data()?['centerName'] ?? '',
                                            style:
                                                const TextStyle(fontSize: 20, color: ColorsAsset.kTextcolor),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${getLang(context, "Center Number: ")}',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: ColorsAsset.kPrimary),
                                          ),
                                          Text(
                                            cubit.teacherData?.data()?['centerNo'] ?? '',
                                            style:
                                                const TextStyle(fontSize: 20, color: ColorsAsset.kTextcolor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          '${getLang(context, "See the study plan")}',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          children: courseModel.studyPlan!
                              .map((e) => SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: ExpansionTile(
                                      shape: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: ColorsAsset.kPrimary,
                                      )),
                                      backgroundColor: ColorsAsset.kLight,
                                      title: Text(
                                        e['title'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                                      ),
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(e['plan']),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(e['plan2']),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(e['plan3']),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(e['plan4']),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PaymentPage(courseModel: courseModel),
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
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                            child: Text('${getLang(context, "subscribe now")}'),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
