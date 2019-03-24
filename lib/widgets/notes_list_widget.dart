import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_notes/model/note.dart';
import 'package:video_notes/routes.dart';

class NotesListWidget extends StatelessWidget {
  final Future<List<Note>> notesFuture;
  final void Function(Note) noteDismissed;

  NotesListWidget(this.notesFuture, this.noteDismissed);

  @override
  Widget build(BuildContext context) =>
      FutureBuilder<List<Note>>(
        future: notesFuture,
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
                style: Theme
                    .of(context)
                    .textTheme
                    .display3,
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(
              child: Text(
                "Empty",
                style: Theme
                    .of(context)
                    .textTheme
                    .display3,
              ),
            );
          }
          final notes = snapshot.data;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Dismissible(
                key: Key(note.id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  noteDismissed(note);
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(Routes.edit, arguments: note);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _formatDate(note.dateCreate.toLocal()),
                          style: Theme
                              .of(context)
                              .textTheme
                              .title,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            "File size ${(note.size / 1024).floor()} kbytes",
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle
                                .apply(color: Colors.black45),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );

  String _numToTwoDigit(num num) => num < 10 ? "0$num" : num.toString();

  String _formatDate(DateTime date) {
    final day = _numToTwoDigit(date.day);
    final month = _numToTwoDigit(date.month);
    final year = date.year;
    final hour = _numToTwoDigit(date.hour);
    final minute = _numToTwoDigit(date.minute);
    return "$day/$month/$year $hour:$minute";
  }
}
