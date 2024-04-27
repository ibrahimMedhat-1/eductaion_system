import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../models/message_model.dart';
import '../../../../models/student_model.dart';
import '../../../../shared/constants.dart';

part 'teacher_chat_state.dart';

class TeacherChatCubit extends Cubit<TeacherChatState> {
  TeacherChatCubit() : super(TeacherChatInitial());
  static TeacherChatCubit get(context) => BlocProvider.of(context);
  final TextEditingController messageController = TextEditingController();
  List<MessageModel> chatMessage = [];
  List<MessageModel> reversedChatMessage = [];
  ScrollController scrollController = ScrollController();

  List<StudentModel> students = [];
  void getCourseStudents(String year) async {
    await FirebaseFirestore.instance
        .collection('secondary years')
        .doc(year)
        .collection(Constants.teacherModel!.subject!)
        .doc(Constants.teacherModel!.courseId!.trim())
        .collection('students')
        .get()
        .then((value) async {
      students.clear();
      for (var element in value.docs) {
        DocumentReference<Map<String, dynamic>> reference = await element.data()['reference'];
        await reference.get().then((value) {
          students.add(StudentModel.fromJson(value.data()));
        });
        print(students.length);
      }
      emit(GetCourseStudents());
    });
  }

  void sendMessage(MessageModel message) {
    FirebaseFirestore.instance
        .collection('teachers')
        .doc(message.senderId)
        .collection('chat')
        .doc(message.receiverId)
        .set({
      'lastMessage': message.text,
      'lastMessageDate': DateFormat('hh:mm').format(DateTime.now()),
    });
    var inUserDocument = FirebaseFirestore.instance
        .collection('teachers')
        .doc(message.senderId)
        .collection('chat')
        .doc(message.receiverId)
        .collection('messages')
        .doc();
    inUserDocument.set(message.toMap(inUserDocument.id));
    FirebaseFirestore.instance
        .collection('students')
        .doc(message.receiverId)
        .collection('chat')
        .doc(message.senderId)
        .set({
      'lastMessage': message.text,
      'name': Constants.teacherModel!.name,
      'image': Constants.teacherModel!.image,
      'lastMessageDate': DateFormat('hh:mm').format(DateTime.now()),
      'id': Constants.teacherModel!.id,
    });
    var inDoctorDocument = FirebaseFirestore.instance
        .collection('students')
        .doc(message.receiverId)
        .collection('chat')
        .doc(message.senderId)
        .collection('messages')
        .doc();
    inDoctorDocument.set(message.toMap(inDoctorDocument.id));
  }

  void getMessages(studentId) {
    FirebaseFirestore.instance
        .collection('teachers')
        .doc(Constants.teacherModel!.id)
        .collection('chat')
        .doc(studentId)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      chatMessage.clear();
      for (var element in event.docs) {
        chatMessage.add(MessageModel.fromJson(element.data()));
        emit(GetAllMessagesSuccessfully());
      }
      reversedChatMessage = chatMessage.reversed.toList();
      scrollController.animateTo(
        double.minPositive,
        duration: const Duration(microseconds: 1),
        curve: Curves.bounceIn,
      );
    });
  }
  void getMessagesGroup(year) {
    FirebaseFirestore.instance
        .collection('secondary years')
        .doc(year)
        .collection(Constants.teacherModel!.subject!)
        .doc(Constants.teacherModel!.courseId!).collection('groupChat').orderBy('date').snapshots().listen((event) {
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
  Future<List<Map<String, dynamic>>> getParents(teacherId) async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('teachers').doc(teacherId).collection("chatparent").get();

    List<Map<String, dynamic>> parents = [];

    querySnapshot.docs.forEach((document) {
      Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
      String userId = document.id;
      parents.add({
        'id': userId,
        'name': userData['id'],
      });
    });

    return parents;
  }
  void getMessagesParent(parentId) {
    FirebaseFirestore.instance
        .collection('teachers')
        .doc(Constants.teacherModel!.id)
        .collection("chatparent")
        .doc(parentId)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      chatMessage.clear();
      for (var element in event.docs) {
        chatMessage.add(MessageModel.fromJson(element.data()));
        emit(GetAllMessagesSuccessfully());
      }
      reversedChatMessage = chatMessage.reversed.toList();
      scrollController.animateTo(
        double.minPositive,
        duration: const Duration(microseconds: 1),
        curve: Curves.bounceIn,
      );
    });
  }
  void sendMessageToParent(MessageModel message,id,name) {
    FirebaseFirestore.instance
        .collection('teachers')
        .doc(message.senderId)
        .collection('chatparent')
        .doc(message.receiverId)
        .set({

      'id': id,
      'name': name,
      'lastMessage': message.text,
      'lastMessageDate': DateFormat('hh:mm').format(DateTime.now()),
    });
    var inUserDocument = FirebaseFirestore.instance
        .collection('teachers')
        .doc(message.senderId)
        .collection('chatparent')
        .doc(message.receiverId)
        .collection('messages')
        .doc();
    inUserDocument.set(message.toMap(inUserDocument.id));
    FirebaseFirestore.instance
        .collection('parents')
        .doc(message.receiverId)
        .collection('chat')
        .doc(message.senderId)
        .set({
      'lastMessage': message.text,
      'name': Constants.teacherModel!.name,
      'image': Constants.teacherModel!.image,
      'lastMessageDate': DateFormat('hh:mm').format(DateTime.now()),
      'id': Constants.teacherModel!.id,
    });
    var inDoctorDocument = FirebaseFirestore.instance
        .collection('parents')
        .doc(message.receiverId)
        .collection('chat')
        .doc(message.senderId)
        .collection('messages')
        .doc();
    inDoctorDocument.set(message.toMap(inDoctorDocument.id));
  }

}
