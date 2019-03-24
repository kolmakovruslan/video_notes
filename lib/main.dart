import 'package:flutter/material.dart';
import 'package:video_notes/pages/launch_page.dart';
import 'package:video_notes/pages/record_video_page.dart';
import 'package:video_notes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video notes',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => LaunchPage(),
        Routes.list: (context) => LaunchPage(),
        Routes.record: (context) => RecordVideoPage(),
      },
    );
  }
}
