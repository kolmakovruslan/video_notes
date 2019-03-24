import 'dart:async';

import 'package:video_notes/model/get_notes_dir.dart';
import 'package:video_notes/model/note.dart';

Future<List<Note>> getSavedNotes() async {
  return (await getNotesDir()).list().where((entity) {
    return entity.path.endsWith(".mp4");
  }).map((video) {
    final file = video.path;
    final name = video.uri.pathSegments.last;
    final id = name.split('.').first;
    final stat = video.statSync();
    final size = stat.size;
    final dateCreate = stat.changed;
    return Note(name, id, file, size, dateCreate);
  }).toList();
}
