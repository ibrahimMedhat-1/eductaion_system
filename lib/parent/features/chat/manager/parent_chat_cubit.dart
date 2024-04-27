import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../models/message_model.dart';
import '../../../../shared/constants.dart';

part 'parent_chat_state.dart';

class ParentChatCubit extends Cubit<ParentChatState> {
  ParentChatCubit() : super(ParentChatInitial());
  static ParentChatCubit get(context) => BlocProvider.of(context);
  final TextEditingController messageController = TextEditingController();
  List<MessageModel> chatMessage = [];
  List<MessageModel> reversedChatMessage = [];
  ScrollController scrollController = ScrollController();
  String? name;
  void sendMessage(MessageModel message,teacherName) async{
    await FirebaseFirestore.instance.collection('parents').doc(Constants.parentModel!.id).get().then((value) async {
      print(value.data());
      await value.data()!['studentReference'].get().then((value) async {
        name = await value.data()!['name'];
      });
    });
    FirebaseFirestore.instance
        .collection('parents')
        .doc(message.senderId)
        .collection('chat')
        .doc(message.receiverId)
        .set({
      'teacherName':teacherName,
      'lastMessage': message.text,
      'lastMessageDate': DateFormat('hh:mm').format(DateTime.now()),
    });
    var inUserDocument = FirebaseFirestore.instance
        .collection('teachers')
        .doc(message.receiverId)
        .collection('chatparent')
        .doc(message.senderId)
        .collection('messages')
        .doc();
    inUserDocument.set(message.toMap(inUserDocument.id));
    var inDoctorDocument = FirebaseFirestore.instance
        .collection('parents')
        .doc(message.senderId)
        .collection('chat')
        .doc(message.receiverId)
        .collection('messages')
        .doc();
    inDoctorDocument.set(message.toMap(inDoctorDocument.id));
    FirebaseFirestore.instance
        .collection('teachers')
        .doc(message.receiverId)
        .collection('chatparent')
        .doc(message.senderId)
        .set({
      'lastMessage': message.text,
      'name': name,
      'lastMessageDate': DateFormat('hh:mm').format(DateTime.now()),
      'id': Constants.parentModel!.id,
    });
  }

  void getMessages(id) {
    print(Constants.parentModel!.id);

      FirebaseFirestore.instance
          .collection('parents')
          .doc(Constants.parentModel!.id)
          .collection('chat')
          .doc(id)
          .collection('messages')
          .orderBy('date')
          .snapshots()
          .listen((event) {
        chatMessage.clear();
        for (var element in event.docs) {
          chatMessage.add(MessageModel.fromJson(element.data()));
        }
        reversedChatMessage = chatMessage.reversed.toList();
        emit(GetAllMessagesSuccessfully());
        scrollController.animateTo(
          double.minPositive,
          duration: const Duration(microseconds: 1),
          curve: Curves.bounceIn,
        );
      });
    }



}
