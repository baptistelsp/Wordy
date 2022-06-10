import 'package:flutter/material.dart';
import '../draw/ProgressSquare.dart';
import '../draw/SoftLine.dart';
import '../utils/color.dart';
import '../utils/Extension.dart';


class CtnLeft extends StatelessWidget{
  var translate;
  var find_nb;
  String yesterdayWord;
  String wordDay;
  CtnLeft(this.translate, this.find_nb, this.yesterdayWord, this.wordDay, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(left: 50),
      padding: EdgeInsets.only(bottom: 20),
          constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),

          decoration:  BoxDecoration(
              color: HexColor("#F5F5F5"),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              )
          ),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top:25),
                  child:
                  Text(translate.getTxt("day_nb") + wordDay, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
              ),
              Container(
                  margin: EdgeInsets.only(top:25),
                  child:
                  Text(translate.getTxt("found") + " " +find_nb + " " + translate.getTxt("persones") , style: TextStyle(fontSize: 20))
              ),

              Container(
                  margin: EdgeInsets.only(top:25),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom:10),
                        child:
                        Text(translate.getTxt("ldb"), style: TextStyle(fontSize: 20, decoration: TextDecoration.underline,), textAlign: TextAlign.end),

                      ),
                      rowColorLeftAxis('990 → 1000', 0),
                      rowColorLeftAxis('900 → 990', 25),
                      rowColorLeftAxis('1 → 900', 110),
                      rowColorLeftAxis('0', 1100),
                    ],
                  )

              ),

              Container(
                margin: EdgeInsets.only(top:25, left: 50, right: 50),
                child: SoftLine("#808080"),
              ),
              Container(
                  margin: EdgeInsets.only(top:10),
                  child:
                  Text(translate.getTxt("yes_word") + " " + yesterdayWord.toCapitalized(), style: TextStyle(fontSize: 20))
              ),

              Container(
                margin: EdgeInsets.only(top:10, left: 50, right: 50),
                child: SoftLine("#808080"),
              )

            ],
          ),
      );
    }

  Container rowColorLeftAxis(txt, rank){
    return Container(
        margin: EdgeInsets.only(top:2),
        child:     Row(
          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
          children: [
            Container(
              width: 100,
              child:
              Text(txt, style: TextStyle(fontSize: 16), textAlign: TextAlign.end),
            ),
            Container(
                margin: EdgeInsets.only(left: 20),
                height: 20,
                width: 20,
                child: ProgressSquare(rank)
            ),
          ],
        )
    );


  }
}


