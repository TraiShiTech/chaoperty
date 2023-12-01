import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:chaoperty/Setting/createDocument2.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/html.dart';
import '../PeopleChao/Pays_.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:pdf/pdf.dart' as pw;
import 'package:html/parser.dart' as html;
import 'package:html/dom.dart' as dom;
import 'dart:io';
import 'createDocument.dart';

generatePdf(htmlText, context) async {
  final pdf = pw.Document();
  final font = await rootBundle.load("fonts/MaliBold.ttf");
  final font2 = await rootBundle.load("fonts/Sarabun-Medium.ttf");

// Parse the HTML content
  final document = await html.parse(htmlText);

// Create a page and add parsed HTML content to it
  // pdf.addPage(
  //   pw.MultiPage(
  //     pageFormat: pw.PdfPageFormat.a4,
  //     build: (pw.Context context) {
  //       return <pw.Widget>[
  //         pw.ListView(
  //           children: document.body!.nodes.map((node) {
  //             // Render each HTML element
  //             return pw.Container(
  //               child: pw.Text(
  //                 node.text.toString(),
  //                 style: pw.TextStyle(
  //                   fontSize: 9, // Set your desired font size
  //                   fontWeight: pw.FontWeight.bold, // Set font weight if needed
  //                   font: pw.Font.ttf(font),
  //                 ),
  //               ), // Render text content
  //             );
  //           }).toList(),
  //         )
  //       ];
  //     },
  //   ),
  // );

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.ListView(
            children: document.body!.nodes.map((node) {
              // Render each HTML element
              return pw.Container(
                child: pw.Text(
                  node.text.toString(),
                  style: pw.TextStyle(
                    fontSize: 15,
                    // fontWeight: pw.FontWeight.bold,
                    font: pw.Font.ttf(font2),
                  ),
                ), // Render text content
              );
            }).toList(),
          ),
        ];
      },
    ),
  );

  // pdf.addPage(
  //   pw.Page(
  //     build: (pw.Context context) {
  //       return pw.ListView(
  //         children: document.body!.nodes.map((node) {
  //           // Render each HTML element
  //           return pw.Container(
  //             child: pw.Text(
  //               node.text.toString(),
  //               style: pw.TextStyle(
  //                 fontSize: 15,
  //                 // fontWeight: pw.FontWeight.bold,
  //                 font: pw.Font.ttf(font2),
  //               ),
  //             ), // Render text content
  //           );
  //         }).toList(),
  //       );
  //     },
  //   ),
  // );

  createDocument2(context, pdf);
}
// createDocument(htmlText, context) async {
//   final font = await rootBundle.load("fonts/MaliBold.ttf");
//   final font2 = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");

//   final ttf = Font.ttf(font);
//   final ttf2 = Font.ttf(font2);

//   final newpdf = pw.Document();

//   final customFontStyle = TextStyle(
//     font: ttf,
//     fontSize: 14,
//     fontFallback: [ttf2], // Specify font fallback to cover Thai characters
//   );

//   final replacedHtmlText = htmlText
//       .replaceAll(r'&name1', 'trairat')
//       .replaceAll(r'&name2', 'trairat2')
//       .replaceAll(r'&name3', 'trairat3')
//       .replaceAll('👋', 'YourFallbackCharacter')
//       .replaceAll('�', 'xxx');

//   List<pw.Widget> widgets =
//       await HTMLToPdf().convert(replacedHtmlText, defaultFont: ttf);

//   newpdf.addPage(
//     pw.MultiPage(
//       pageFormat: PdfPageFormat.a4,
//       maxPages: 200,
//       build: (context) {
//         return widgets;
//       },
//     ),
//   );
//   createDocument2(context, newpdf);
//   // final List<int> bytes = await newpdf.save();
//   // final Uint8List data = Uint8List.fromList(bytes);
//   // MimeType type = MimeType.PDF;
//   // final dir = await FileSaver.instance
//   //     .saveFile("createDocument", data, "pdf", mimeType: type);
// }
