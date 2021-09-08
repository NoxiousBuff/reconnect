import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvitingPeople extends StatefulWidget {
  final String groupName;
  final String groupBio;
  final String groupPhotoLink;

  InvitingPeople(this.groupName, this.groupBio, {this.groupPhotoLink});

  @override
  _InvitingPeopleState createState() => _InvitingPeopleState(
        groupBio: this.groupBio,
        groupName: this.groupName,
        groupPhotoLink: this.groupPhotoLink,
      );
}

class _InvitingPeopleState extends State<InvitingPeople> {
  final String groupName;
  final String groupBio;
  final String groupPhotoLink;
  final currentUserId = FirebaseAuth.instance.currentUser.email;
  final groupRef = FirebaseFirestore.instance.collection('group');
  final String groupTime = DateTime.now().microsecondsSinceEpoch.toString();

  _InvitingPeopleState({this.groupName, this.groupBio, this.groupPhotoLink});

  addGroupToFirestore() {
    groupRef
        .doc(currentUserId)
        .collection('createdGroups')
        .doc('${groupName}_$groupTime')
        .set({'gr': 'fghfcjufghk'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        shape: Border(bottom: BorderSide(color: Colors.white54)),
        title: Text(
          'Add People',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: CupertinoTextField(
              placeholder: 'Type a Username',
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              decoration: BoxDecoration(color: Colors.transparent),
            ),
          ),
          Divider(
            height: 0.0,
            color: Colors.white38,
            thickness: 1.0,
          ),
          Expanded(
            child: Row(),
          ),
          Divider(
            height: 0.0,
            color: Colors.white38,
            thickness: 1.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: TextButton(
                  child: Text('Back'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: RaisedButton(
                  color: CupertinoColors.activeBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text('Done'),
                  onPressed: () {},
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
