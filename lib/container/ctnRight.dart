import 'package:flutter/material.dart';
import '../draw/ProgressSquare.dart';
import '../draw/SoftLine.dart';

import 'package:language_picker/languages.dart';
import 'package:language_picker/language_picker.dart';

import '../i18n.dart';
import '../utils/color.dart';

class CtnRight extends StatelessWidget{
  var translate;
  var update;
  var getData;

  CtnRight(this.update, this.getData, this.translate, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return  Container(
      margin: EdgeInsets.only(right: 50),
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
                Text(translate.getTxt("how_to_play"), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
            ),
            Container(
                margin: EdgeInsets.only(top:10, left: 30, right: 30),
                child:
                Text(translate.getTxt("htp_desc"), style: TextStyle(fontSize: 16),  textAlign: TextAlign.justify)
            ),

            Container(
                margin: EdgeInsets.only(top:25),
                child:
                Text(translate.getTxt("an_example"), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
            ),

            Container(
                margin: EdgeInsets.only(top:10, left: 30, right: 30),
                child:
                Text(translate.getTxt("an_example_desc"), style: TextStyle(fontSize: 16),  textAlign: TextAlign.justify)
            ),

            Container(
                margin: EdgeInsets.only(top:40),
                child:
                 Text(translate.getTxt("chnage_l"), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
            ),

            Container(
              width: 200,
                margin: EdgeInsets.only(top:15),
                child: LanguagePickerDropdown(
                  initialValue: Languages.french,

                    languages: [
                    Languages.english,
                    Languages.french,
                  ],
                  onValuePicked: (Language language) {
                    print(language.name);
                    translate.setLanguage(language.isoCode);
                    getData(language.isoCode);
                  })
            ),




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