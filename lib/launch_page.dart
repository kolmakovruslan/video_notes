import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_notes/video_list_widget.dart';

class LaunchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: <Widget>[
            VideoListWidget(),
            Positioned(
              child: FloatingActionButton(
                child: Icon(Icons.camera_alt),
                onPressed: () {},
              ),
              bottom: 16,
              right: 16,
            ),
          ],
        ),
      );
}
