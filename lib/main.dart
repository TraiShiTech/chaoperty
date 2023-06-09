import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Register/SignIn_Screen.dart';

void main() {
  runApp(const MyApp());
}

///----------------------------------------------------->
/// flutter run --enable-software-rendering
/// flutter run -d chrome --web-renderer html --enable-software-rendering
/// flutter run -d chrome  --no-sound-null-safety
/// flutter run -d chrome --web-browser-flag "--disable-web-security" (แก้ปัญหา security  CORS (Cross-Origin Resource Sharing))
///----------------------------------------------------->
/// flutter build web --web-renderer html --release
///  flutter build web --release --no-sound-null-safety
/// flutter build web --web-renderer html --release --no-sound-null-safety
///  flutter build web --web-renderer html --release --dart-define=web-browser-flag=--disable-web-security (แก้ปัญหา security  CORS (Cross-Origin Resource Sharing))
///  flutter build web --web-renderer html --release --no-sound-null-safety --dart-define=web-browser-flag=--disable-web-security (แก้ปัญหา security  CORS (Cross-Origin Resource Sharing))
///  flutter build web --release --web-renderer=html --dart-define=web-browser-flag=--disable-web-security
///
///  flutter build web --web-renderer html --release --dart-define=web-browser-flag=--disable-web-security --no-tree-shake-icons (แก้ปัญหา This application cannot tree shake icons fonts. It has non-constant instances of IconData at the following location)

//----------------------------------------------------->
//----(Git Lab)
//1.----> git add .
//2.------> git remote set-url origin https://gitlab.com/traishitech.com/chaoperty.git
//3.-------->git commit -m "floor plan ลำพูน "
//4.-----------> git push origin main
//----------------------------------------------------->
//----(Git Hub)
//1.----> git add .
//2.------> git remote set-url origin https://github.com/TraiShiTech/chaoperty.git
//3.-------->git commit -m "commit message"
//4.-----------> git push origin main
//----------------------------------------------------->

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
      home: const SignInScreen(),
      //home: HomeScreen(),
    );
  }
}
