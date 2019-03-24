import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_notes/model/get_saved_notes.dart';
import 'package:video_notes/model/note.dart';

class VideoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder<List<Note>>(
        future: getSavedNotes(),
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error",
                style: Theme.of(context).textTheme.display3,
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(
              child: Text(
                "Empty",
                style: Theme.of(context).textTheme.display3,
              ),
            );
          }
          final notes = snapshot.data;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Text(
                    notes[index].name,
                    style: Theme.of(context).textTheme.body1,
                  )
                ],
              );
            },
          );
        },
      );
}
