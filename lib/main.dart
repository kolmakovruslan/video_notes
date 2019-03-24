import 'package:flutter/material.dart';
import 'package:video_notes/launch_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LaunchPage(),
    );
  }
}