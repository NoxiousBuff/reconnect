import 'package:flutter/material.dart';
import 'package:reconnect/components/rounded_button.dart';
import 'package:reconnect/screens/chat_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reconnect/services/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildModalProgressHUD(context),
    );
  }

  ModalProgressHUD buildModalProgressHUD(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Login',
            style: TextStyle(fontSize: 50.0),
          ),
          Column(
            children: [
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
                      isDense: true,
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
                      isDense: true,
                      contentPadding: EdgeInsets.all(20.0)),
                ),
              ),
            ],
          ),
          RoundedButton(
            colour: Colors.blue,
            buttonText: 'Log In',
            onPressed: () async {
              setState(() {
                showSpinner = true;
              });
              try {
                final user = context.read<Authentication>().signIn(
                      email: email,
                      password: password,
                    );
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
    );
  }
}
