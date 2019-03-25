import 'package:flutter/services.dart';
import 'package:video_notes/model/note.dart';

Future<void> shareNote(Note note) async {
  final channel = const MethodChannel(
    "io.github.kolmakovruslan.videonotes/share",
  );
  channel.invokeMethod("share", note.file);
}
