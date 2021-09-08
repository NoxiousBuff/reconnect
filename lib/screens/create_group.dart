import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reconnect/screens/inviting_people.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupBioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        shape: Border(bottom: BorderSide(color: Colors.white54)),
        title: Text(
          'Create Group',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 84.0,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-vector/illustrated-people-avatars-pack_23-2148466556.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 114.0, left: 120.0),
                      child: ClipOval(
                        child: Container(
                          color: CupertinoColors.activeBlue,
                          child: IconButton(
                            icon: Icon(Icons.add_a_photo),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField.borderless(
                  controller: groupNameController,
                  clearButtonMode: OverlayVisibilityMode.editing,
                  padding: EdgeInsets.all(10.0),
                  placeholder: 'Add a name to your group',
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white38),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField.borderless(
                  controller: groupBioController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  clearButtonMode: OverlayVisibilityMode.editing,
                  padding: EdgeInsets.all(10.0),
                  placeholder: 'Add a bio to your group',
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white38),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30.0, horizontal: 8.0),
                child: RaisedButton(
                  color: CupertinoColors.activeBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text('Next'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InvitingPeople(
                          groupNameController.text,
                          groupBioController.text,
                          groupPhotoLink:
                              'https://image.freepik.com/free-vector/illustrated-people-avatars-pack_23-2148466556.jpg',
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
