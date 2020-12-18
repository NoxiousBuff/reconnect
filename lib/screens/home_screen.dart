import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reconnect/components/rounded_button.dart';
import 'package:reconnect/screens/login_screen.dart';
import 'package:reconnect/screens/registration_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Reconnect',
            style: TextStyle(fontSize: 50.0),
          ),
          Column(
            children: [
              RoundedButton(
                colour: Colors.indigo,
                buttonText: 'Register',
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                    return RegistrationScreen();
                  }));
                },
              ),
              RoundedButton(
                colour: Colors.blue,
                buttonText: 'Log In',
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
