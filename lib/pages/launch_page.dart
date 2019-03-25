import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_notes/model/delete_note.dart';
import 'package:video_notes/model/get_saved_notes.dart';
import 'package:video_notes/model/note.dart';
import 'package:video_notes/routes.dart';
import 'package:video_notes/widgets/notes_list_widget.dart';

class LaunchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  void _deleteNote(Note note) {
    deleteNote(note);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Video notes"),
        ),
        body: NotesListWidget(
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
