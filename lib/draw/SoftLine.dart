import 'package:flutter/material.dart';
import '../utils/color.dart';


class SoftLine extends StatelessWidget{
  final String hex;
  const SoftLine(this.hex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return Container(
        height: 5.0,
        color: Colors.transparent,
        child:  Container(
          decoration:  BoxDecoration(
              color: HexColor(hex),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),

              )
          ),
        ),
      );
    }
}