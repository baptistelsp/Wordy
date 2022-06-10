import 'dart:async';

import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  final int seconds;
  const Countdown(this.seconds, {Key? key}) : super(key: key);

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {

  late Timer _timer;
  late int seconds;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(constructTime(seconds),  style: TextStyle(fontSize: 32),),
    );
  }

  // Time formatting, converted to the corresponding hh:mm:ss format according to the total number of seconds
  String constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return formatTime(hour) + ":" + formatTime(minute) + ":" + formatTime(second);
  }

  // Digital formatting, converting 0-9 time to 00-09
  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  @override
  void initState() {
    super.initState();

    seconds = widget.seconds;
    startTimer();
  }

  void startTimer() {
    // Set 1 second callback
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      // Update interface
      setState(() {
        // minus one second because it calls back once a second
        seconds--;
      });
      if (seconds == 0) {
        // Countdown seconds 0, cancel timer
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }
}