import 'package:education_system/shared/constants.dart';
import 'package:education_system/teacher/features/chats/manager/teacher_chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/locale/applocale.dart';
import '../../../../shared/utils/colors.dart';
import '../pages/group_chat_page.dart';
import '../pages/parent_chat_page.dart';
import '../pages/students_chat_page.dart';

class ChatsPage extends StatelessWidget {
  final String year;
  const ChatsPage({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [

              Tab(text: '${getLang(context, "Students")}'
              ),
              Tab(text: '${getLang(context, "Group Chat")}'
              ),
              Tab(text: '${getLang(context, "Parents")}'),
            ],
          ),
        ),
        body:  TabBarView(
          children: [

            StudentsPage(year:year,),
            ChatPageTeacherGroup(year: year,),
            ParentsPage(),
          ],
        ),
      ),
    );
  }
}

class ParentsPage extends StatelessWidget {
  const ParentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherChatCubit, TeacherChatState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    final TeacherChatCubit cubit = TeacherChatCubit.get(context);
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: cubit.getParents(Constants.teacherModel!.id),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<Map<String, dynamic>> users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> user = users[index];
              return ListTile(
                title: Text(user['name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPageTeacherParent(userId: user['id']),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  },
);
  }
}

class StudentsPage extends StatelessWidget {
  final String year;
  const StudentsPage({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    TeacherChatCubit.get(context).getCourseStudents(year);
    return BlocConsumer<TeacherChatCubit, TeacherChatState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final TeacherChatCubit cubit = TeacherChatCubit.get(context);
        return Scaffold(

          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cubit.students.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatPageTeacherStudents(studentModel: cubit.students[index]),
                            ));
                          },
                          leading: cubit.students[index].image == ''
                              ? Image.asset("assets/images/icons8-student-50.png")
                              : Image.network(cubit.students[index].image!),
                          tileColor: ColorsAsset.kLightPurble,
                          title: Text(
                            cubit.students[index].name ?? '',
                            style:
                            const TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kTextcolor),
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
    );
  }
}


