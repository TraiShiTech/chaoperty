import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as x;
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'Report_Screen.dart';

class Excgen_InvoiceReport {
  static void exportExcel_InvoiceReport(
      Type_search_Invoice,
      context,
      NameFile_,
      Ser_BodySta1,
      _verticalGroupValue_NameFile,
      Value_Report,
      InvoiceModels,
      _InvoiceHistoryModels,
      expModels,
      renTal_name,
      zone_name_Invoice_Mon,
      zone_name_Invoice_Daily,
      YE_Invoice_Mon,
      Mon_Invoice_Mon,
      Value_InvoiceDate_Daily) async {
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.pageSetup.topMargin = 1;
    sheet.pageSetup.bottomMargin = 1;
    sheet.pageSetup.leftMargin = 1;
    sheet.pageSetup.rightMargin = 1;

    x.Style globalStyle = workbook.styles.add('style');
    globalStyle.fontName = 'Angsana New';
    globalStyle.numberFormat = '_(\$* #,##0_)';
    globalStyle.fontSize = 20;

    x.Style globalStyle1 = workbook.styles.add('style1');
    globalStyle1.backColorRgb = Color(0xFFD4E6A3);
    globalStyle1.fontName = 'Angsana New';
    globalStyle1.numberFormat = '_(\* #,##0.00_)';
    globalStyle1.hAlign = x.HAlignType.center;
    globalStyle1.fontSize = 16;
    globalStyle1.bold = true;
    globalStyle1.borders;
    globalStyle1.fontColorRgb = Color.fromARGB(255, 3, 3, 3);

    x.Style globalStyle22 = workbook.styles.add('style22');
    globalStyle22.backColorRgb = Color(0xC7F5F7FA);
    globalStyle22.numberFormat = '_(\* #,##0.00_)';
    globalStyle22.fontSize = 12;
    globalStyle22.numberFormat;
    globalStyle22.hAlign = x.HAlignType.left;

    x.Style globalStyle222 = workbook.styles.add('style222');
    globalStyle222.backColorRgb = Color(0xC7E1E2E6);
    globalStyle222.numberFormat = '_(\* #,##0.00_)';
    // globalStyle222.numberFormat;
    globalStyle222.fontSize = 12;
    globalStyle222.hAlign = x.HAlignType.center;
////////////-------------------------------------------------------->
    x.Style globalStyle220 = workbook.styles.add('style220');
    globalStyle220.backColorRgb = Color(0xC7F5F7FA);
    globalStyle220.numberFormat = '_(\* #,##0.00_)';
    globalStyle220.fontSize = 12;
    globalStyle220.numberFormat;
    globalStyle220.hAlign = x.HAlignType.center;
    globalStyle220.fontColorRgb = Color.fromARGB(255, 37, 127, 179);

    x.Style globalStyle2220 = workbook.styles.add('style2220');
    globalStyle2220.backColorRgb = Color(0xC7E1E2E6);
    globalStyle2220.numberFormat = '_(\* #,##0.00_)';
    // globalStyle222.numberFormat;
    globalStyle2220.fontSize = 12;
    globalStyle2220.hAlign = x.HAlignType.left;
    globalStyle2220.fontColorRgb = Color.fromARGB(255, 37, 127, 179);

    x.Style globalStyle220D = workbook.styles.add('style220D');
    globalStyle220D.backColorRgb = Color(0xC7E1E2E6);
    globalStyle220D.numberFormat = '_(\* #,##0.00_)';
    globalStyle220D.fontSize = 12;
    globalStyle220D.numberFormat;
    globalStyle220D.hAlign = x.HAlignType.center;
    globalStyle220D.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle2220D = workbook.styles.add('style2220D');
    globalStyle2220D.backColorRgb = Color(0xC7E1E2E6);
    globalStyle2220D.numberFormat = '_(\* #,##0.00_)';
    // globalStyle222.numberFormat;
    globalStyle2220D.fontSize = 12;
    globalStyle2220D.hAlign = x.HAlignType.center;
    globalStyle2220D.fontColorRgb = Color(0xFFC52611);
////////////-------------------------------------------------------->
    x.Style globalStyle7 = workbook.styles.add('style7');
    globalStyle7.backColorRgb = Color.fromARGB(255, 230, 199, 163);
    globalStyle7.fontName = 'Angsana New';
    globalStyle7.numberFormat = '_(\* #,##0.00_)';
    globalStyle7.hAlign = x.HAlignType.center;
    globalStyle7.fontSize = 15;
    globalStyle7.bold = true;
    globalStyle7.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle77 = workbook.styles.add('style77');
    globalStyle7.backColorRgb = Color.fromARGB(255, 230, 199, 163);
    globalStyle77.fontName = 'Angsana New';
    globalStyle77.numberFormat = '_(\* #,##0.00_)';
    globalStyle77.hAlign = x.HAlignType.center;
    globalStyle77.fontSize = 15;
    globalStyle77.bold = true;
    globalStyle77.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle8 = workbook.styles.add('style8');
    globalStyle8.backColorRgb = Color(0xC7F5F7FA);
    globalStyle8.fontName = 'Angsana New';
    globalStyle8.numberFormat = '_(\* #,##0.00_)';
    globalStyle8.hAlign = x.HAlignType.center;
    globalStyle8.fontSize = 15;
    globalStyle8.bold = true;
    // globalStyle8.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle88 = workbook.styles.add('style88');
    globalStyle88.backColorRgb = Color(0xC7E1E2E6);
    globalStyle88.fontName = 'Angsana New';
    globalStyle88.numberFormat = '_(\* #,##0.00_)';
    globalStyle88.hAlign = x.HAlignType.center;
    globalStyle88.fontSize = 15;
    globalStyle88.bold = true;
    // globalStyle88.fontColorRgb = Color(0xFFC52611);

    globalStyle.backColorRgb = const Color.fromARGB(255, 90, 192, 59);
    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = const Color.fromARGB(255, 147, 223, 124);
    ;

    sheet.getRangeByName('A1').cellStyle = globalStyle22;
    sheet.getRangeByName('B1').cellStyle = globalStyle22;
    sheet.getRangeByName('C1').cellStyle = globalStyle22;
    sheet.getRangeByName('D1').cellStyle = globalStyle22;
    sheet.getRangeByName('E1').cellStyle = globalStyle22;
    sheet.getRangeByName('F1').cellStyle = globalStyle22;
    sheet.getRangeByName('G1').cellStyle = globalStyle22;
    sheet.getRangeByName('H1').cellStyle = globalStyle22;
    sheet.getRangeByName('I1').cellStyle = globalStyle22;
    sheet.getRangeByName('J1').cellStyle = globalStyle22;
    sheet.getRangeByName('K1').cellStyle = globalStyle22;
    sheet.getRangeByName('L1').cellStyle = globalStyle22;
    sheet.getRangeByName('M1').cellStyle = globalStyle22;
    sheet.getRangeByName('N1').cellStyle = globalStyle22;
    sheet.getRangeByName('O1').cellStyle = globalStyle22;
    final x.Range range = sheet.getRangeByName('E1');

    range.setText(
      (Type_search_Invoice.toString() == 'Mon')
          ? 'รายงานข้อมูลใบแจ้งหนี้/วางบิล รายเดือน ( โซน : $zone_name_Invoice_Mon)'
          : 'รายงานข้อมูลใบแจ้งหนี้/วางบิล รายวัน( โซน : $zone_name_Invoice_Daily)',
    );
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password

    sheet.getRangeByName('A2').cellStyle = globalStyle22;
    sheet.getRangeByName('B2').cellStyle = globalStyle22;
    sheet.getRangeByName('C2').cellStyle = globalStyle22;
    sheet.getRangeByName('D2').cellStyle = globalStyle22;
    sheet.getRangeByName('E2').cellStyle = globalStyle22;
    sheet.getRangeByName('F2').cellStyle = globalStyle22;
    sheet.getRangeByName('G2').cellStyle = globalStyle22;
    sheet.getRangeByName('H2').cellStyle = globalStyle22;
    sheet.getRangeByName('I2').cellStyle = globalStyle22;
    sheet.getRangeByName('J2').cellStyle = globalStyle22;
    sheet.getRangeByName('K2').cellStyle = globalStyle22;

    sheet.getRangeByName('L2').cellStyle = globalStyle22;
    sheet.getRangeByName('M2').cellStyle = globalStyle22;
    sheet.getRangeByName('N2').cellStyle = globalStyle22;
    sheet.getRangeByName('O2').cellStyle = globalStyle22;
    sheet.getRangeByName('A2').setText('${renTal_name}');
    sheet.getRangeByName('I2').setText((Type_search_Invoice.toString() == 'Mon')
        ? 'เดือน : ${Mon_Invoice_Mon} (${YE_Invoice_Mon}) '
        : 'ณ วันที่: ${Value_InvoiceDate_Daily}');

    globalStyle2.hAlign = x.HAlignType.center;
    sheet.getRangeByName('A2').cellStyle = globalStyle22;
    sheet.getRangeByName('K2').cellStyle = globalStyle22;
    sheet.getRangeByName('A3').cellStyle = globalStyle22;
    sheet.getRangeByName('B3').cellStyle = globalStyle22;
    sheet.getRangeByName('C3').cellStyle = globalStyle22;
    sheet.getRangeByName('D3').cellStyle = globalStyle22;
    sheet.getRangeByName('E3').cellStyle = globalStyle22;
    sheet.getRangeByName('F3').cellStyle = globalStyle22;
    sheet.getRangeByName('G3').cellStyle = globalStyle22;
    sheet.getRangeByName('H3').cellStyle = globalStyle22;
    sheet.getRangeByName('I3').cellStyle = globalStyle22;
    sheet.getRangeByName('J3').cellStyle = globalStyle22;
    sheet.getRangeByName('K3').cellStyle = globalStyle22;
    sheet.getRangeByName('L3').cellStyle = globalStyle22;
    sheet.getRangeByName('M3').cellStyle = globalStyle22;
    sheet.getRangeByName('N3').cellStyle = globalStyle22;
    sheet.getRangeByName('O3').cellStyle = globalStyle22;

    sheet.getRangeByName('A3').columnWidth = 30;
    sheet.getRangeByName('B3').columnWidth = 25;
    sheet.getRangeByName('C3').columnWidth = 25;
    sheet.getRangeByName('D3').columnWidth = 25;
    sheet.getRangeByName('E3').columnWidth = 25;
    sheet.getRangeByName('F3').columnWidth = 25;
    sheet.getRangeByName('G3').columnWidth = 25;
    sheet.getRangeByName('H3').columnWidth = 25;
    sheet.getRangeByName('I3').columnWidth = 25;
    sheet.getRangeByName('J3').columnWidth = 25;
    sheet.getRangeByName('K3').columnWidth = 25;
    sheet.getRangeByName('L3').columnWidth = 25;
    sheet.getRangeByName('M3').columnWidth = 25;
    sheet.getRangeByName('N3').columnWidth = 25;
    sheet.getRangeByName('O3').columnWidth = 25;

    sheet.getRangeByName('A4').cellStyle = globalStyle1;
    sheet.getRangeByName('B4').cellStyle = globalStyle1;
    sheet.getRangeByName('C4').cellStyle = globalStyle1;
    sheet.getRangeByName('D4').cellStyle = globalStyle1;
    sheet.getRangeByName('E4').cellStyle = globalStyle1;
    sheet.getRangeByName('F4').cellStyle = globalStyle1;
    sheet.getRangeByName('G4').cellStyle = globalStyle1;
    sheet.getRangeByName('H4').cellStyle = globalStyle1;
    sheet.getRangeByName('I4').cellStyle = globalStyle1;
    sheet.getRangeByName('J4').cellStyle = globalStyle1;
    sheet.getRangeByName('K4').cellStyle = globalStyle1;
    sheet.getRangeByName('L4').cellStyle = globalStyle1;
    sheet.getRangeByName('M4').cellStyle = globalStyle1;
    sheet.getRangeByName('N4').cellStyle = globalStyle1;
    sheet.getRangeByName('O4').cellStyle = globalStyle1;

    sheet.getRangeByName('A4').columnWidth = 30;
    sheet.getRangeByName('B4').columnWidth = 25;
    sheet.getRangeByName('C4').columnWidth = 25;
    sheet.getRangeByName('D4').columnWidth = 25;
    sheet.getRangeByName('E4').columnWidth = 25;
    sheet.getRangeByName('F4').columnWidth = 25;
    sheet.getRangeByName('G4').columnWidth = 25;
    sheet.getRangeByName('H4').columnWidth = 25;
    sheet.getRangeByName('I4').columnWidth = 25;

    sheet.getRangeByName('J4').columnWidth = 25;
    sheet.getRangeByName('K4').columnWidth = 25;
    sheet.getRangeByName('L4').columnWidth = 25;
    sheet.getRangeByName('M4').columnWidth = 25;
    sheet.getRangeByName('N4').columnWidth = 25;
    sheet.getRangeByName('O4').columnWidth = 25;

    // sheet.getRangeByName('O4').columnWidth = 18;
    // sheet.getRangeByName('P4').columnWidth = 18;
    // sheet.getRangeByName('Q4').columnWidth = 18;
    // sheet.getRangeByName('R4').columnWidth = 18;
    // sheet.getRangeByName('S4').columnWidth = 18;
    // sheet.getRangeByName('T4').columnWidth = 18;
    // sheet.getRangeByName('U4').columnWidth = 18;
    // sheet.getRangeByName('V4').columnWidth = 18;
    // sheet.getRangeByName('O4').columnWidth = 18;

    sheet.getRangeByName('A4').setText('เลขที่');
    sheet.getRangeByName('B4').setText('ลำดับ');
    sheet.getRangeByName('C4').setText('เลขสัญญา');
    sheet.getRangeByName('D4').setText('ชื่อผู้เช่า/บริษัท');
    sheet.getRangeByName('E4').setText('รหัสโซน');
    sheet.getRangeByName('F4').setText('โซน');
    sheet.getRangeByName('G4').setText('รหัสพื้นที่');
    sheet.getRangeByName('H4').setText('กำหนดชำระ');
    sheet.getRangeByName('I4').setText('รายการ');
    sheet.getRangeByName('J4').setText('จำนวน');
    sheet.getRangeByName('K4').setText('หน่วย');
    sheet.getRangeByName('L4').setText('Vat');
    sheet.getRangeByName('M4').setText('ราคารวม');
    sheet.getRangeByName('N4').setText('ราคารวม Vat');
    sheet.getRangeByName('O4').setText('ส่วนลด');

    // sheet.getRangeByName('L4').setText('ราคาก่อน Vat');
    // sheet.getRangeByName('M4').setText('ราคารวม Vat');
    // sheet.getRangeByName('N4').setText('ส่วนลด');
    int indextotol = 0;
    int ser_dis = 0;
    String doc_no = '';

    for (var index2 = 0; index2 < _InvoiceHistoryModels.length; index2++) {
      if (doc_no == _InvoiceHistoryModels[index2].docno.toString()) {
        ser_dis = ser_dis + 1;
      } else {
        doc_no = _InvoiceHistoryModels[index2].docno.toString();
        ser_dis = 1;
      }

///////------------------------->
      var matchingItems = InvoiceModels.where((item) =>
          item.docno.toString() ==
              _InvoiceHistoryModels[index2].docno.toString() &&
          ser_dis == 1);

      if (matchingItems.isNotEmpty) {
        indextotol = indextotol + 1;
        matchingItems.forEach((item) {
          sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('C${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('D${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('E${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('F${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('G${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('H${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('I${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('J${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('K${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('L${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('M${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('N${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet.getRangeByName('O${indextotol + 5 - 1}').cellStyle =
              globalStyle2220;
          sheet
              .getRangeByName('A${indextotol + 5 - 1}')
              .setText('${_InvoiceHistoryModels[index2].docno}');
          sheet.getRangeByName('B${indextotol + 5 - 1}').setText('0');
          sheet.getRangeByName('C${indextotol + 5 - 1}').setText(
                '${_InvoiceHistoryModels[index2].cid}',
              );

          sheet.getRangeByName('D${indextotol + 5 - 1}').setText(
                '${_InvoiceHistoryModels[index2].scname}',
              );
          sheet
              .getRangeByName('E${indextotol + 5 - 1}')
              .setText('${_InvoiceHistoryModels[index2].zser}');
          sheet
              .getRangeByName('F${indextotol + 5 - 1}')
              .setText('${_InvoiceHistoryModels[index2].zn}');
          sheet.getRangeByName('G${indextotol + 5 - 1}').setText(
                '${_InvoiceHistoryModels[index2].ln}',
              );
          sheet.getRangeByName('H${indextotol + 5 - 1}').setText(
                '${_InvoiceHistoryModels[index2].date}',
              );

          sheet
              .getRangeByName('I${indextotol + 5 - 1}')
              .setText('ส่วนลดทั้งบิล');
          sheet.getRangeByName('J${indextotol + 5 - 1}').setNumber(0.00);
          sheet.getRangeByName('K${indextotol + 5 - 1}').setNumber(0.00);
          sheet.getRangeByName('L${indextotol + 5 - 1}').setNumber(0.00);
          sheet.getRangeByName('M${indextotol + 5 - 1}').setNumber(0.00);
          sheet.getRangeByName('N${indextotol + 5 - 1}').setNumber(0.00);
          sheet.getRangeByName('O${indextotol + 5 - 1}').setNumber(
              (item.total_dis == null)
                  ? 0.00
                  : double.parse(
                          (item.total_bill == null) ? '0' : item.total_bill!) -
                      double.parse(item.total_dis!));
        });
      }

///////------------------------->

      // dynamic numberColor_s = i1 % 2 == 0 ? globalStyle220 : globalStyle2220;

      indextotol = indextotol + 1;
      sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('C${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('D${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('E${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('F${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('G${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('H${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('I${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('J${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('K${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('L${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('M${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('N${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('O${indextotol + 5 - 1}').cellStyle = globalStyle22;

      sheet
          .getRangeByName('A${indextotol + 5 - 1}')
          .setText('${_InvoiceHistoryModels[index2].docno}');
      sheet.getRangeByName('B${indextotol + 5 - 1}').setText('${ser_dis}');

      sheet.getRangeByName('C${indextotol + 5 - 1}').setText(
            '${_InvoiceHistoryModels[index2].cid}',
          );
      sheet.getRangeByName('D${indextotol + 5 - 1}').setText(
            '${_InvoiceHistoryModels[index2].scname}',
          );
      sheet.getRangeByName('E${indextotol + 5 - 1}').setText(
            '${_InvoiceHistoryModels[index2].zser}',
          );
      sheet.getRangeByName('F${indextotol + 5 - 1}').setText(
            '${_InvoiceHistoryModels[index2].zn}',
          );
      sheet.getRangeByName('G${indextotol + 5 - 1}').setText(
            '${_InvoiceHistoryModels[index2].ln}',
          );
      sheet.getRangeByName('H${indextotol + 5 - 1}').setText(
            '${_InvoiceHistoryModels[index2].date}',
          );
      sheet.getRangeByName('I${indextotol + 5 - 1}').setText(
            '${_InvoiceHistoryModels[index2].descr}',
          );
      sheet.getRangeByName('J${indextotol + 5 - 1}').setNumber(
            (_InvoiceHistoryModels[index2].qty == null)
                ? 0.00
                : double.parse('${_InvoiceHistoryModels[index2].qty}'),
          );
      sheet.getRangeByName('K${indextotol + 5 - 1}').setNumber(
            (_InvoiceHistoryModels[index2].nvalue.toString() != '0')
                ? double.parse('${_InvoiceHistoryModels[index2].pri}')
                : double.parse('${_InvoiceHistoryModels[index2].nvat}'),
          );

      sheet.getRangeByName('L${indextotol + 5 - 1}').setNumber(
            (_InvoiceHistoryModels[index2].vat == null)
                ? 0.00
                : double.parse('${_InvoiceHistoryModels[index2].vat}'),
          );
      sheet.getRangeByName('M${indextotol + 5 - 1}').setNumber(
            (_InvoiceHistoryModels[index2].pvat == null)
                ? 0.00
                : double.parse('${_InvoiceHistoryModels[index2].pvat}'),
          );
      sheet.getRangeByName('N${indextotol + 5 - 1}').setNumber(
            (_InvoiceHistoryModels[index2].amt == null)
                ? 0.00
                : double.parse('${_InvoiceHistoryModels[index2].amt}'),
          );
      sheet.getRangeByName('O${indextotol + 5 - 1}').setNumber(
            0.00,
          );
    }
    sheet.getRangeByName('I${indextotol + 5}').cellStyle = globalStyle7;
    sheet.getRangeByName('J${indextotol + 5}').cellStyle = globalStyle7;
    sheet.getRangeByName('K${indextotol + 5}').cellStyle = globalStyle7;
    sheet.getRangeByName('L${indextotol + 5}').cellStyle = globalStyle7;
    sheet.getRangeByName('M${indextotol + 5}').cellStyle = globalStyle7;
    sheet.getRangeByName('N${indextotol + 5}').cellStyle = globalStyle7;
    sheet.getRangeByName('O${indextotol + 5}').cellStyle = globalStyle7;
    sheet.getRangeByName('I${indextotol + 5}').setText(
          'รวม',
        );

    sheet
        .getRangeByName('J${indextotol + 5}')
        .setFormula('=SUM(J5:J${indextotol + 5 - 1})');
    sheet
        .getRangeByName('K${indextotol + 5}')
        .setFormula('=SUM(K5:K${indextotol + 5 - 1})');
    sheet
        .getRangeByName('L${indextotol + 5}')
        .setFormula('=SUM(L5:L${indextotol + 5 - 1})');
    sheet
        .getRangeByName('M${indextotol + 5}')
        .setFormula('=SUM(M5:M${indextotol + 5 - 1})');
    sheet
        .getRangeByName('N${indextotol + 5}')
        .setFormula('=SUM(N5:N${indextotol + 5 - 1})');
    sheet
        .getRangeByName('O${indextotol + 5}')
        .setFormula('=SUM(O5:O${indextotol + 5 - 1})');

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;
    String path = await FileSaver.instance.saveFile(
        (Type_search_Invoice.toString() == 'Mon')
            ? 'รายงานข้อมูลใบแจ้งหนี้/วางบิล รายเดือน ( โซน : $zone_name_Invoice_Mon)'
            : 'รายงานข้อมูลใบแจ้งหนี้/วางบิล รายวัน ( โซน : $zone_name_Invoice_Daily)',
        data,
        "xlsx",
        mimeType: type);
    log(path);
    // if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
    //   String path = await FileSaver.instance.saveFile(
    //       "รายงานทะเบียนลูกค้า(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
    //       data,
    //       "xlsx",
    //       mimeType: type);
    //   log(path);
    // } else {
    //   String path = await FileSaver.instance
    //       .saveFile("$NameFile_", data, "xlsx", mimeType: type);
    //   log(path);
    // }
  }
}
