import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../../models/course_model.dart';
import '../../../../models/message_model.dart';
import '../../../../shared/constants.dart';

part 'student_chat_state.dart';

class StudentChatCubit extends Cubit<StudentChatState> {
  StudentChatCubit() : super(StudentChatInitial());
  static StudentChatCubit get(context) => BlocProvider.of(context);
  final TextEditingController messageController = TextEditingController();
  List<MessageModel> chatMessage = [];
  List<MessageModel> reversedChatMessage = [];
  ScrollController scrollController = ScrollController();
  List<CourseModel> myCourses = [];
  void getMyCourses() async {
    emit(GetMyCoursesLoading());
    await Constants.studentModel!.reference!.collection('courses').get().then((value) async {
      for (var element in value.docs) {
        DocumentReference<Map<String, dynamic>> course = await element.data()['reference'];
        await course.get().then((value) {
          myCourses.add(CourseModel.fromJson(value.data()));
        });
      }
      emit(GetMyCoursesSuccessfully());
    });
  }


  void sendMessage(MessageModel message) {
    FirebaseFirestore.instance
        .collection('Students')
        .doc(message.senderId)
        .collection('chat')
        .doc(message.receiverId)
        .set({
      'lastMessage': message.text,
      'lastMessageDate': DateFormat('hh:mm').format(DateTime.now()),
    });
    var inUserDocument = FirebaseFirestore.instance
        .collection('teachers')
        .doc(message.receiverId)
        .collection('chat')
        .doc(message.senderId)
        .collection('messages')
        .doc();
    inUserDocument.set(message.toMap(inUserDocument.id));
    var inDoctorDocument = FirebaseFirestore.instance
        .collection('Students')
        .doc(message.senderId)
        .collection('chat')
        .doc(message.receiverId)
        .collection('messages')
        .doc();
    inDoctorDocument.set(message.toMap(inDoctorDocument.id));
    FirebaseFirestore.instance
        .collection('teachers')
        .doc(message.receiverId)
        .collection('chat')
        .doc(message.senderId)
        .set({
      'lastMessage': message.text,
      'name': Constants.studentModel!.name,
      'lastMessageDate': DateFormat('hh:mm').format(DateTime.now()),
      'id': Constants.studentModel!.id,
    });
  }
  void getMessages(userId) {
    print(Constants.studentModel!.id);
    print(userId);
    FirebaseFirestore.instance
        .collection('Students')
        .doc(Constants.studentModel!.id)
        .collection('chat')
        .doc(userId)
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
