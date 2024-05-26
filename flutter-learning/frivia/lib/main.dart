import 'package:flutter/material.dart';
import 'package:frivia/pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frivia',
      theme: ThemeData(
        fontFamily: 'ArchitectsDaugther',
        scaffoldBackgroundColor: Colors.amberAccent,
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
