import 'package:flutter/material.dart';

import '../../../shared/utils/colors.dart';
import '../../widgets/cutom_appbar.dart';
import 'assignments.dart';

class MyAssigmentsPage extends StatelessWidget {
  const MyAssigmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  customAppBar(context),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 1,
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: ColorsAsset.kLight,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        width: 180,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/teacher.png"))),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "English Course Second year of secondary school ",
                              style: TextStyle(
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
                                  builder: (context) => const ChooseCourseAssignment(),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8),
                                child: Text('See Available Assignments'),
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
  }
}
