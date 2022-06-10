import 'package:flutter/material.dart';

import 'RoundedSquare.dart';


class ProgressSquare extends StatelessWidget{

  final int rank;
  const ProgressSquare(this.rank, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return   CustomPaint(
        painter: RoundedSquare(
            radius: 5,
            hex: getHexFromrank()
        )
    );
    throw UnimplementedError();
  }

  String getHexFromrank(){

    if(rank <= 10){
      return "#69B34C";
    } else if(rank <= 100){
      return "#ACB334";
    } else if(rank < 1000){
        return "#FF8E15";
    } else {
      return "#d50000";
    }
  }


}