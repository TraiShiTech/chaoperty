// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:api_guide/api_guide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:random_color/random_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constant/Myconstant.dart';
import 'Register/SignIn_License.dart';
import 'Register/SignIn_Screen.dart';
import 'Register/SignIn_admin.dart';
import 'Register/Signup_License.dart';
import 'Setting/Draginto_example.dart';
import 'Setting/test.dart';
import 'package:infinite_canvas/infinite_canvas.dart';

import 'package:http/http.dart' as http;

import 'Style/loadAndCacheImage.dart';

///099400016565010
////Ref1. TC66020607
///REF2. 15022567
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();

  runApp(const MyApp());
}

//
//
///----------------------------------------------------->TT_
/// flutter run --enable-software-rendering
/// flutter run -d chrome --web-renderer html --enable-software-rendering
/// flutter run -d chrome  --no-sound-null-safety
/// flutter run -d chrome --web-browser-flag "--disable-web-security" (แก้ปัญหา security  CORS (Cross-Origin Resource Sharing))
/// flutter run -d web-server

///flutter run  -d chrome --web-renderer html --web-browser-flag "--disable-web-security"
///---------------------------------->
///
/// flutter build web --web-renderer html --release
///  flutter build web --release --no-sound-null-safety
/// flutter build web --web-renderer html --release --no-sound-null-safety
///  flutter build web --web-renderer html --release --dart-define=web-browser-flag=--disable-web-security (แก้ปัญหา security  CORS (Cross-Origin Resource Sharing))
///  flutter build web --web-renderer html --release --no-sound-null-safety --dart-define=web-browser-flag=--disable-web-security (แก้ปัญหา security  CORS (Cross-Origin Resource Sharing))
///  flutter build web --release --web-renderer=html --dart-define=web-browser-flag=--disable-web-security
//----------------------------------------------------->
// flutter build web --web-renderer html --release --dart-define=web-browser-flag=--disable-web-security --no-tree-shake-icons (แก้ปัญหา This application cannot tree shake icons fonts. It has non-constant instances of IconData at the following location)
///
///flutter build web --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false   (แก้ปัญหา Security Capture Screen )
///flutter build web --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false-browser-flag=--disable-web-security  (แก้ปัญหา Security Capture Screen + security  CORS )
///flutter build web --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false-define=web-browser-flag=--disable-web-security --no-tree-shake-icons  (แก้ปัญหา Security Capture Screen + security  CORS + icons )
///
///flutter build web --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false-browser-flag=--disable-web-security --no-tree-shake-icons
///
///flutter build web --web-renderer html --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false --no-tree-shake-icons
///$RECYCLE.BIN
///flutter build web --web-renderer html --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false-browser-flag=--disable-web-security --no-tree-shake-icons
//----(Git Lab)
//1.----> git add .
//2.------> git remote set-url origin https://gitlab.com/traishitech.com/chaoperty.git

//3.-------->git commit -m "แก้market"
//4.-----------> git push origin main
//----------------------------------------------------->
//----(Git Hub)
//1.----> git add .
//2.------> git remote set-url origin https://github.com/TraiShiTech/chaoperty.git
//3.-------->git commit -m "commit message"
//4.-----------> git push origin main
//----------------------------------------------------->
//กรุณาตัดหนี้รายการวางบิลให้เสร็จสิ้น ก่อนรอบวางบิลใหม่ หากติดปัญหากรุณาติดต่อ chaoperty
//ขออภัย ระบบจะมีการอัพเดต ณ. 12.55 -13.15 น.(25/07/2567)
// อัพเดตระบบเสร็จสิ้นแล้ว 13.15 น.(12/07/2567) กรุณาออกจากระบบและรีเฟรช...
// อัพเดตระบบเสร็จสิ้นแล้ว กรุณาออกจากระบบและรีเฟรช..
// 1.ขออภัย เกิดข้อผิดพลาดเมนู บัญชี->ชำระบิล กรุณาหยุดใช้ชั่วคราวจนกว่าระบบจะมีการอัพเดต(09/04/2567) // 2. ขออภัย ระบบจะมีการอัพเดต ณ. 10.40 -10.55 น.(09/04/2567)
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      // ignore: prefer_const_literals_to_create_immutables
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
      title: 'Chaoperty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          scrollbarTheme: ScrollbarThemeData().copyWith(
            thumbColor: MaterialStateProperty.all(Colors.lightGreen[200]),
          )),
      home: SignInScreen(),
      // home: GeneratedNodes(),
      // home: SignUPLicense()// SignInLicense(), // SignUnAdmin(),
    );
  }
}
