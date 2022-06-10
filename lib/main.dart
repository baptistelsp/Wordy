import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:convert' as convert;
import '../object/WordElement.dart';
import 'package:cool_alert/cool_alert.dart';
import '../draw/RoundedSquare.dart';
import '../draw/SoftLine.dart';
import '../container/ctnLeft.dart';
import '../container/ctnRight.dart';
import '../i18n.dart';
import 'dart:ui' as ui;
import "../utils/countDown.dart";
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:flutter/services.dart';

import 'container/ctnPopupSuccess.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordy',

      theme: ThemeData(

        primarySwatch: Colors.indigo,
      ),
      home:  MyHomePage(title: 'Flutterrrr Demooo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;
  String language = ui.window.locale.toString().substring(0, 2);
  i18n translate = i18n(ui.window.locale.toString().substring(0, 2));

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}





class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: 25,
      width: MediaQuery.of(context).size.width,

    child: Text("", textAlign: TextAlign.center),
    );
  }
}




class _MyHomePageState extends State<MyHomePage> {

  int nbWordSend = 1;
  final myController = TextEditingController();
  bool isWordValaide = true;
  bool wordAlreadyProposed = false;
  List<WordElement> listWordsElement = [];
  List<String> listWords = [];
  late FocusNode myFocusNode;
  WordElement lastWordSend = WordElement(-1, "", "", 0, 0);

