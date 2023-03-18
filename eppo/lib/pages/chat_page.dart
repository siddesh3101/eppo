import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String otherId;
  const ChatPage({super.key, required this.userId, required this.otherId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: Text('Hello'),
              );
            },
            itemCount: 10,
            shrinkWrap: true,
          )))
        ],
      ),
    );
  }
}
