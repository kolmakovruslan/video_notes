import 'dart:async';
import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:video_notes/model/get_notes_dir.dart';
import 'package:video_notes/model/note.dart';

Future<Note> createNote() async {
  final uuid = new Uuid().v1();
  final Directory dir = await getNotesDir();
  final video = File("${dir.path}/$uuid.mp4");
  video.create();
  final date = DateTime.now();
  return Note(uuid, uuid, video.path, 0, date);
}
