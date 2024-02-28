import 'package:flutter/material.dart';

import '../../../shared/utils/colors.dart';
import '../../widgets/cutom_appbar.dart';
import '../view_course/view_course_page.dart';

class MySubjectsPage extends StatelessWidget {
  const MySubjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
        child: GridView.builder(
          itemCount: 10,
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
                  decoration:
                      BoxDecoration(color: ColorsAsset.kLight, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: AssetImage("assets/images/teacher.png"))),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "English Course Second year of secondary school ",
                              style: TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kTextcolor),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ViewCoursePage(),
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
  }
}
