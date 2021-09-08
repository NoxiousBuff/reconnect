import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

User user = FirebaseAuth.instance.currentUser;

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(user.email),
          // Text(user.displayName),
          Text(user.uid),
          Text(user.isAnonymous.toString()),
        ],
      ),
    );
  }
}
