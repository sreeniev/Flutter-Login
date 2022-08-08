import 'package:flutter/material.dart';
import 'package:flutter_learn/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Splash(),
    );
  }
}
