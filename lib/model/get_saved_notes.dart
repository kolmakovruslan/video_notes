import 'dart:async';

import 'package:video_notes/model/note.dart';

Future<List<Note>> getSavedNotes() async {
  return Future.delayed(Duration(seconds: 1), () {
    return List.generate(13, (index) {
      return Note("Video #$index", "123", "video.mp4");
    });
  });
}
