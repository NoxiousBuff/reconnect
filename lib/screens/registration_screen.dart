import 'package:flutter/material.dart';
import 'package:reconnect/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reconnect/screens/chat_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reconnect/services/database.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String name;
  String email;
  String password;
  bool showSpinner = false;
  DatabaseMethods databaseMethods = DatabaseMethods();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Register',
              style: TextStyle(fontSize: 50.0),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(style: BorderStyle.solid),
                        ),
                        hintText: 'Username',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(style: BorderStyle.solid),
                        ),
                        hintText: 'Email',
                        contentPadding: EdgeInsets.all(20.0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(style: BorderStyle.solid),
                        ),
                        hintText: 'Password',
                        contentPadding: EdgeInsets.all(20.0)),
                  ),
                ),
              ],
            ),
            RoundedButton(
              colour: Colors.indigo,
              buttonText: 'Register',
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                try {
                  Map<String, String> userInfoMap = {
                    'name': name,
                    'email': email,
                  };
                  databaseMethods.uploadUserInfo(userInfoMap);
                  final user = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return ChatRoom();
                    }));
                  }
                  setState(() {
                    showSpinner = false;
                  });
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
