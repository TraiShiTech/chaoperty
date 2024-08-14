import 'package:auto_size_text/auto_size_text.dart';
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

// String convertNumberToText(String text) {
//   dynamic result =
//   FutureBuilder<String>(
//     future: translateText(text),
//     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//        'Translating...';
//       } else if (snapshot.hasError) {
//         result = 'Error: ...';
//       } else {
//         result = snapshot.data ?? 'Translation error';
//       }
//       return result;
//     },
//   );
//   return result;
// }

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
    var data;
    return FutureBuilder<String>(
      future: Future.delayed(Duration(seconds: 1), () => translateText(text)),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState) {
          return Text(
            '$text',
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
            '$text',
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
          data = snapshot.data ?? 'Translation error';
          return Text(
            snapshot.data ?? '$text',
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

  static Widget TranslateAndSet_TextAutoSize(
    String text,
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSizeMin,
    double? fontSizeMax,
    int? maxLines,
  ) {
    return FutureBuilder<String>(
      future: translateText(text),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AutoSizeText(
            minFontSize: fontSizeMin ?? 8,
            maxFontSize: fontSizeMax ?? 14,
            maxLines: 1,
            '$text',
            overflow: TextOverflow.ellipsis,
            textAlign: textAlign,
            style: TextStyle(
              color: color,
              fontFamily: fontFamily,
              fontWeight: fontWeight ?? FontWeight.w400,
            ),
          );
        } else if (snapshot.hasError) {
          return AutoSizeText(
            minFontSize: fontSizeMin ?? 8,
            maxFontSize: fontSizeMax ?? 14,
            maxLines: 1,
            '$text',
            overflow: TextOverflow.ellipsis,
            textAlign: textAlign,
            style: TextStyle(
              color: color,
              fontFamily: fontFamily,
              fontWeight: fontWeight ?? FontWeight.w400,
            ),
          );
        } else {
          return AutoSizeText(
            minFontSize: fontSizeMin ?? 8,
            maxFontSize: fontSizeMax ?? 14,
            maxLines: 1,
            snapshot.data ?? '$text',
            overflow: TextOverflow.ellipsis,
            textAlign: textAlign,
            style: TextStyle(
              color: color,
              fontFamily: fontFamily,
              fontWeight: fontWeight ?? FontWeight.w400,
            ),
          );
        }
      },
    );
  }

  TranslateAndSet_String(
    String text,
  ) {
    dynamic result = '';
    return FutureBuilder<String>(
      future: translateText(text),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          result = 'Translating...';
        } else if (snapshot.hasError) {
          result = 'Error: ...';
        } else {
          result = snapshot.data ?? 'Translation error';
        }
        return result;
      },
    );
  }
}
