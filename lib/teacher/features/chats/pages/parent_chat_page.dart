import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/locale/applocale.dart';
import '../../../../models/message_model.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/utils/colors.dart';
import '../../../../student/features/chats/widgets/message_bubble.dart';
import '../manager/teacher_chat_cubit.dart';

class ChatPageTeacherParent extends StatefulWidget {
  final String userId;
  final String userName;
  const ChatPageTeacherParent({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPageTeacherParent> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TeacherChatCubit.get(context).getMessagesParent(widget.userId);
    return BlocConsumer<TeacherChatCubit, TeacherChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        TeacherChatCubit cubit = TeacherChatCubit.get(context);
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
                                name2: "${getLang(context, 'parentOf')} ${widget.userName}",
                                name1: Constants.teacherModel!.name!,
                                text: message.text!,
                                isUser: message.senderId == Constants.teacherModel!.id ? true : false,
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
                                    sender: Constants.teacherModel!.name,
                                    receiverId: widget.userId,
                                    senderId: Constants.teacherModel!.id,
                                  );
                                  cubit.messageController.clear();
                                  cubit.sendMessageToParent(message, widget.userId, widget.userName);
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
