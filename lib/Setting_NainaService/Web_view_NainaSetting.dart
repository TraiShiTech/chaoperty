import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class WebView_NainaSetting extends StatefulWidget {
  const WebView_NainaSetting({super.key});

  @override
  State<WebView_NainaSetting> createState() => _WebView_NainaSettingState();
}

class _WebView_NainaSettingState extends State<WebView_NainaSetting> {
  late WebViewXController webviewController;
  final initialContent =
      '<div style="display: flex; justify-content: center;"><div style="text-align: center; width: 50%;">    <h2></h2><p></p>  </div></div>';

  Size get screenSize => MediaQuery.of(context).size;
  @override
  void initState() {
    Future.delayed(Duration.zero, () => _showDialog());
    readDataaa2();
    super.initState();
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
        // 'https://pay.beamcheckout.com/chaoperty/t0FJ6TOB64',
        'https://nainaservice.com/Setting',
        // 'https://www.dzentric.com/chaoperty_market/PromptPay/index.php?idser=${widget.id_ser}&amtser=${widget.amt_ser}&nameser=${widget.name_ser}',
        SourceType.url,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppbackgroundColor.Abg_Colors,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.black,
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 50.2,
        // toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
          ),
        ),
        elevation: 0,
        backgroundColor: AppBarColors.hexColor,
        title: Text(
          'ตั้งค่าพื้นที่ - Nainaservic',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white,
              fontWeight:
                  (Responsive.isDesktop(context)) ? FontWeight.bold : null,
              fontSize: (Responsive.isDesktop(context)) ? null : 12,
              fontFamily: FontWeight_.Fonts_T),
        ),
      ),
      body: WebViewX(
        key: const ValueKey('webviewx'),
        initialContent: initialContent,
        initialSourceType: SourceType.html,
        // height: screenSize.height / 2,
        // width: min(screenSize.width * 0.8, 1024),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
      ),
    );
  }
}
