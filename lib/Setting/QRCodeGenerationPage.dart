import 'dart:html';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html/parser.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'dart:convert';
import 'dart:html' as html;

import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/html.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetRenTal_Model.dart';
import '../PeopleChao/Pays_.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:pdf/pdf.dart' as pw;
import 'package:html/parser.dart' as html;
import 'package:html/dom.dart' as dom;
import 'dart:io';
import 'createDocument.dart';
import 'package:html/dom.dart' as dom;

class QRCodeGenerationPage extends StatefulWidget {
  @override
  _QRCodeGenerationPageState createState() => _QRCodeGenerationPageState();
}

class _QRCodeGenerationPageState extends State<QRCodeGenerationPage> {
  List<RenTalModel> renTalModels = [];
  dynamic pdf;
  // final htmlKey = GlobalKey<QuillHtmlEditorState>();
  var name_1 = 'AA1';
  var name_2 = 'AA1';
  HtmlEditorController controller = HtmlEditorController();

  @override
  void initState() {
    super.initState();

    read_GC_rental();
  }

  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          RenTalModel renTalModel = RenTalModel.fromJson(map);

          setState(() {
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    // print('name>>>>>  $renname');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('QR Code Generation ${renTalModels.length}'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                // width: 1000,
                height: 500,
                child: HtmlEditor(
                  controller: controller, //required
                  htmlEditorOptions: HtmlEditorOptions(
                    inputType: HtmlInputType.text,
                    hint: "Your text here...",
                    //initalText: "text content initial, if any",
                  ),
                  otherOptions: OtherOptions(
                    height: 400,
                  ),
                ),
              ),
            ),
            // Row(
            //   children: [
            //     Container(
            //       width: 585,
            //       height: 500,
            //       // color: Colors.amber,
            //       child: Column(
            //         children: [
            //           QuillHtmlEditor(
            //             editorKey: htmlKey,
            //             height: 500,
            //           ),
            //         ],
            //       ),
            //     ),
            //     // Expanded(
            //     //   flex: 1,
            //     //   child: PdfPreview(
            //     //     build: (format) => pdf.save(),
            //     //     allowSharing: true,
            //     //     allowPrinting: true, canDebug: false,
            //     //     canChangeOrientation: false, canChangePageFormat: false,
            //     //     maxPageWidth: MediaQuery.of(context).size.width * 0.6,
            //     //     // scrollViewDecoration:,
            //     //     initialPageFormat: PdfPageFormat.a4,  adsasadfppppppppppppppppppppppppppppppp558585999999999999999999997777777
            //     //     pdfFileName: "title.pdf",
            //     //   ),
            //     // )
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  color: Colors.amber,
                  child: Text('dsdsd'),
                ),
                onTap: () async {
                  final String? htmlText = await renTalModels[0].html!;

                  dom.Document document = dom.Document.html(htmlText!);

                  // // Find and replace the text within the <p> element
                  document.querySelectorAll('p').forEach((element) {
                    if (element.innerHtml.contains('@S_name')) {
                      element.innerHtml =
                          element.innerHtml.replaceAll('@S_name', 'Trairat');
                    }
                  });

                  document.querySelectorAll('p').forEach((element) {
                    if (element.innerHtml.contains('@L_name')) {
                      element.innerHtml =
                          element.innerHtml.replaceAll('@L_name', 'Ketput');
                    }
                  });

                  document.querySelectorAll('p').forEach((element) {
                    if (element.innerHtml.contains('@Tax_id')) {
                      element.innerHtml = element.innerHtml
                          .replaceAll('@Tax_id', '000123456789');
                    }
                  });

                  String replacedHtmlText = document.outerHtml;

                  print(replacedHtmlText);
                  // saveAsPdf(htmlContent);
                  generatePdf(replacedHtmlText, context);
                  // print('${htmlText}');
                },
              ),
            )
          ],
        ));
  }

  Future<void> saveAsPdf(String htmlContent) async {
    final pdf = pw.Document();
    final font = await rootBundle.load("fonts/MaliBold.ttf");
    final font2 = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");

    // Parse the HTML content
    final document = html.parse(htmlContent);

    // Create a page and add parsed HTML content to it
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.ListView(
            children: document.body!.nodes.map((node) {
              // Render each HTML element
              return pw.Container(
                child: pw.Text(
                  node.text.toString(),
                  style: pw.TextStyle(
                    fontSize: 9,
                    fontWeight: pw.FontWeight.bold,
                    font: pw.Font.ttf(font),
                  ),
                ), // Render text content
              );
            }).toList(),
          );
        },
      ),
    );

    // Save the PDF to the specified file path
    // final file = File(filePath);
    // await file.writeAsBytes(pdf.save());

    final List<int> bytes = await pdf.save();
    final Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.PDF;
    final dir = await FileSaver.instance
        .saveFile("createDocument", data, "pdf", mimeType: type);
  }
}
