import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/models/course_model.dart';
import 'package:education_system/student/features/chats/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../components/locale/applocale.dart';
import '../../../models/message_model.dart';
import '../../../shared/constants.dart';
import '../../../shared/utils/colors.dart';
import 'manager/student_chat_cubit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.isGroupChat = false, required this.courseModel});
  final bool isGroupChat;
  final CourseModel courseModel;
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StudentChatCubit.get(context).getMessages(widget.isGroupChat? widget.courseModel.id:widget.courseModel.teacher!.id);

    return BlocConsumer<StudentChatCubit, StudentChatState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {

    StudentChatCubit cubit = StudentChatCubit.get(context);
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
                            text: message.text!,
                            isUser: message.senderId == Constants.studentModel!.id ? true : false,
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
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const
                            Icon(
                              Icons.send,
                              color: ColorsAsset.kPrimary,
                            ),
                            onPressed: () {
                              MessageModel message = MessageModel(
                                date: DateTime.now().toString(),
                                text: cubit.messageController.text,
                                sender: Constants.studentModel!.name,
                                receiverId: widget.isGroupChat? widget.courseModel.id:  widget.courseModel.teacher!.id,
                                senderId: Constants.studentModel!.id,
                              );
                              cubit.messageController.clear();
                                if (widget.isGroupChat) {
                                  FirebaseFirestore.instance
                                      .collection('Students')
                                      .doc(message.senderId)
                                      .collection('chat')
                                      .doc(message.receiverId)
                                      .set({
                                    'lastMessage': message.text,
                                    'lastMessageDate': DateFormat('hh:mm').format(DateTime.now()),
                                  });

                                  var inDoctorDocument = FirebaseFirestore.instance
                                      .collection('Students')
                                      .doc(message.senderId)
                                      .collection('chat')
                                      .doc(message.receiverId)
                                      .collection('messages')
                                      .doc();
                                  inDoctorDocument.set(message.toMap(inDoctorDocument.id));
                                  widget.courseModel.reference!.collection('groupChat')
                                      .doc()
                                      .set({
                                    'lastMessage': message.text,
                                    'name': Constants.studentModel!.name,
                                    'lastMessageDate': DateFormat('hh:mm').format(DateTime.now()),
                                    'id': Constants.studentModel!.id,
                                  });
                                } else {
                                  cubit.sendMessage(message);
                                }


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
