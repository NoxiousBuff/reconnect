import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

class ChattingScreen extends StatefulWidget {
  final String chatRoomId;
  final String receiverName;
  ChattingScreen({this.chatRoomId, this.receiverName});
  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  User loggedInUser;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  String textMessage;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        String name = _auth.currentUser.displayName;
        print(name);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverName),
        elevation: 0.0,
        actions: [
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          IconButton(icon: Icon(Icons.video_call), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('ChatRoom')
                    .doc(widget.chatRoomId)
                    .collection('chat')
                    .orderBy('order')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final messages = snapshot.data.docs.reversed;
                  List<MessageBubble> messageBubbles = [];
                  for (var message in messages) {
                    final messageText = message.data()['text'];
                    final messageSender = message.data()['sender'];
                    final messageTime = message.data()['time'];

                    final currentUser = loggedInUser.email;

                    final messageBubble = MessageBubble(
                        sender: messageSender,
                        text: messageText,
                        isMe: currentUser == messageSender,
                        time: messageTime);

                    messageBubbles.add(messageBubble);
                  }

                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      children: messageBubbles,
                    ),
                  );
                },
              ),
              Container(
                width: double.infinity,
                height: 10.0,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey[850],
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0, 0.0),
                  )
                ]),
              ),
              Container(
                color: Colors.grey[900],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          textMessage = value;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type Your Message',
                            isDense: true,
                            contentPadding: EdgeInsets.all(13.0)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        color: Colors.transparent,
                        padding: EdgeInsets.only(right: 10.0, left: 10.0),
                        child: Icon(Icons.send),
                        onPressed: () {
                          String _onTimer(Timer timer) {
                            var nowHour = DateTime.now().hour;
                            var nowMin = DateTime.now().minute;
                            // var nowSecond = DateTime.now().second;
                            var nowTime = '$nowHour:$nowMin';
                            return nowTime;
                          }

                          if (textMessage != '') {
                            setState(() {
                              firestore
                                  .collection('ChatRoom')
                                  .doc(widget.chatRoomId)
                                  .collection('chat')
                                  .add({
                                'text': textMessage,
                                'sender': loggedInUser.email,
                                'time': _onTimer(Timer.periodic(
                                  Duration(seconds: 1),
                                  _onTimer,
                                )).toString(),
                                'order': DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString()
                              });
                            });
                          }

                          messageTextController.clear();
                          textMessage = '';
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MessageBubble extends StatefulWidget {
  final String sender;
  final String text;
  final bool isMe;
  final String time;

  MessageBubble({this.sender, this.text, this.isMe, this.time});

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  printText() {
    print('his is the text starting');
    print(widget.text);
    print('this is the text ending.');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: widget.isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.zero,
                    bottomLeft: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.zero,
                  ),
            color: widget.isMe
                ? Colors.teal.withOpacity(0.5)
                : Colors.indigo.withOpacity(0.5),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: widget.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     bottom: 2.0,
                  //   ),
                  //   child: Text(
                  //     sender,
                  //     style: TextStyle(fontSize: 12.0),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      widget.text ?? 'your text is null',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              widget.time,
              style: TextStyle(
                  fontSize: 9.0, color: Colors.white.withOpacity(0.5)),
            ),
          )
        ],
      ),
    );
  }
}
