import 'dart:async';

import 'package:flutter/widgets.dart';

class TimeTicker extends StatefulWidget {
  final bool _started;
  final TextStyle textStyle;

  TimeTicker(this._started, {this.textStyle});

  @override
  State<StatefulWidget> createState() => _TimeTickerState(_started, textStyle);
}

class _TimeTickerState extends State<TimeTicker> {
  final bool _started;
  final TextStyle _textStyle;
  int _ticks = 0;

  _TimeTickerState(this._started, this._textStyle);

  void _startTicks() async {
    Future.delayed(Duration(seconds: 1)).then((_) {
      if (!mounted) return;
      setState(() {
        _ticks = _ticks + 1;
      });
      if (_started) _startTicks();
    });
  }

  String _numToTwoDigit(num num) => num < 10 ? "0$num" : num.toString();

  @override
  void initState() {
    super.initState();
    if (_started) _startTicks();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_ticks / 60).floor();
    final seconds = (_ticks % 60).floor();
    return Text(
      "${_numToTwoDigit(minutes)}:${_numToTwoDigit(seconds)}",
      style: _textStyle,
    );
  }
}
