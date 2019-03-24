import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_notes/model/note.dart';

Future<Note> createNote() async {
  final uuid = new Uuid().v1();
  final Directory dir = await getApplicationDocumentsDirectory();
  final video = File("${dir.path}/$uuid.mp4");
  video.create();
  return Note(uuid, uuid, video.path);
}
