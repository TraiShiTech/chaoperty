import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

Future<String> translateText(String text) async {
  final translator = GoogleTranslator();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var Lang = preferences.getString('Language') ?? 'th';
  if (Lang.toString() == 'th') {
    return text;
  } else {
    var translation = await translator.translate(
      text,
      to: '$Lang',
    );
    return (Lang.toString() == 'th') ? text : translation.text ?? text;
  }
}


class Translate {
  static Widget TranslateAndSetText(
    String text,
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
    int? maxLines,
  ) {
    return FutureBuilder<String>(
      future: translateText(text),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            'Translating...',
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 14,
            textAlign: textAlign,
            style: TextStyle(
              color: color,
              fontFamily: fontFamily,
              fontWeight: fontWeight ?? FontWeight.w400,
              fontSize: fontSize ?? 14,
            ),
          );
        } else if (snapshot.hasError) {
          return Text(
            'Error: ...',
            // 'Error: ${snapshot.error}',
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 14,
            textAlign: textAlign,
            style: TextStyle(
              color: color,
              fontFamily: fontFamily,
              fontWeight: fontWeight ?? FontWeight.w400,
              fontSize: fontSize ?? 14,
            ),
          );
        } else {
          return Text(
            snapshot.data ?? 'Translation error',
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 14,
            textAlign: textAlign,
            style: TextStyle(
              color: color,
              fontFamily: fontFamily,
              fontWeight: fontWeight ?? FontWeight.w400,
              fontSize: fontSize ?? 14,
            ),
          );
        }
      },
    );
  }
}
