import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reconnect/screens/chat_room.dart';
import 'package:reconnect/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:reconnect/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Authentication>(
            create: (_) => Authentication(FirebaseAuth.instance)),
        StreamProvider(
          create: (context) => context.read<Authentication>().authChanges,
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Auth(),
      ),
    );
  }
}

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      return ChatRoom();
    } else {
      return HomeScreen();
    }
  }
}
