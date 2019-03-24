import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_notes/model/delete_note.dart';
import 'package:video_notes/model/get_saved_notes.dart';
import 'package:video_notes/model/note.dart';
import 'package:video_notes/routes.dart';
import 'package:video_notes/widgets/video_list_widget.dart';

class LaunchPage extends StatelessWidget {
  void _deleteNote(Note note) {
    deleteNote(note);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Video notes"),
        ),
        body: VideoListWidget(
          getSavedNotes(),
          _deleteNote,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.record);
          },
        ),
      );
}
