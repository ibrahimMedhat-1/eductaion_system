import 'package:eductaion_system/models/course_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/colors.dart';
import '../../widgets/cutom_appbar.dart';

class ViewCoursePage extends StatefulWidget {
  final CourseModel courseModel;
  const ViewCoursePage({super.key, required this.courseModel});

  @override
  State<ViewCoursePage> createState() => _ViewCoursePageState();
}

class _ViewCoursePageState extends State<ViewCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Row(
        children: [
          const Flexible(
            flex: 3,
            child: VideoLecturePage(),
          ),
          Flexible(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ColorsAsset.kPrimary,
                  ),
                  left: BorderSide(
                    color: ColorsAsset.kPrimary,
                  ),
                  right: BorderSide(
                    color: ColorsAsset.kPrimary,
                  ),
                ),
              ),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        onTap: () {},
                        tileColor: ColorsAsset.kLightPurble,
                        title: const Text(
                          "الوحدة الاولي ",
                          style: TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class VideoLecturePage extends StatelessWidget {
  const VideoLecturePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              color: ColorsAsset.kLight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Image.asset("assets/images/video.png")),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const ExpansionTile(
              shape: OutlineInputBorder(
                  borderSide: BorderSide(
                color: ColorsAsset.kPrimary,
              )),
              backgroundColor: ColorsAsset.kLight,
              expandedAlignment: Alignment.topLeft,
              title: Text(
                'الشهر الاول',
                style: TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('الوحدة الاولي'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('اسالة عاملة'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('امتحان شامل'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const ExpansionTile(
              shape: OutlineInputBorder(
                  borderSide: BorderSide(
                color: ColorsAsset.kPrimary,
              )),
              backgroundColor: ColorsAsset.kLight,
              expandedAlignment: Alignment.topLeft,
              title: Text(
                'الشهر الثاني',
                style: TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('الوحدة الاولي'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('اسالة عاملة'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('امتحان شامل'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const ExpansionTile(
              shape: OutlineInputBorder(
                  borderSide: BorderSide(
                color: ColorsAsset.kPrimary,
              )),
              backgroundColor: ColorsAsset.kLight,
              expandedAlignment: Alignment.topLeft,
              title: Text(
                'الشهر الثالث',
                style: TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
              ),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('الوحدة الاولي'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('اسالة عاملة'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('امتحان شامل'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