  String yesterdayWord = "...";
  String todayFind = "...";
  String wordDay = "...";

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
    getData(widget.language);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }



  void addWord(WordElement e){
    if(lastWordSend.id != -1){
      lastWordSend.lastWordSent = false;
      listWordsElement.add(lastWordSend);
    }

    lastWordSend = e;
    listWords.add(e.word);
    lastWordSend.lastWordSent = true;
  }


  Future<void> getData(String language) async {
    final response = await http.get(Uri.parse('http://137.74.198.245:8000/get/word/' + language));
    Map<String, dynamic> obj = jsonDecode(response.body.toString());
    setState(() {
      widget.language = language;
      listWordsElement.clear();
      nbWordSend = 1;
      lastWordSend = WordElement(-1, "", "", 0, 0);
      myController.clear();
      isWordValaide = true;
      myFocusNode.requestFocus();

      yesterdayWord = obj["yesterday_word"];
      todayFind = obj["find"].toString();
      wordDay = obj["word_day"].toString();
    });
  }


  Future<void> sendWord() async {

    final response = await http.post(
      Uri.parse('http://137.74.198.245:8000/send/word/' + widget.language),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'word': myController.text,
      }),
    );

    myController.clear();

    if (response.body.toString().length == 1){
      setState((){
        isWordValaide = false;
        wordAlreadyProposed = false;

      });
    } else {
      Map<String, dynamic> obj = jsonDecode(response.body.toString());
      setState((){

        if(listWords.contains(obj["word"])){
          isWordValaide = false;
          wordAlreadyProposed = true;
          print("already contain");

        } else {
          isWordValaide = true;
          wordAlreadyProposed = false;

          WordElement we = WordElement(nbWordSend, obj["word"], obj["similarity"], obj["progress"], obj["rank"]);
          addWord(we);
          nbWordSend++;

          print(obj["progress"]);
          if(obj["progress"] >= 995){

            listWordsElement.add(lastWordSend);

            print(widget.translate);
            print(lastWordSend.word);
            print(nbWordSend.toString());
            print(listWordsElement);
            print(wordDay);

            showDialog(
              context: context,
              builder: (_) => PopupSuccess(widget.translate, lastWordSend.word, nbWordSend, listWordsElement, wordDay)
            );
          }
        }


      });

    }
  }






  @override
  Widget build(BuildContext context) {

    print(listWordsElement);
    listWordsElement.sort((b, a) => a.progression.compareTo(b.progression));



    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(

            children: <Widget>[
              Container( // Topbar
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.blueAccent,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Text(
                        "Wordy",
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontFamily: 'ConcertOne')
                    ),
                    const SizedBox(height: 20,),
                    Text(
                        widget.translate.getTxt("subtitle"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white70)
                    )

                  ],
                ),
                ),

              renderAdptative()

              ],
        )),
    );
  }

  Container renderAdptative(){
    double screenWidth = MediaQuery.of(context).size.width;
    print(getData);

    if(screenWidth > 1550){
      return Container(
        constraints: BoxConstraints(minHeight:  MediaQuery.of(context).size.height *0.65),
        margin: const EdgeInsets.only(top: 50),

        child: Stack(
          children: [
            Positioned(left: 0,
              child: CtnLeft(widget.translate, todayFind, yesterdayWord, wordDay),
            ),
            Align(child:
            containerMainAxis()
            ),
             Positioned(right: 0,
              child: CtnRight(_update, getData, widget.translate),
            ),
          ],
        ),

      );
    } else {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child:
        containerMainAxis()

      );
    }

  }

  void _update() {
    print("update called");
    setState(() => {});
  }

  TextField renderTextField(isWordValid) {
    return TextField(
      autofocus: true,
      focusNode: myFocusNode,
      onSubmitted: (value){
        onButtonPress();
      },
      controller: myController,
      decoration: InputDecoration(
          helperText: " ",
          labelText: widget.translate.getTxt("word"),
          errorText: isWordValid ? null: errorWordSend() ,

          border:  OutlineInputBorder(),
        suffixIcon: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: Icon(Icons.send),
          onPressed:  () {
            onButtonPress();
          }
        )

      ),
    );
  }





  String errorWordSend(){

    if(wordAlreadyProposed){
      return widget.translate.getTxt("already_proposed");
    } else {
      return widget.translate.getTxt("invalid_word");
    }
  }

  void onButtonPress(){

    var text = myController.text;
    if(text.isNotEmpty){
      sendWord();
      myFocusNode.requestFocus();
      }
    }

  Container containerMainAxis(){

    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      constraints: const BoxConstraints(maxWidth: 600),
      child: renderGame(),
    );
  }


  Column renderGame(){

    double widthProgress = 100;

    if(MediaQuery.of(context).size.width < 400){
      widthProgress = 50;
    }

    if(lastWordSend.id != -1){
      return Column(
          children: [
            renderTextField(isWordValaide),
            const SizedBox(
              height: 50,
            ),


            Container(
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Container(
                    width: 20,
                    child:
                    Text("N°", textAlign: TextAlign.end,),
                  ),
                  Container(
                    width: 75,
                    child:
                    Text(widget.translate.getTxt("word"), textAlign: TextAlign.end,),
                  ),
                  Container(
                    width: 75,
                    child:
                    Text(widget.translate.getTxt("similarity"), textAlign: TextAlign.end,),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                  ),
                  shouldRenderCtn(context)
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              height: 5.0,
              color: Colors.transparent,
              child:  Container(
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),

                    )
                ),
              ),
            ),


            renderLastWord(),

            Container(
              padding: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height*0.3,
              child: ListView.builder(
                  addAutomaticKeepAlives: true,

                  itemCount: listWordsElement.length,
                  itemBuilder: (context, index) {

                    return listWordsElement[index].build(context);

                  }),
            ),

            renderNoItem()
          ]);
    } else {
      return Column(
          children: [
            renderTextField(isWordValaide),
            const SizedBox(
            height: 50,
          ),
            renderNoItem()

          ]);
    }

  }


  Container shouldRenderCtn(BuildContext context){

    double widthProgress = 100;

    if(MediaQuery.of(context).size.width < 400){
      return Container();
    } else {
      return Container(
        width: widthProgress,
        child:
        Text(widget.translate.getTxt("progress"), textAlign: TextAlign.center,)
      );
    }
  }

  Column renderNoItem(){

    if(lastWordSend.id == -1){
      return Column(
        children: [

          Container(
            constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
            child: Image.asset('empty_list.png')
          ),
          Container(
            child: Text(widget.translate.getTxt("propose_fw"), style: TextStyle(fontSize: 24),),
          ),
        ],
      );

    } else {
      return Column();
    }


  }

  Container renderLastWord(){
            if(lastWordSend.id != -1){
              return Container(
                margin: EdgeInsets.only(top: 10),

                  child: Column(
                  children: [

                    Container(
                      child:
                      lastWordSend.build(context),
                    ),

                    const SoftLine("#ECECEC")

                  ],
                )
              );
            } else {
              return Container();
            }
  }
}



