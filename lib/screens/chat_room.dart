import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reconnect/screens/search_screen.dart';

final firebase = FirebaseFirestore.instance;

class ChatRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ChatRoom'),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) {
                  return SearchScreen();
                },
              ),
            );
          },
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: firebase.collection('ChatRoom').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                CircularProgressIndicator();
              }
              final people = snapshot.data.docs;
              List<PersonTile> peopleList = [];
              for (var person in people) {
                final personName = person.data()['chatRoomId'];

                final personTile = PersonTile(title: Text(personName));
                peopleList.add(personTile);
              }
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: peopleList,
              );
            },
          ),
        ));
  }
}

class PersonTile extends StatelessWidget {
  final title;
  PersonTile({this.title});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.purple.shade50,
      ),
      title: title,
      onTap: () {},
    );
  }
}
