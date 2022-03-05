import 'package:flutter/material.dart';
import 'package:frontend/global.dart';
import 'package:frontend/home.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(224, 229, 236, 1),
        primaryColor: Color(0xFF5D3FD3),
        textTheme: TextTheme(headline1: TextStyle(color: Color(0xff232357))),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return home("Scan", "");
  }
}
