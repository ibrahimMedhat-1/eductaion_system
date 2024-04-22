import 'package:flutter/material.dart';

import '../../../components/locale/applocale.dart';
import '../../../shared/utils/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  List<String> messages = [];

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          '${getLang(context,  "Chat Page")}'
          ,
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
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(18),
                                    topLeft: Radius.circular(18),
                                    bottomLeft: Radius.circular(18)),
                                color: ColorsAsset.kLight2.withOpacity(0.6),
                              ),
                              child: Text(messages[index],
                                  style: const TextStyle(color: ColorsAsset.kTextcolor)),
                            ),
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
                              controller: textEditingController,
                              decoration:  InputDecoration(
                                hintText:  '${getLang(context,  "Type a message...")}'
                                ,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                              setState(() {
                                messages.add(textEditingController.text);
                                textEditingController.clear();
                              });
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
  }
}
