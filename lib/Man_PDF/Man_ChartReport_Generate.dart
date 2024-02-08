import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;

import '../Constant/Myconstant.dart';
import '../Model/GetRenTal_Model.dart';
import '../PeopleChao/Bills_.dart';

class Man_ChartReport_GeneratePDF {
  static void man_chartReport_GeneratePDF(
      context, buffer01, buffer02, Page) async {
/////////----------------------------------->
    DateTime date = DateTime.now();
    var Colors_pd = PdfColors.black;
/////////----------------------------------->
    final font = await rootBundle.load("fonts/THSarabunNew.ttf");

    final ttf = pw.Font.ttf(font);
    final pdf = pw.Document();
/////////----------------------------------->
    double font_Size = 11.0;
/////////----------------------------------->
    String? rtname,
        type,
        typex,
        renname,
        bill_name,
        bill_addr,
        bill_tax,
        bill_tel,
        bill_email,
        expbill,
        expbill_name,
        bill_default,
        bill_tser,
        foder,
        bills_name_,
        zone_Subser,
        zone_Subname,
        newValuePDFimg_QR,
        tem_page_ser,
        renTal_name;
/////////----------------------------------->
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';
    renTal_name = preferences.getString('renTalName');
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          RenTalModel renTalModel = RenTalModel.fromJson(map);
          var rtnamex = renTalModel.rtname!.trim();
          var typexs = renTalModel.type!.trim();
          var typexx = renTalModel.typex!.trim();
          var billNamex = renTalModel.bill_name!.trim();
          var billAddrx = renTalModel.bill_addr!.trim();
          var billTaxx = renTalModel.bill_tax!.trim();
          var billTelx = renTalModel.bill_tel!.trim();
          var billEmailx = renTalModel.bill_email!.trim();
          var billDefaultx = renTalModel.bill_default;
          var billTserx = renTalModel.tser;
          var name = renTalModel.pn!.trim();
          var foderx = renTalModel.dbn;
          foder = foderx;
          rtname = rtnamex;
          type = typexs;
          typex = typexx;
          renname = name;
          bill_name = billNamex;
          bill_addr = billAddrx;
          bill_tax = billTaxx;
          bill_tel = billTelx;
          bill_email = billEmailx;
          bill_default = billDefaultx;
          bill_tser = billTserx;
          tem_page_ser = renTalModel.tem_page!.trim();

          if (billDefaultx == 'P') {
            bills_name_ = 'บิลธรรมดา';
          } else {
            bills_name_ = 'ใบกำกับภาษี';
          }
        }
      } else {}
    } catch (e) {}
/////////----------------------------------->
    pw.Widget Header(context) {
      return pw.Column(children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              // color: PdfColors.grey200,
              width: 400,
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                mainAxisSize: pw.MainAxisSize.min,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    '$bill_name',
                    //'$',
                    maxLines: 2,
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 14.00,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                    ),
                  ),
                  pw.Text(
                    (bill_addr == null ||
                            bill_addr.toString() == 'null' ||
                            bill_addr.toString() == '')
                        ? 'ที่อยู่ : -'
                        : 'ที่อยู่ : $bill_addr',
                    maxLines: 3,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      color: Colors_pd,
                      font: ttf,
                    ),
                  ),
                  pw.Text(
                    (bill_tax.toString() == '' || bill_tax == null)
                        ? 'หมายเลขประจำตัวผู้เสียภาษี : 0'
                        : 'หมายเลขประจำตัวผู้เสียภาษี : $bill_tax',
                    // textAlign: pw.TextAlign.justify,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                  pw.Text(
                    'โทรศัพท์ : $bill_tel',
                    textAlign: pw.TextAlign.right,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: font_Size,
                      font: ttf,
                      color: Colors_pd,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 1 * PdfPageFormat.mm),
        pw.SizedBox(height: 1 * PdfPageFormat.mm),
        pw.Divider(
          height: 0.5,
        ),
        pw.SizedBox(height: 4 * PdfPageFormat.mm),
      ]);
    }

    pdf.addPage(pw.MultiPage(
      orientation: pw.PageOrientation.landscape,
      pageFormat: PdfPageFormat.a4.copyWith(
        marginBottom: 4.00,
        marginLeft: 8.00,
        marginRight: 8.00,
        marginTop: 8.00,
      ),
      header: (context) {
        return Header(context);
      },
      build: (context) {
        return [
          pw.SizedBox(
            height: 20,
          ),
          pw.Center(
            child: pw.Image(
              pw.MemoryImage(buffer01),
            ),
          ),
          if (buffer02 != '')
            pw.SizedBox(
              height: 30,
            ),
          if (buffer02 != '')
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(buffer02),
              ),
            ),
        ];
      },
      footer: (context) {
        return pw.Column(
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: pw.Align(
                    alignment: pw.Alignment.bottomLeft,
                    child: pw.Text(
                      'พิมพ์เมื่อ : $date',
                      // textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 7.00,
                        font: ttf,
                        color: Colors_pd,
                        // fontWeight: pw.FontWeight.bold
                      ),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: pw.Align(
                    alignment: pw.Alignment.bottomRight,
                    child: pw.Text(
                      'หน้าที่ ${context.pageNumber} / ${context.pagesCount} ',
                      // textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 7.00,
                        font: ttf,
                        color: Colors_pd,
                        // fontWeight: pw.FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    ));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPdfgen_Bills(
              doc: pdf,
              nameBills: 'Dashboard Report Generate To PDF Page - $Page'),
        ));
  }
}
