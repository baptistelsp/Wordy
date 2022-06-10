import 'package:flutter/material.dart';
import '../draw/ProgressSquare.dart';
import '../draw/SoftLine.dart';
import '../i18n.dart';
import '../object/WordElement.dart';
import '../utils/color.dart';
import '../utils/Extension.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import "../utils/countDown.dart";
import 'package:flutter/services.dart';
import '../utils/Extension.dart';




class PopupSuccess extends StatefulWidget {
   var translate;
   String wordSolution;
   var nbAttempt;
   var listWordsElement;
   var wordDay;
   PopupSuccess(this.translate, this.wordSolution, this.nbAttempt, this.listWordsElement, this.wordDay, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PopupSuccessState();
}

class PopupSuccessState extends State<PopupSuccess>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =  CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    final paris = tz.getLocation('Europe/London');

    var now = tz.TZDateTime.from(DateTime.now(), paris);
    var tomorrowMidnight = DateTime(now.year, now.month, now.day +1);
    int endTime = tomorrowMidnight.millisecondsSinceEpoch + 1000*60*60 - now.millisecondsSinceEpoch;

    String txt = "Wordy#${widget.wordDay} - ${widget.listWordsElement.length}/10\n\n";

    for(var i=0;i<widget.listWordsElement.length;i++){
      WordElement item = widget.listWordsElement[i];
      print(item.levelOfSimilarity());
      if (item.levelOfSimilarity()==1){
        txt += "🟩";
      }
      if (item.levelOfSimilarity()==2){
        txt += "🟨";
      }
      if (item.levelOfSimilarity()==3){
        txt += "🟧";
      }
      if (item.levelOfSimilarity()==4){
        txt += "🟥";
      }

      if((i+1)%15 == 0){
        txt += "\n";
      }
    }

    return render(txt, endTime);


  }


  Widget render(String txt, int endTime){

    double popupWidth = 475;
    double screenWidth = MediaQuery.of(context).size.width;
    if(screenWidth < 550){
      popupWidth = MediaQuery.of(context).size.width*0.9;
    }
    return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: popupWidth,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.vertical,

                  children: [
                    Container(
                      height: 100,
                      width: popupWidth,
                      decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          )
                      ),
                      child:  Center(
                        child:
                        Text(widget.translate.getTxt("well_done") + " !", style: TextStyle(fontSize: 32, color: Colors.white)),
                      ),
                    ),



                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: popupWidth,
                      child:
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${widget.translate.getTxt("you_found")} ",  style: TextStyle(fontSize: 20)),
                          Text(widget.wordSolution.toCapitalized(),  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(" ${widget.translate.getTxt("in")} ",  style: TextStyle(fontSize: 20)),
                          Text(widget.nbAttempt.toString(),  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(" ${widget.translate.getTxt("tries")} !",  style: TextStyle(fontSize: 20)),

                        ],)
                      ,
                    ),


                    Container(
                        margin: EdgeInsets.only(top: 25),
                        width: popupWidth,
                        child:
                        Text(
                          widget.translate.getTxt("summary"),
                          style: const TextStyle(
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                          ),
                            textAlign: TextAlign.center
                        )
                    ),

                    Container(
                      width: popupWidth,
                      margin: EdgeInsets.only(top: 25),
                      child: Text(txt, style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                    ),




                    Container(
                      height: 125,
                      width: popupWidth,
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 25, top: 20),
                            width: 450,
                            height: 5,
                            child: SoftLine("#ECECEC"),

                          ),




                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Column(
                                  children: [
                                    Text(widget.translate.getTxt("new_word_in"),  style: TextStyle(fontSize: 18)),
                                    Countdown((endTime/1000).round()),
                                  ],
                                ),


                                Container(
                                  padding: EdgeInsets.all(8.0),

                                  child:  ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => onPressed(txt),
                                    label: Text(
                                      widget.translate.getTxt("share"),
                                      style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.white),
                                    ),

                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(15.0),
                                        ),
                                        elevation: 0,
                                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                        onPrimary: Colors.blueAccent,
                                        primary: Colors.blueAccent),

                                  ),
                                )
                              ],
                            ),
                          )

                        ],




                      ),
                ),
            ]),
            ),
          ),
    );

  }

  void onPressed(String txt){
    Clipboard.setData(ClipboardData(text: txt));

  }
}
