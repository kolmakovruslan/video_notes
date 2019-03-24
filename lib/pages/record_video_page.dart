import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_notes/model/create_note.dart';
import 'package:video_notes/model/note.dart';
import 'package:video_notes/widgets/time_ticker_widget.dart';

class RecordVideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecordVideoState();
}

class _RecordVideoState extends State<RecordVideoPage> {
  bool _fit = true;
  int _cameraIndex = 0;
  CameraController _controller;

  bool _error = false;
  Note _note;

  void _initCamera(int camera) async {
    final cameras = await availableCameras();
    final controller = CameraController(
      cameras[camera],
      ResolutionPreset.medium,
    );
    controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        _controller = controller;
        _error = false;
        _cameraIndex = camera;
      });
    }).catchError((_) {
      _controller = null;
      _error = true;
      _cameraIndex = 0;
    });
  }

  void _startRecord() async {
    if (_controller == null || !_controller.value.isInitialized) return;
    final note = await createNote();
    if (note == null) {
      setState(() {
        _error = true;
        _note = null;
      });
      return;
    }
    print("Strart note created ${note.file}");
    _controller.startVideoRecording(note.file).then((_) {
      setState(() {
        _error = false;
        _note = note;
      });
    }).catchError((_) {
      setState(() {
        _error = true;
        _note = note;
      });
    });
  }

  void _stopRecord() async {
    if (_controller == null || !_controller.value.isInitialized) return;
    _controller.stopVideoRecording().then((_) {
      setState(() {
        _error = false;
      });
    }).catchError((_) {
      setState(() {
        _error = true;
      });
    });
  }

  void _switchCamera() async {
    await _controller?.dispose();
    final cameraIndex = _cameraIndex == 0 ? 1 : 0;
    _initCamera(cameraIndex);
  }

  void _switchRatio() {
    setState(() {
      _fit = !_fit;
    });
  }

  bool _isRecord() => _controller?.value?.isRecordingVideo == true;

  @override
  void initState() {
    super.initState();
    _initCamera(_cameraIndex);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_error) {
      return Center(
        child: Text(
          "Error",
          style: Theme.of(context).textTheme.display3,
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FittedBox(
            fit: _fit ? BoxFit.fitWidth : BoxFit.cover,
            child: Container(
              width: _controller.value.previewSize.width,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: CameraPreview(_controller),
              ),
            ),
          ),
          Positioned(
            child: Visibility(
              child: FloatingActionButton(
                child: Icon(Icons.switch_camera),
                onPressed: () {
                  _switchCamera();
                },
              ),
              visible: !_isRecord(),
            ),
            bottom: 16,
            left: 16,
          ),
          Positioned(
            child: Visibility(
              child: FloatingActionButton(
                child: Icon(Icons.aspect_ratio),
                onPressed: () {
                  _switchRatio();
                },
              ),
              visible: true,
            ),
            bottom: 16,
            right: 16,
          ),
          Positioned(
            child: Visibility(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.black26,
                  child: TimeTicker(
                    _isRecord(),
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              visible: _isRecord(),
            ),
            bottom: 90,
            left: 0,
            right: 0,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: _isRecord() ? Icon(Icons.stop) : Icon(Icons.fiber_manual_record),
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        onPressed: () {
          if (_isRecord()) {
            _stopRecord();
          } else {
            _startRecord();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
