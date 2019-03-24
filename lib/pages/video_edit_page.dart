import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:video_notes/model/crop_video.dart';
import 'package:video_notes/model/note.dart';
import 'package:video_player/video_player.dart';

class VideoEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final note = ModalRoute.of(context).settings.arguments as Note;
    return _VideoEditWidget(note);
  }
}

class _VideoEditWidget extends StatefulWidget {
  final Note _note;

  _VideoEditWidget(this._note);

  @override
  State<StatefulWidget> createState() => _VideoEditState(_note);
}

class _VideoEditState extends State<_VideoEditWidget> {
  final Note _note;
  VideoPlayerController _controller;

  int _from = 0;
  int _to = 10;

  _VideoEditState(this._note);

  Future<void> _saveVideo() async {
    await cropVideo(_note, _from, _to);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(_note.file))
      ..initialize().then((_) {
        setState(() {
          _to = _controller.value.duration.inSeconds;
        });
      })
      ..addListener(() {
        setState(() {
          if (_controller.value.position.inSeconds == _to) {
            _controller.seekTo(Duration(seconds: _from));
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.initialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 150,
              left: 0,
              right: 0,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                  color: Colors.black,
                  width: _controller.value.size.width,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 75,
              child: RangeSlider(
                min: 0,
                max: _controller.value.duration.inSeconds.toDouble(),
                lowerValue: _from.toDouble(),
                upperValue: _to.toDouble(),
                onChanged: (start, end) {
                  setState(() {
                    _from = start.toInt();
                    _to = end.toInt();
                    if (_from != _controller.value.position.inSeconds) {
                      _controller.seekTo(Duration(seconds: start.toInt()));
                    }
                  });
                },
              ),
            ),
            Positioned(
              bottom: 32,
              left: 20,
              child: Text(
                "${_controller.value.position.inSeconds} sec",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Positioned(
              bottom: 32,
              right: 20,
              child: Text(
                "from $_from to $_to sec",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                },
                icon: _controller.value.isPlaying
                    ? Icon(Icons.pause)
                    : Icon(Icons.play_arrow),
              ),
            ),
            Positioned(
              bottom: 125,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  }
                  _saveVideo();
                },
                child: Icon(Icons.save),
              ),
            )
          ],
        ),
      ),
    );
  }
}
