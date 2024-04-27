import 'package:education_system/student/features/chats/manager/student_chat_cubit.dart';
import 'package:education_system/student/features/chats/widgets/chat_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/locale/applocale.dart';
import '../../../shared/utils/colors.dart';
import '../../widgets/cutom_appbar.dart';

class ChooseChatPage extends StatelessWidget {
  const ChooseChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    StudentChatCubit.get(context).getMyCourses();
    return BlocConsumer<StudentChatCubit, StudentChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        StudentChatCubit cubit = StudentChatCubit.get(context);
        return Scaffold(
          appBar: customAppBar(context),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
            child: GridView.builder(
              itemCount: cubit.myCourses.length,
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
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(cubit.myCourses[index].image ?? ''))),
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
                                  cubit.myCourses[index].courseName ?? '',
                                  style:
                                      const TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kTextcolor),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ChatDialog(courseModel: cubit.myCourses[index]);
                                      },
                                    );
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
                                    child: Text('${getLang(context, "Start Chat")}'),
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
      },
    );
  }
}
