import 'dart:async';

import 'package:eppo/constants/colors.dart';
import 'package:eppo/models/chat_room.dart';
import 'package:eppo/services/api_service.dart';
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
  Future<ChatRoom> _future = Future(() => ChatRoom(messages: []));
  ApiService _chatRoomService = ApiService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpTimedFetch();
  }

  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 2000), (timer) {
      setState(() {
        _future =
            _chatRoomService.getChatMessages(widget.userId, widget.otherId);
      });
    });
  }

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text('Chat'),
      ),
      body: FutureBuilder<ChatRoom>(
        future: _future,
        initialData: ChatRoom(messages: []),
        builder: (context, snapshot) => snapshot.hasData
            ? Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return snapshot.data!.messages![index].sender ==
                              widget.userId
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(6.0),
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: MyColors.primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                      snapshot.data!.messages![index].text ??
                                          '',
                                      style: TextStyle(color: MyColors.white)),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(6.0),
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: MyColors.gray3,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                      snapshot.data!.messages![index].text ??
                                          '',
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ],
                            );
                    },
                    itemCount: snapshot.data!.messages!.length,
                    shrinkWrap: true,
                  ))),
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (_controller.text.isEmpty) return;
                              print('Send');
                              _chatRoomService.sendMessage(widget.userId,
                                  widget.otherId, _controller.text);
                              ChatRoom _chatRoom = snapshot.data!;
                              _chatRoom.messages!.add(Messages(
                                  text: _controller.text,
                                  sender: widget.userId));
                              _future = Future.sync(() => _chatRoom);
                              _controller.clear();
                            },
                            color: MyColors.white,
                            icon: Icon(Icons.send),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            : Container(),
      ),
    );
  }
}
