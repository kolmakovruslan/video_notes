import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<Directory> getNotesDir() async {
  final Directory docs = await getApplicationDocumentsDirectory();
  final Directory notes = Directory("${docs.path}/Notes");
  if (!await notes.exists()) {
    await notes.create();
  }
  return notes;
}
