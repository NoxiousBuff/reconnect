import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reconnect/screens/chatting_screen.dart';
import 'package:reconnect/services/database.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _auth = FirebaseAuth.instance;
  DatabaseMethods databaseMethods = DatabaseMethods();
  String searchText;
  TextEditingController searchTextEditingController = TextEditingController();
  QuerySnapshot searchSnapshot;
  initiateSearch() {
    databaseMethods.getUserByUserName(searchText, searchSnapshot).then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  Widget searchTile({String userName, String userEmail, Function onTap}) {
    return ListTile(
      onTap: onTap,
      title: Text(userName),
      subtitle: Text(userEmail),
      trailing: Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.tealAccent,
          child: Icon(
            Icons.messenger_outline_sharp,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTile(
                  userName: searchSnapshot.docs[index].data()['name'],
                  userEmail: searchSnapshot.docs[index].data()['email'],
                  onTap: () {
                    startConversation(
                        searchSnapshot.docs[index].data()['email'],
                        searchSnapshot.docs[index].data()['name']);
                  });
            },
            itemCount: searchSnapshot.docs.length,
            separatorBuilder: (context, index) {
              return Divider();
            },
          )
        : Container();
  }

  startConversation(String receiverEmail, String receiverName) {
    List<String> users = [receiverEmail, _auth.currentUser.email];
    String chatRoomId = getChatRoomId(receiverEmail, _auth.currentUser.email);
    Map<String, dynamic> chatRoomMap = {
      'users': users,
      'chatRoomId': chatRoomId,
    };

    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return ChattingScreen(
        chatRoomId: chatRoomId,
        receiverName: receiverName,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reconnect'),
      ),
      body: ListView(
        children: [
          TextField(
            controller: searchTextEditingController,
            onChanged: (value) {
              searchText = value;
            },
            decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 15.0,
                      ),
                      onPressed: () {
                        initiateSearch();
                        searchTextEditingController.clear();
                      },
                    ),
                    backgroundColor: Colors.grey.shade800,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey.shade700,
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 0.0)),
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 0.0)),
                hintText: 'Search By Username',
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0)),
          ),
          searchList(),
        ],
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return '$b\_$a';
  } else {
    return '$a\_$b';
  }
}
