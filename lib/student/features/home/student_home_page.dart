import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:education_system/student/features/contact_us/presentation/view/widget/contact_us_footer.dart';
import 'package:education_system/student/features/home/manager/home_page_cubit.dart';
import 'package:education_system/student/features/home/widgets/subject_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/locale/applocale.dart';
import '../../../shared/utils/colors.dart';
import '../../widgets/cutom_appbar.dart';
import '../course_details/course_page.dart';
import '../payment/widgets/my_text_field.dart';

class StudentLayout extends StatefulWidget {
  const StudentLayout({super.key});

  @override
  StudentLayoutState createState() => StudentLayoutState();
}

class StudentLayoutState extends State<StudentLayout> {
  String dropdownValue = 'الصف الاول';
  final List<String> dropdownItems = ['الصف الاول', 'الصف الثاني', 'الصف الثالث'];

  int _current = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit()
        ..getCourses('first secondary')
        ..getBanners(),
      child: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final HomePageCubit cubit = HomePageCubit.get(context);
          return Scaffold(
            appBar: customAppBar(context),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (state is GetBannersLoading || cubit.homeData.isEmpty)
                            const Center(child: CircularProgressIndicator())
                          else
                            CarouselSlider(
                              carouselController: _carouselController,
                              items: cubit.homeData.map((offer) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CoursePage(courseModel: offer.courseModel!),
                                            ));
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: Image.network(
                                          offer.image ?? '',
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                              const Center(child: Icon(Icons.error)),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                              options: CarouselOptions(
                                  viewportFraction: 1,
                                  height: MediaQuery.of(context).size.height * .9,
                                  autoPlay: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  }),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CarouselIndicator(
                    count: state is GetBannersLoading || cubit.homeData.isEmpty ? 1 : cubit.homeData.length,
                    index: _current,
                    color: Colors.grey,
                    activeColor: ColorsAsset.kPrimary,
                    height: 3,
                    width: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorsAsset.kPrimary,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorsAsset.kPrimary,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorsAsset.kPrimary,
                          ),
                        ),
                        labelText: '${getLang(context, "Select the academic year")}',
                      ),
                      items: dropdownItems.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        cubit.getCourses(value);
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${getLang(context, "Let's Start Now")}',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                  ),
                  Text(
                    '${getLang(context, "A group of the most skilled professors")}',
                    style: const TextStyle(fontSize: 15, color: ColorsAsset.kPrimary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      MyTextField(
                        flex: 2,
                        hintText: '${getLang(context, "Search")}',
                        prefixIcon: const Icon(Icons.search),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            cubit.isSearching();
                            cubit.search(value);
                          } else {
                            cubit.isNotSearching();
                          }
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            cubit.getCourses("first Secondary");
                          },
                          child: const SubjectContainer(subjectName: "all")),
                      SizedBox(
                        height: 55,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: cubit.subjects
                              .map(
                                (e) => InkWell(
                                    onTap: () {
                                      cubit.getCoursesOfSubject(e, cubit.year);
                                    },
                                    child: SubjectContainer(subjectName: e)),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  state is GetCoursesLoading
                      ? const Center(child: CircularProgressIndicator())
                      : cubit.courses.isEmpty
                          ? Center(
                              child: Text('${getLang(context, "No Courses")}'),
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    state is IsSearching ? cubit.searchList.length : cubit.courses.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => CoursePage(courseModel: cubit.courses[index]),
                                        ));
                                      },
                                      child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          child: Card(
                                            color: Colors.transparent,
                                            elevation: 1,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                  color: ColorsAsset.kLight,
                                                  borderRadius: BorderRadius.circular(12)),
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
                                                            image: NetworkImage(
                                                              state is IsSearching
                                                                  ? cubit.searchList[index].image!
                                                                  : cubit.courses[index].image!,
                                                            ))),
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
                                                          state is IsSearching
                                                              ? "${getLang(context, "Teacher Name")} : ${cubit.searchList[index].teacherName ?? ''}"
                                                              : "${getLang(context, "Teacher Name")} : ${cubit.courses[index].teacherName ?? ''}",
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: ColorsAsset.kTextcolor),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          state is IsSearching
                                                              ? "${getLang(context, "Course Name")} : ${cubit.searchList[index].courseName ?? ''}"
                                                              : "${getLang(context, "Course Name")} : ${cubit.courses[index].courseName ?? ''}",
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: ColorsAsset.kTextcolor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    ),
                                  );
                                },
                              ),
                            ),
                  const SizedBox(
                    height: 100,
                  ),
                  const ContactUsFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
