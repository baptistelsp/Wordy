import 'package:flutter/material.dart';
import '../animation/BarProgress.dart';
import '../draw/ProgressSquare.dart';
import '../draw/RoundedBar.dart';
import '../utils/Extension.dart';

class WordElement extends StatelessWidget {

  int id;
  String word;
  String score;
  int progression;
  bool lastWordSent;
  final int rank;

  WordElement(this.id, this.word, this.score, this.progression, this.rank, {this.lastWordSent=false, Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Container ctn;




    return Container(
      margin: EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(right: 10),

        child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          Container(
            width: 20,
            child:
            Text(id.toString(), textAlign: TextAlign.end,),
          ),
          Container(
            width: 75,
            child:
            Text(word.toCapitalized(), textAlign: TextAlign.end,),
          ),
          Container(
            width: 75,
            child:
            Text(score.toString()+ " %", textAlign: TextAlign.end,  style: const TextStyle(fontWeight: FontWeight.bold)),
          ),

          Container(
            width: 20,
            height: 20,
            child: ProgressSquare(rank),
          ),
          shouldRenderCtn(context)

        ],
      )
    );

  }

  Container shouldRenderCtn(BuildContext context){

    double widthProgress = 100;

    if(MediaQuery.of(context).size.width < 400){
      return Container();
    } else {
      if(lastWordSent){

        return  Container(
            width: widthProgress,
            height: 10,
            child: BarProgress(
                progress: progression/1000,
                word: word
            )
        );
      } else {
        return  Container(
            width: widthProgress,
            height: 10,
            child: CustomPaint(
                painter: RoundedBar(progression/1000)

            )
        );
      }

    }
  }

  int levelOfSimilarity(){

    if(rank <= 10){
      return 1;
    } else if(rank <= 100){
      return 2;
    } else if(rank < 1000){
      return 3;
    } else {
      return 4;
    }
  }
}
