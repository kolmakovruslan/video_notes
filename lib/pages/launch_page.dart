import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_notes/model/get_saved_notes.dart';
import 'package:video_notes/routes.dart';
import 'package:video_notes/widgets/video_list_widget.dart';

class LaunchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: <Widget>[
            VideoListWidget(getSavedNotes()),
            Positioned(
              child: FloatingActionButton(
                child: Icon(Icons.camera_alt),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.record);
                },
              ),
              bottom: 16,
              right: 16,
            ),
          ],
        ),
      );
}
