import 'package:flutter/material.dart';

import '../../../../components/locale/applocale.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: '${getLang(context, "Parents")}'),
              Tab(text: '${getLang(context, "Students")}'
              ),
              Tab(text: '${getLang(context, "Group Chat")}'
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ParentsPage(),
            StudentsPage(),
            GroupChatPage(),
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
    return const Center(
      child: Text('Parents Page'),
    );
  }
}

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Students Page'),
    );
  }
}

class GroupChatPage extends StatelessWidget {
  const GroupChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Group Chat Page'),
    );
  }
}