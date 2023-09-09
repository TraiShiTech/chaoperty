import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'Constant/Myconstant.dart';
import 'Register/SignIn_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

import 'Report_Dashboard/Dashboard_Screen.dart';
import 'Style/downloadImage.dart';

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
//3.-------->git commit -m "อัพเดตรายงาน ครั้งใหญ่ 9/9/23"
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
      home:
          // DashboardScreen()

          SignInScreen(),
      //home: HomeScreen(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  int tappedIndex = -1; // Index of the exploded slice, initially set to -1
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  List<_SalesData> data2 = [
    _SalesData('Jan', 40),
    _SalesData('Feb', 28),
    _SalesData('Mar', 10),
    _SalesData('Apr', 0),
    _SalesData('May', 5)
  ];
  final chartKey1 = GlobalKey();
  final chartKey2 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Column(children: [
          ElevatedButton(
            onPressed: () async {
              captureAndConvertToBase64(chartKey1, '');
            },
            child: Text('Export Chart as Excel'),
          ),
          RepaintBoundary(
            key: chartKey1,
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Half yearly sales analysis'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Sales',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true)),
                  LineSeries<_SalesData, String>(
                      dataSource: data2,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'name',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
          ),
          ElevatedButton(
            onPressed: () async {
              captureAndConvertToBase64(chartKey2, '');
            },
            child: Text('Export Chart as Excel'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              //Initialize the spark charts widget
              child: RepaintBoundary(
                key: chartKey2,
                child: GestureDetector(
                  onTap: () {
                    // Reset the exploded slice when the chart is tapped
                    setState(() {
                      tappedIndex = -1;
                    });
                  },
                  child: SfCircularChart(
                    series: <PieSeries<SalesData, String>>[
                      PieSeries<SalesData, String>(
                        dataSource: <SalesData>[
                          SalesData('Category 1', 30),
                          SalesData('Category 2', 25),
                          SalesData('Category 3', 20),
                          SalesData('Category 4', 15),
                        ],
                        xValueMapper: (SalesData data, _) => data.year,
                        yValueMapper: (SalesData data, _) => data.sales,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        explode: true, // Enable explosion for the entire series
                        explodeIndex:
                            tappedIndex, // Specify the exploded slice index
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]));
  }

//https://support.syncfusion.com/kb/article/10649/how-to-create-excel-charts-in-an-excel-programmatically-in-flutter
//https://www.syncfusion.com/flutter-widgets/flutter-charts/chart-types/pie-chart?utm_source=pubdev&utm_medium=listing&utm_campaign=flutter-charts-pubdev
  // Future<void> captureAndConvertToBase64() async {
  //   final boundary =
  //       chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   final image =
  //       await boundary.toImage(pixelRatio: 3.0); // Adjust pixelRatio as needed

  //   // Convert the captured image to bytes
  //   final byteData = await image.toByteData(format: ImageByteFormat.png);
  //   final buffer = byteData!.buffer.asUint8List();

  //   // Encode the bytes to base64
  //   final base64String = base64Encode(buffer);
  //   int timestamp = DateTime.now().millisecondsSinceEpoch;
  //   print(base64String);
  //   String fileName_Slip = 'SfCircularChart_$timestamp.png';
  //   await Future.delayed(Duration(milliseconds: 100));
  //   try {
  //     final url =
  //         '${MyConstant().domain}/File_downloadImg.php?name=$fileName_Slip&Foder=kad_taii';

  //     final response = await http.post(
  //       Uri.parse(url),
  //       body: {
  //         'image': base64String,
  //         'Foder': 'kad_taii',
  //         'name': fileName_Slip
  //       }, // Send the image as a form field named 'image'
  //     );

  //     if (response.statusCode == 200) {
  //       print('Image uploaded successfully');
  //       downloadImage(fileName_Slip);
  //       // downloadImage('${MyConstant().domain}/files/$foder/contract/$Form_Img_',
  //       //         '${Form_Img_}')
  //       //     .deleteFile(fileName_Slip);
  //     } else {
  //       print('Image upload failed');
  //     }
  //   } catch (e) {
  //     print('Error during image processing: $e');
  //   }

  //   // return base64String;
  // }

  // Future<void> downloadImage(fileName_Slip) async {
  //   try {
  //     // first we make a request to the url like you did
  //     // in the android and ios version
  //     final http.Response r = await http.get(
  //       Uri.parse('${MyConstant().domain}/Awaitdownload/$fileName_Slip'),
  //     );

  //     // we get the bytes from the body
  //     final data = r.bodyBytes;
  //     // and encode them to base64
  //     final base64data = base64Encode(data);

  //     // then we create and AnchorElement with the html package
  //     final a = html.AnchorElement(href: 'data:image/jpeg;base64,$base64data');

  //     // set the name of the file we want the image to get
  //     // downloaded to
  //     a.download = 'Load_$fileName_Slip.png';

  //     // and we click the AnchorElement which downloads the image
  //     a.click();
  //     // finally we remove the AnchorElement
  //     a.remove();
  //     await Future.delayed(Duration(seconds: 5));
  //     deleteFile(fileName_Slip);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> deleteFile(fileName_Slip) async {
  //   String url =
  //       '${MyConstant().domain}/File_Deleted_downloadImg.php?name=$fileName_Slip';

  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       final responseBody = response.body;
  //       if (responseBody == 'File deleted successfully.') {
  //         print('File deleted successfully!');
  //       } else {
  //         print('Failed to delete file: $responseBody');
  //       }
  //     } else {
  //       print('Failed to delete file. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('An error occurred: $e');
  //   }
  // }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
