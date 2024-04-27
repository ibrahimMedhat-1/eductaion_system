import 'package:education_system/models/course_model.dart';
import 'package:education_system/student/features/chats/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/locale/applocale.dart';
import '../../../models/message_model.dart';
import '../../../shared/constants.dart';
import '../../../shared/utils/colors.dart';
import 'manager/parent_chat_cubit.dart';

class ChatPageParent extends StatefulWidget {
  const ChatPageParent({super.key,  required this.courseModel});

  final CourseModel courseModel;
  @override
  ChatPageParentState createState() => ChatPageParentState();
}

class ChatPageParentState extends State<ChatPageParent> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ParentChatCubit.get(context).getMessages(widget.courseModel.teacher!.id);

    return BlocConsumer<ParentChatCubit, ParentChatState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ParentChatCubit cubit = ParentChatCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${getLang(context, "Chat Page")}',
              style: const TextStyle(color: ColorsAsset.kPrimary),
            ),
            backgroundColor: ColorsAsset.kLight2,
          ),
          body: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(border: Border.all(color: ColorsAsset.kPrimary, width: 5)),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            controller: cubit.scrollController,
                            itemCount: cubit.reversedChatMessage.length,
                            itemBuilder: (context, index) {
                              final message = cubit.reversedChatMessage[index];
                              return ChatBubble(
                                name1: "Me",
                                name2: widget.courseModel.teacherName!,
                                text: message.text!,
                                isUser: message.senderId == Constants.parentModel!.id ? true : false,
                              );
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorsAsset.kbackgorund),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          margin: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: cubit.messageController,
                                  decoration: InputDecoration(
                                    hintText: '${getLang(context, "Type a message...")}',
                                    contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.send,
                                  color: ColorsAsset.kPrimary,
                                ),
                                onPressed: () {
                                  MessageModel message = MessageModel(
                                    date: DateTime.now().toString(),
                                    text: cubit.messageController.text,
                                    sender: Constants.parentModel!.id,
                                    receiverId:widget.courseModel.teacher!.id,
                                    senderId: Constants.parentModel!.id,
                                  );
                                  cubit.messageController.clear();

                                    cubit.sendMessage(message,widget.courseModel.teacherName);

                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                // top: 200,
                  left: MediaQuery.of(context).size.width * 0.1,
                  child: Image.asset(
                    "assets/images/White and Blue Modern Business Online Courses Instagram Post.png",
                    height: 250,
                  ))
            ],
          ),
        );
      },
    );
  }
}
