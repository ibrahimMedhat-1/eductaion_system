import 'package:eductaion_system/models/course_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/colors.dart';
import '../../widgets/cutom_appbar.dart';
import '../payment/payment_page.dart';

class CoursePage extends StatelessWidget {
  final CourseModel courseModel;

  const CoursePage({super.key, required this.courseModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
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
                    Container(
                      height: 200,
                      width: 230,
                      decoration: BoxDecoration(
                          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(courseModel.image!))),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "نبذة عامة ",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "الاسم : ",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                              ),
                              Text(
                                "اسم الاستاذ بالكامل",
                                style: TextStyle(fontSize: 20, color: ColorsAsset.kTextcolor),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "الشهادة : ",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                              ),
                              Text(
                                "بكالوريوس في تعليم اللغة الإنجليزية",
                                style: TextStyle(fontSize: 20, color: ColorsAsset.kTextcolor),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "الخبرة : ",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                              ),
                              Text(
                                " لديه خبرة تدريسية تزيد عن 5 سنوات في تدريس اللغة الانجليزية",
                                style: TextStyle(fontSize: 20, color: ColorsAsset.kTextcolor),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "اسم السنتر : ",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                              ),
                              Text(
                                "اسم السنتر",
                                style: TextStyle(fontSize: 20, color: ColorsAsset.kTextcolor),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "رقم السنتر : ",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                              ),
                              Text(
                                "89458934584",
                                style: TextStyle(fontSize: 20, color: ColorsAsset.kTextcolor),
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
            const Text(
              "اطلع علي الخطة الدراسية",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              children: courseModel.studyPlan!.entries
                  .map((e) => SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ExpansionTile(
                          shape: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: ColorsAsset.kPrimary,
                          )),
                          backgroundColor: ColorsAsset.kLight,
                          expandedAlignment: Alignment.topLeft,
                          title: Text(
                            e.key,
                            style: const TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                          ),
                          children: e.value
                              .map<Widget>(
                                (e) => Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(e),
                                ),
                              )
                              .toList(),
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
                  builder: (context) => const PaymentPage(),
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
                child: Text('اشترك الان'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
