import 'dart:io';

import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:video_notes/model/note.dart';

Future<void> cropVideo(Note note, int from, int to) async {
  final ffmpeg = new FlutterFFmpeg();

  final original = File(note.file);
  final parent = original.parent.path;
  final cutted = File("${parent}/cutted.mp4");

  await ffmpeg.execute(
    "-ss $from -to $to -i ${note.file} -c copy ${cutted.path}",
  );

  original.deleteSync();
  cutted.renameSync(original.path);
}
