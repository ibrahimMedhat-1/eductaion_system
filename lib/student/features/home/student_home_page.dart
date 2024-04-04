import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  final List<String> homeData = [
    "assets/images/Blue and Yellow University Etiquette Professional Presentation (6).png",
    "assets/images/Blue and Yellow University Etiquette Professional Presentation (6).png",
    "assets/images/Blue and Yellow University Etiquette Professional Presentation (6).png",
    "assets/images/Blue and Yellow University Etiquette Professional Presentation (6).png",
  ];
  String dropdownValue = 'الصف الاول';
  final List<String> dropdownItems = ['الصف الاول', 'الصف الثاني', 'الصف الثالث'];

  int _current = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit()..getCourses('first secondary'),
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
                          CarouselSlider(
                            carouselController: _carouselController,
                            items: homeData.map((imagePath) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: Image.asset(
                                      imagePath,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                                viewportFraction: 1,
                                height: MediaQuery.of(context).size.height * .78,
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
                    count: homeData.length,
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
                        hintText: '${getLang(context, "Search")}'
                       ,
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
                          ?  Center(
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
                                          clipBehavior:Clip.antiAlias,
                                          elevation: 2,
                                          color: ColorsAsset.kLight2,
                                          child: Column(
                                            children: [
                                              SizedBox(

                                                height: 180,
                                                width: double.infinity,

                                                child: Expanded(
                                                  child: Image.network(
                                                    fit: BoxFit.fill,
                                                    state is IsSearching
                                                        ? cubit.searchList[index].image!
                                                        : cubit.courses[index].image!,),
                                                ),

                                              ),

                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(state is IsSearching
                                                  ? cubit.searchList[index].teacherName ?? ''
                                                  : cubit.courses[index].teacherName ?? ''),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(state is IsSearching
                                                  ? cubit.searchList[index].courseName ?? ''
                                                  : cubit.courses[index].courseName ?? ''),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
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
