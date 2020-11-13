import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';

import 'StatusCard.dart';
import 'constants.dart';
import 'SpotImage.dart';

Future<void> main() async {
// void main() {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  UserCredential userCredential =
      await FirebaseAuth.instance.signInAnonymously();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Parking spot status'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void refresh(DragDownDetails details) {
    print("implement me, this should refresh material");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: kColors["black1"],
        ),
        backgroundColor: Colors.black,
        body: Center(
            child: GestureDetector(
          onVerticalDragDown: refresh,
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // children: [Text("hello")])));
              children: [StatusCard(), SpotImage()]),
        )));
  }
}
