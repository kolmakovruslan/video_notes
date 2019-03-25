import 'dart:io';

import 'package:video_notes/model/note.dart';

Future<void> deleteNote(Note note) async {
  final file = File(note.file);
  file.deleteSync();
}