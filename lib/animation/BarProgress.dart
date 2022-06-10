import 'package:flutter/material.dart';

import '../draw/RoundedBar.dart';

class BarProgress extends StatefulWidget{
  final double progress;
  final String word;

  const BarProgress({Key? key, required this.progress, required this.word}) : super(key: key);

  _BarProgress createState() => _BarProgress();
}

class _BarProgress extends State<BarProgress>
    with TickerProviderStateMixin {

  double waveRadius = 0.0;
  late Animation<double> _animation;
  late AnimationController controller;
  bool animFinish = false;
  bool restartedAnim= false;

  @override
  void initState() {
    super.initState();

    startAnim();
  }




  @override
  Widget build(BuildContext context) {

    _animation = Tween(begin: 0.0, end: widget.progress).animate(controller)
      ..addListener(() {
        setState(() {
          waveRadius = _animation.value;
        });
      });

    return CustomPaint(
        painter: RoundedBar(waveRadius)

    );


  }

  @override
  void didUpdateWidget(BarProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.word != oldWidget.word) {
      controller.reset();
      startAnim();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  void startAnim(){
    controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      if(status == AnimationStatus.completed){
        animFinish = true;
      }
    });
  }

}
