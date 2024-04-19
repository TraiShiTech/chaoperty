// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

import '../Responsive/responsive.dart';

class WebViewX2ShowPage extends StatefulWidget {
  final id_ser;
  final amt_ser;
  final name_ser;
  const WebViewX2ShowPage({
    Key? key,
    this.id_ser,
    this.amt_ser,
    this.name_ser,
  }) : super(key: key);

  @override
  _WebViewX2ShowPageState createState() => _WebViewX2ShowPageState();
}

class _WebViewX2ShowPageState extends State<WebViewX2ShowPage> {
  late WebViewXController webviewController;
  final initialContent =
      '<div style="display: flex; justify-content: center;"><div style="text-align: center; width: 50%;">    <h2></h2><p></p>  </div></div>';

  Size get screenSize => MediaQuery.of(context).size;

  @override
  void initState() {
    Future.delayed(Duration.zero, () => _showDialog());
    readDataaa2();
    super.initState();
    print(widget.name_ser);
  }

  void dispose() {
    webviewController.dispose();
    super.dispose();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  Future<Null> readDataaa2() async {
    Future.delayed(const Duration(seconds: 1), () {
      webviewController.loadContent(
        //'${webviewModel[0].url.toString().trim()}',
        widget.name_ser, // 'https://www.chaoperty.com',
        SourceType.url,
      );
    }
    );

    // setState(() {
    //   webviewModel = [];
    //   webviewModel == [];
    // });
    // Firebase.initializeApp().then((value) async {
    //   print('initializeApp Success');
    //   await FirebaseFirestore.instance
    //       .collection('WebViewXPage')
    //       // .where('ser', isEqualTo: '${ser}')
    //       .snapshots()
    //       .listen((event) {
    //     print('snapshots = ${event.docs}');
    //     int index = 0;
    //     for (var snapshots in event.docs) {
    //       Map<String, dynamic> map = snapshots.data();
    //       // print('map = $map');
    //       WebviewModel webviewModels = WebviewModel.fromMap(map);

    //       setState(() {
    //         webviewModel.add(webviewModels);
    //       });

    //       // print('nameActivities ////////  = ${webviewModel.length}');

    //       index++;
    //       Future.delayed(const Duration(milliseconds: 100), () {
    //         webviewController.loadContent(
    //           '${webviewModel[0].url.toString().trim()}',
    //           // 'https://www.medcannabis.go.th/activity/%E0%B8%84%E0%B8%B3%E0%B9%81%E0%B8%99%E0%B8%B0%E0%B8%99%E0%B8%B3%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%83%E0%B8%8A%E0%B9%89%E0%B8%81%E0%B8%B1%E0%B8%8D%E0%B8%8A%E0%B8%B2%E0%B8%97%E0%B8%B2%E0%B8%87%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%81%E0%B8%9E%E0%B8%97%E0%B8%A2%E0%B9%8C%20%E0%B8%89%E0%B8%9A%E0%B8%B1%E0%B8%9A%E0%B8%9B%E0%B8%A3%E0%B8%B1%E0%B8%9A%E0%B8%9B%E0%B8%A3%E0%B8%B8%E0%B8%87%20%E0%B8%84%E0%B8%A3%E0%B8%B1%E0%B9%89%E0%B8%87%E0%B8%97%E0%B8%B5%E0%B9%88%204',
    //           SourceType.url,
    //         );
    //       });
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 0)),
            builder: (context, snapshot) {
              return _buildWebViewX();
            }));
  }

  Widget _buildWebViewX() {
    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: initialContent,
      initialSourceType: SourceType.html,
      // height: screenSize.height / 2,
      // width: min(screenSize.width * 0.8, 1024),
      width: MediaQuery.of(context).size.width,
      height: (!Responsive.isDesktop(context))
          ? MediaQuery.of(context).size.height * 0.75
          : MediaQuery.of(context).size.height * 0.78,
      onWebViewCreated: (controller) {
        webviewController = controller;
      },
      onPageStarted: (src) =>
          debugPrint('A new page has started loading: $src\n'),
      onPageFinished: (src) =>
          debugPrint('The page has finished loading: $src\n'),
      jsContent: const {
        EmbeddedJsContent(
          js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
        ),
        EmbeddedJsContent(
          webJs:
              "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
          mobileJs:
              "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
        ),
      },
      dartCallBacks: {
        DartCallback(
          name: 'TestDartCallback',
          callBack: (msg) {
            print(msg);
          },
        )
      },
      webSpecificParams: const WebSpecificParams(
        printDebugInfo: true,
      ),
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
      ),
      navigationDelegate: (navigation) {
        debugPrint(navigation.content.sourceType.toString());
        return NavigationDecision.navigate;
      },
    );
  }

  Future<void> _goForward() async {
    if (await webviewController.canGoForward()) {
      await webviewController.goForward();
      // showSnackBar('Did go forward', context);
    } else {
      // showSnackBar('Cannot go forward', context);
    }
  }

  Future<void> _goBack() async {
    if (await webviewController.canGoBack()) {
      await webviewController.goBack();
      // showSnackBar('Did go back', context);
    } else {
      // showSnackBar('Cannot go back', context);
    }
  }

  void _reload() {
    webviewController.reload();
  }

  void _toggleIgnore() {
    final ignoring = webviewController.ignoresAllGestures;
    webviewController.setIgnoreAllGestures(!ignoring);
    // showSnackBar('Ignore events = ${!ignoring}', context);
  }

  Future<void> _evalRawJsInGlobalContext() async {
    try {
      final result = await webviewController.evalRawJavascript(
        '2+2',
        inGlobalContext: true,
      );
      // showSnackBar('The result is $result', context);
    } catch (e) {
      // showAlertDialog(
      //   executeJsErrorMessage,
      //   context,
      // );
    }
  }

  Future<void> _callPlatformIndependentJsMethod() async {
    try {
      await webviewController.callJsMethod('testPlatformIndependentMethod', []);
    } catch (e) {
      // showAlertDialog(
      //   executeJsErrorMessage,
      //   context,
      // );
    }
  }

  Future<void> _callPlatformSpecificJsMethod() async {
    try {
      await webviewController
          .callJsMethod('testPlatformSpecificMethod', ['Hi']);
    } catch (e) {
      // showAlertDialog(
      //   executeJsErrorMessage,
      //   context,
      // );
    }
  }

  Future<void> _getWebviewContent() async {
    try {
      final content = await webviewController.getContent();
      // showAlertDialog(content.source, context);
    } catch (e) {
      // showAlertDialog('Failed to execute this task.', context);
    }
  }

  void _setUrl() {
    webviewController.loadContent(
      'https://flutter.dev',
      SourceType.url,
    );
  }

  Widget buildSpace({
    Axis direction = Axis.horizontal,
    double amount = 0.2,
    bool flex = true,
  }) {
    return flex
        ? Flexible(
            child: FractionallySizedBox(
              widthFactor: direction == Axis.horizontal ? amount : null,
              heightFactor: direction == Axis.vertical ? amount : null,
            ),
          )
        : SizedBox(
            width: direction == Axis.horizontal ? amount : null,
            height: direction == Axis.vertical ? amount : null,
          );
  }

  List<Widget> _buildButtons() {
    return [
      buildSpace(direction: Axis.vertical, flex: false, amount: 20.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Expanded(child: TextButton(onPressed: _goBack, child: Text('Back'))),
          // buildSpace(amount: 12, flex: false),
          // Expanded(
          //     child: TextButton(onPressed: _goForward, child: Text('Forward'))),
          // buildSpace(amount: 12, flex: false),
          Expanded(
              child: Column(
            children: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _reload,
              ),
              Text('Reload')
            ],
          )
              //  TextButton(onPressed: _reload, child: Text('Reload '))
              ),
        ],
      ),
      // buildSpace(direction: Axis.vertical, flex: false, amount: 20.0),
      // TextButton(
      //   child: Text('อ่าน'),
      //   onPressed: () {
      //     webviewController.loadContent(
      //       'https://flutter.dev',
      //       SourceType.url,
      //     );
      //   },
      // ),
    ];
  }
}
