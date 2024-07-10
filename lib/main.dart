// ignore_for_file: unused_import

import 'dart:io';

import 'package:api_guide/api_guide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Register/SignIn_License.dart';
import 'Register/SignIn_Screen.dart';
import 'Register/SignIn_admin.dart';
import 'Register/Signup_License.dart';
import 'Setting/Draginto_example.dart';
import 'Setting/test.dart';

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

void main() {
  HttpOverrides.global = new MyHttpOverrides();

  runApp(const MyApp());
}

//
//
///----------------------------------------------------->
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

//3.-------->git commit -m "หลัง สงการ."
//4.-----------> git push origin main
//----------------------------------------------------->
//----(Git Hub)
//1.----> git add .
//2.------> git remote set-url origin https://github.com/TraiShiTech/chaoperty.git
//3.-------->git commit -m "commit message"
//4.-----------> git push origin main
//----------------------------------------------------->
//กรุณาตัดหนี้รายการวางบิลให้เสร็จสิ้น ก่อนรอบวางบิลใหม่ หากติดปัญหากรุณาติดต่อ chaoperty
//ขออภัย ระบบจะมีการอัพเดต ณ. 12.10 -13.15 น.(08/07/2567)
// อัพเดตระบบเสร็จสิ้นแล้ว 13.15 น.(08/07/2567) กรุณาออกจากระบบและรีเฟรช...
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
      home: const SignInScreen(),
      // home: SignUPLicense()// SignInLicense(), // SignUnAdmin(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use APIGuide package with display method and pass needed parameters.
    return APIGuide().display(
      context: context,

      // Pass the API version as a double number.
      version: 1.0,

      // Pass the API last update as a DateTime.
      latestUpdate: DateTime.parse('2023-10-10'),

      // Pass the API introduction as a String.
      apiIntro: 'This is some introduction to API Guide.',

      // Pass the API Items List with all needed properties.
      apiItems: _apiItems,

      // Pass the API Servers as needed.

      // Pass the API FAQs items as needed
      apiFaqs: [
        APIGuideFAQ(
          question: 'Can Dash Fly?',
          answer: 'Yes, Dash can Fly.',
        ),
      ],
      urlHost: '',
    );
  }
}

// Define API Items with all needed properties
List<APIItem> _apiItems = [
  // Define the first API item
  APIItem(
    title: 'All Dashes',
    urlPath: '/dashes',
    description: 'All Dashes get example description.',

    // Define the request for the first API item
    request: APIGuideRequest(
      method: HttpRequestMethod.GET,
      params: [],
      body: [],
      headers: [],
    ),

    // Define the response for the first API item
    response: [
      const APIGuideResponse(
        statusCode: HttpResponseStatusCode.OK,
        headers: [],
        body: {
          "status": 200,
          "data": {
            "name": "Dash",
            "isFly": true,
          }
        },
      ),
    ],
  ),

  // Define the second API item
  APIItem(
    title: 'Create',
    urlPath: '/create',
    description: 'Store Dash post example description.',

    // Define the request for the second API item
    request: APIGuideRequest(
      method: HttpRequestMethod.POST,
      params: [],
      body: [
        const APIGuideRequestBody(
          key: 'name',
          value: 'Dash',
          type: PropertyType.string,
          description: 'This is the name attribute.',
          isRequired: true,
        ),
        const APIGuideRequestBody(
          key: 'isFly',
          value: true,
          type: PropertyType.boolean,
          description: 'This is the isFly attribute.',
          isRequired: true,
        ),
      ],
      headers: [],
    ),

    // Define the response for the second API item
    response: [
      const APIGuideResponse(
          statusCode: HttpResponseStatusCode.OK,
          headers: [],
          body: {
            "merchantId": "chaoperty",
            "paymentId": "chaopertyBETVKYvxl4THB",
            "purchaseId": "BETVKYvxl4",
            "genericPurchaseId": "BETVKYvxl4",
            "order": {
              "merchantReferenceId": "R67-04-000577",
              "merchantReference": "คุณ:2O,Market(LP)",
              "description": "คุณ :2O จองพื้นที่ M9 ,วันที่จอง : 2024-04-29",
              "currencyCode": "THB",
              "totalAmount": 61,
              "totalDiscount": 0,
              "netAmount": 61,
              "orderItems": [
                {
                  "product": {
                    "description": "พื้นที่ : M9",
                    "imageUrl":
                        "https://www.shutterstock.com/image-vector/map-icon-red-marker-pin-260nw-1962656155.jpg",
                    "name": "M9",
                    "price": 1,
                    "sku": "string"
                  },
                  "quantity": 1
                },
                {
                  "product": {
                    "description": "(ค่าทำความสะอาด*1พื้นที่)",
                    "imageUrl":
                        "https://cdn-icons-png.freepik.com/512/9727/9727444.png",
                    "name": "ค่าทำความสะอาด",
                    "price": 10,
                    "sku": "string"
                  },
                  "quantity": 1
                },
                {
                  "product": {
                    "description": "(ค่าส่วนกลาง*1พื้นที่)",
                    "imageUrl":
                        "https://cdn-icons-png.freepik.com/512/9727/9727444.png",
                    "name": "ค่าส่วนกลาง",
                    "price": 50,
                    "sku": "string"
                  },
                  "quantity": 1
                }
              ]
            },
            "requiredFieldsFormId": "beamdatacompany-checkout-phoneonly",
            "merchantBasicInfo": {
              "availablePaymentMethods": [],
              "logoUrl":
                  "https://storage.googleapis.com/organisation-logos/chaoperty-ดีไซน์ที่ยังไม่ได้ตั้งชื่อ (2).png",
              "name": "Chaoperty - Property Management System"
            },
            "expiry": "2024-04-24T16:56:00Z",
            "isDisabled": false,
            "paymentLink": "https://pay.beamcheckout.com/chaoperty/BETVKYvxl4",
            "redirectUrl": "",
            "state": "initiated",
            "timePaid": "0001-01-01T00:00:00Z",
            "created": "2024-04-24T09:46:26Z",
            "lastUpdated": "2024-04-24T16:56:00Z"
          }),
      const APIGuideResponse(
        statusCode: HttpResponseStatusCode.BadRequest,
        headers: [],
        body: {
          "status": 400,
          "data": {
            "message": "Error Data Not Stored!",
          }
        },
      ),
    ],
  ),
];
