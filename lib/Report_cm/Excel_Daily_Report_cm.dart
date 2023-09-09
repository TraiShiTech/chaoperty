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

class Excgen_DailyReport_cm {
  static void exportExcel_DailyReport_cm(
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      Value_Report,
      _TransReBillModels,
      TransReBillModels,
      renTal_name,
      Value_selectDate,
      zoneModels,
      expModels,
      Value_Chang_Zone_Daily) async {
    //'=SUMIFS(H5:H${indextotol + 5 - 1},B5:B${indextotol + 5 - 1},"${int.parse(zoneModels[index].ser!)}",C5:C${indextotol + 5 - 1},"<>ล็อคเสียบ")'
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.pageSetup.topMargin = 1;
    sheet.pageSetup.bottomMargin = 1;
    sheet.pageSetup.leftMargin = 1;
    sheet.pageSetup.rightMargin = 1;
    var nFormat = NumberFormat("#,##0.00", "en_US");
    double calculateTotalValue_Daily_Cm(index_exp) {
      double totalValue = 0.0;
      for (int index1 = 0; index1 < _TransReBillModels.length; index1++) {
        double valueToAdd = TransReBillModels[index1].fold(
          0.0,
          (previousValue, element) =>
              previousValue +
              (element.expser.toString() ==
                          expModels[index_exp].ser.toString() &&
                      element.total.toString() != '' &&
                      element.total != null
                  ? double.parse(element.total!)
                  : 0),
        );
        totalValue += valueToAdd;
      }
      return totalValue;
    }

    List<String> columns = [];

// Add column names from A to Z
    for (int i = 0; i < 26; i++) {
      columns.add(String.fromCharCode(65 + i)); // A-Z
    }

// Add column names from A to Z followed by A to Z (AA to AZ)
    for (int i = 0; i < 26; i++) {
      for (int j = 0; j < 26; j++) {
        columns.add(String.fromCharCode(65 + i) +
            String.fromCharCode(65 + j)); // A-Z followed by A-Z (AA-AZ)
      }
    }

//     //Adding a picture
//     final ByteData bytes_image = await rootBundle.load('images/LOGO.png');
//     final Uint8List image = bytes_image.buffer
//         .asUint8List(bytes_image.offsetInBytes, bytes_image.lengthInBytes);
// // Adding an image.
//     sheet.pictures.addStream(1, 1, image);
//     final x.Picture picture = sheet.pictures[0];

// // Re-size an image
//     picture.height = 200;
//     picture.width = 200;

// // rotate an image.
//     picture.rotation = 100;

// // Flip an image.
//     picture.horizontalFlip = true;
    x.Style globalStyle = workbook.styles.add('style');
    globalStyle.fontName = 'Angsana New';
    globalStyle.numberFormat = '_(\$* #,##0_)';
    globalStyle.fontSize = 17;
    globalStyle.backColorRgb = Color(0xFFF5F7FA);

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
    globalStyle222.hAlign = x.HAlignType.left;
    ////////////-------------------------------------------------------->
    x.Style globalStyle220 = workbook.styles.add('style220');
    globalStyle220.backColorRgb = Color(0xC7F5F7FA);
    globalStyle220.numberFormat = '_(\* #,##0.00_)';
    globalStyle220.fontSize = 12;
    globalStyle220.numberFormat;
    globalStyle220.hAlign = x.HAlignType.left;
    globalStyle220.fontColorRgb = Color.fromARGB(255, 179, 37, 37);

    x.Style globalStyle2220 = workbook.styles.add('style2220');
    globalStyle2220.backColorRgb = Color(0xC7E1E2E6);
    globalStyle2220.numberFormat = '_(\* #,##0.00_)';
    globalStyle2220.numberFormat;
    globalStyle2220.fontSize = 12;
    globalStyle2220.hAlign = x.HAlignType.left;
    globalStyle2220.fontColorRgb = Color.fromARGB(255, 179, 37, 37);

    x.Style globalStyle3 = workbook.styles.add('style3');
    globalStyle3.backColorRgb = Color(0xFF729DD6);
    globalStyle3.borders.bottom.colorRgb = Colors.black;
    globalStyle3.fontName = 'Angsana New';
    globalStyle3.fontSize = 15;
    globalStyle3.hAlign = x.HAlignType.center;
    globalStyle3.borders;

    x.Style globalStyle33 = workbook.styles.add('style33');
    globalStyle33.backColorRgb = Color(0xFF627C9E);
    globalStyle33.fontName = 'Angsana New';
    globalStyle33.fontSize = 15;
    globalStyle33.hAlign = x.HAlignType.center;
    globalStyle33.borders;

    x.Style globalStyle4 = workbook.styles.add('style4');
    globalStyle4.backColorRgb = Color(0xFFDA97AD);
    globalStyle4.hAlign = x.HAlignType.center;
    globalStyle4.fontName = 'Angsana New';
    globalStyle4.fontSize = 15;
    globalStyle4.borders;

    x.Style globalStyle44 = workbook.styles.add('style44');
    globalStyle44.backColorRgb = Color(0xFF9C5B7A);
    globalStyle44.fontName = 'Angsana New';
    globalStyle44.hAlign = x.HAlignType.center;
    globalStyle44.fontSize = 15;
    globalStyle44.borders;

    x.Style globalStyle5 = workbook.styles.add('style5');
    globalStyle5.backColorRgb = Color(0xFF84BD89);
    globalStyle5.fontName = 'Angsana New';
    globalStyle5.hAlign = x.HAlignType.center;
    globalStyle5.fontSize = 15;
    globalStyle5.borders;

    x.Style globalStyle55 = workbook.styles.add('style55');
    globalStyle55.backColorRgb = Color(0xFF6B8D6D);
    globalStyle55.fontName = 'Angsana New';
    globalStyle55.hAlign = x.HAlignType.center;
    globalStyle55.fontSize = 15;
    globalStyle55.borders;

    x.Style globalStyle6 = workbook.styles.add('style6');
    globalStyle6.backColorRgb = Color(0xFFE9BFA3);
    globalStyle6.fontName = 'Angsana New';
    globalStyle6.hAlign = x.HAlignType.center;
    globalStyle6.fontSize = 15;
    globalStyle6.borders;

    x.Style globalStyle66 = workbook.styles.add('style66');
    globalStyle66.backColorRgb = Color(0xFFBD9B84);
    globalStyle66.fontName = 'Angsana New';
    globalStyle55.hAlign = x.HAlignType.center;
    globalStyle66.fontSize = 15;
    globalStyle66.borders;

    x.Style globalStyle7 = workbook.styles.add('style7');
    globalStyle7.backColorRgb = Color.fromARGB(255, 230, 199, 163);
    globalStyle7.fontName = 'Angsana New';
    globalStyle7.numberFormat = '_(\* #,##0.00_)';
    globalStyle7.hAlign = x.HAlignType.center;
    globalStyle7.fontSize = 15;
    globalStyle7.bold = true;
    globalStyle7.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle77 = workbook.styles.add('style77');
    globalStyle77.backColorRgb = Color(0xFFD4E6A3);
    globalStyle77.fontName = 'Angsana New';
    globalStyle77.numberFormat = '_(\* #,##0.00_)';
    globalStyle77.hAlign = x.HAlignType.center;
    globalStyle77.fontSize = 15;
    globalStyle77.bold = true;
    // globalStyle77.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle8 = workbook.styles.add('style8');
    globalStyle8.backColorRgb = Color(0xC7F5F7FA);
    globalStyle8.fontName = 'Angsana New';
    globalStyle8.numberFormat = '_(\* #,##0.00_)';
    globalStyle8.hAlign = x.HAlignType.center;
    globalStyle8.fontSize = 15;
    // globalStyle8.bold = true;
    // globalStyle8.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle88 = workbook.styles.add('style88');
    globalStyle88.backColorRgb = Color(0xC7E1E2E6);
    globalStyle88.fontName = 'Angsana New';
    globalStyle88.numberFormat = '_(\* #,##0.00_)';
    globalStyle88.hAlign = x.HAlignType.center;
    globalStyle88.fontSize = 15;
    // globalStyle88.bold = true;
    // globalStyle88.fontColorRgb = Color(0xFFC52611);

    sheet.getRangeByName('A1').cellStyle = globalStyle;
    sheet.getRangeByName('B1').cellStyle = globalStyle;
    sheet.getRangeByName('C1').cellStyle = globalStyle;
    sheet.getRangeByName('D1').cellStyle = globalStyle;
    sheet.getRangeByName('E1').cellStyle = globalStyle;
    sheet.getRangeByName('F1').cellStyle = globalStyle;
    sheet.getRangeByName('G1').cellStyle = globalStyle;
    sheet.getRangeByName('H1').cellStyle = globalStyle;
    sheet.getRangeByName('I1').cellStyle = globalStyle;
    sheet.getRangeByName('J1').cellStyle = globalStyle;
    sheet.getRangeByName('K1').cellStyle = globalStyle;
    sheet.getRangeByName('K1').cellStyle = globalStyle;
    sheet.getRangeByName('L1').cellStyle = globalStyle;
    sheet.getRangeByName('M1').cellStyle = globalStyle;
    // sheet.getRangeByName('N1').cellStyle = globalStyle;
    // sheet.getRangeByName('O1').cellStyle = globalStyle;
    // sheet.getRangeByName('P1').cellStyle = globalStyle;
    // sheet.getRangeByName('Q1').cellStyle = globalStyle;
    // sheet.getRangeByName('R1').cellStyle = globalStyle;
    // sheet.getRangeByName('S1').cellStyle = globalStyle;
    // sheet.getRangeByName('T1').cellStyle = globalStyle;
    final x.Range range = sheet.getRangeByName('E1');
    range.setText('รายงานประจำวัน (${renTal_name})');
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password

    sheet.getRangeByName('A2').cellStyle = globalStyle;
    sheet.getRangeByName('B2').cellStyle = globalStyle;
    sheet.getRangeByName('C2').cellStyle = globalStyle;
    sheet.getRangeByName('D2').cellStyle = globalStyle;
    sheet.getRangeByName('E2').cellStyle = globalStyle;
    sheet.getRangeByName('F2').cellStyle = globalStyle;
    sheet.getRangeByName('G2').cellStyle = globalStyle;
    sheet.getRangeByName('H2').cellStyle = globalStyle;
    sheet.getRangeByName('I2').cellStyle = globalStyle;
    sheet.getRangeByName('J2').cellStyle = globalStyle;
    sheet.getRangeByName('L2').cellStyle = globalStyle;
    sheet.getRangeByName('M2').cellStyle = globalStyle;
    // sheet.getRangeByName('N2').cellStyle = globalStyle;
    // sheet.getRangeByName('O2').cellStyle = globalStyle;
    // sheet.getRangeByName('P2').cellStyle = globalStyle;
    // sheet.getRangeByName('Q2').cellStyle = globalStyle;
    // sheet.getRangeByName('R2').cellStyle = globalStyle;
    // sheet.getRangeByName('S2').cellStyle = globalStyle;
    // sheet.getRangeByName('T2').cellStyle = globalStyle;
    sheet.getRangeByName('A2').setText('โซน :${Value_Chang_Zone_Daily}');
    sheet
        .getRangeByName('${columns[expModels.length + 7]}2')
        .setText('วันที่ : ${Value_selectDate}');
    sheet.getRangeByName('A2').cellStyle = globalStyle;
    sheet.getRangeByName('K2').cellStyle = globalStyle;

    sheet.getRangeByName('A3').cellStyle = globalStyle33;
    sheet.getRangeByName('B3').cellStyle = globalStyle33;
    sheet.getRangeByName('C3').cellStyle = globalStyle33;
    sheet.getRangeByName('D3').cellStyle = globalStyle33;
    sheet.getRangeByName('E3').cellStyle = globalStyle33;
    sheet.getRangeByName('F3').cellStyle = globalStyle44;
    sheet.getRangeByName('G3').cellStyle = globalStyle44;
    sheet.getRangeByName('H3').cellStyle = globalStyle44;
    sheet.getRangeByName('I3').cellStyle = globalStyle44;
    sheet.getRangeByName('J3').cellStyle = globalStyle44;
    sheet.getRangeByName('K3').cellStyle = globalStyle44;
    sheet.getRangeByName('L3').cellStyle = globalStyle55;
    sheet.getRangeByName('M3').cellStyle = globalStyle55;
    // sheet.getRangeByName('N3').cellStyle = globalStyle55;
    // sheet.getRangeByName('O3').cellStyle = globalStyle66;
    // sheet.getRangeByName('P3').cellStyle = globalStyle66;
    // sheet.getRangeByName('Q3').cellStyle = globalStyle66;
    // sheet.getRangeByName('R3').cellStyle = globalStyle66;
    // sheet.getRangeByName('S3').cellStyle = globalStyle66;

    sheet.getRangeByName('A4').cellStyle = globalStyle3;
    sheet.getRangeByName('B4').cellStyle = globalStyle3;
    sheet.getRangeByName('C4').cellStyle = globalStyle3;
    sheet.getRangeByName('D4').cellStyle = globalStyle3;
    sheet.getRangeByName('E4').cellStyle = globalStyle3;
    sheet.getRangeByName('F4').cellStyle = globalStyle4;
    sheet.getRangeByName('G4').cellStyle = globalStyle4;
    sheet.getRangeByName('H4').cellStyle = globalStyle4;
    sheet.getRangeByName('I4').cellStyle = globalStyle4;
    sheet.getRangeByName('J4').cellStyle = globalStyle4;
    sheet.getRangeByName('K4').cellStyle = globalStyle4;
    sheet.getRangeByName('L4').cellStyle = globalStyle4;
    sheet.getRangeByName('M4').cellStyle = globalStyle4;
    // sheet.getRangeByName('N4').cellStyle = globalStyle5;
    // sheet.getRangeByName('O4').cellStyle = globalStyle5;
    // sheet.getRangeByName('P4').cellStyle = globalStyle5;
    // sheet.getRangeByName('Q4').cellStyle = globalStyle6;
    // sheet.getRangeByName('R4').cellStyle = globalStyle6;
    // sheet.getRangeByName('S4').cellStyle = globalStyle6;

    sheet.getRangeByName('A4').columnWidth = 10;
    sheet.getRangeByName('B4').columnWidth = 10;
    sheet.getRangeByName('C4').columnWidth = 10;
    sheet.getRangeByName('D4').columnWidth = 10;
    sheet.getRangeByName('E4').columnWidth = 25;
    sheet.getRangeByName('F4').columnWidth = 18;
    sheet.getRangeByName('G4').columnWidth = 18;
    sheet.getRangeByName('H4').columnWidth = 18;
    sheet.getRangeByName('I4').columnWidth = 18;
    sheet.getRangeByName('J4').columnWidth = 18;
    sheet.getRangeByName('K4').columnWidth = 18;
    sheet.getRangeByName('L4').columnWidth = 18;
    sheet.getRangeByName('M4').columnWidth = 18;
    // sheet.getRangeByName('N4').columnWidth = 18;
    // sheet.getRangeByName('O4').columnWidth = 18;
    // sheet.getRangeByName('P4').columnWidth = 18;
    // sheet.getRangeByName('Q4').columnWidth = 18;
    // sheet.getRangeByName('A3:F3').merge();

    // sheet.getRangeByName('B3:B4').merge();
    // sheet.getRangeByName('C3:C4').merge();
    // sheet.getRangeByName('D3:D4').merge();
    // sheet.getRangeByName('E3:E4').merge();
    // sheet.getRangeByName('F3:F4').merge();
    //////////-------------------------------------------------------------->(หัวข้อ แถวที่3)

    sheet.getRangeByName('G3:M3').merge();
    sheet.getRangeByName('N3:P3').merge();
    // sheet.getRangeByName('O4:P4').merge();
    sheet.getRangeByName('Q3:R3').merge();
    sheet.getRangeByName('S3:T3').merge();
    sheet.getRangeByName('A3').setText('ข้อมูล');

    // sheet.getRangeByName('S4:T4').merge();
    sheet.getRangeByName('A4').rowHeight = 18;
    sheet.getRangeByName('B4').rowHeight = 18;
    sheet.getRangeByName('C4').rowHeight = 18;
    sheet.getRangeByName('D4').rowHeight = 18;
    sheet.getRangeByName('E4').rowHeight = 18;
    sheet.getRangeByName('F4').rowHeight = 18;
    sheet.getRangeByName('G4').rowHeight = 18;
    sheet.getRangeByName('H4').rowHeight = 18;
    sheet.getRangeByName('I4').rowHeight = 18;
    sheet.getRangeByName('J4').rowHeight = 18;
    sheet.getRangeByName('K4').rowHeight = 18;
    sheet.getRangeByName('L4').rowHeight = 18;
    sheet.getRangeByName('M4').rowHeight = 18;

    //////////-------------------------------------------------------------->(หัวข้อ แถวที่4)

    sheet.getRangeByName('A4').setText('เลขที่');
    sheet.getRangeByName('B4').setText('รหัสโซน');
    sheet.getRangeByName('C4').setText('โซน');
    sheet.getRangeByName('D4').setText('รหัสพื้นที่');
    sheet.getRangeByName('E4').setText('ผู้เช่า');
    sheet.getRangeByName('F4').setText('ขนาดพื้นที่ (ต.ร.ม.)');

    for (int index_exp = 0; index_exp < expModels.length; index_exp++) {
      sheet
          .getRangeByName('${columns[6 + index_exp]}4')
          .setText('${expModels[index_exp].expname}');
    }

    sheet.getRangeByName('${columns[expModels.length + 6]}4').setText('ส่วนลด');
    sheet
        .getRangeByName('${columns[expModels.length + 7]}4')
        .setText('รวมยอดเก็บรายวัน');

    //////////-------------------------------------------------------------->(แถวที่5)
    int index1 = 0;
    int indextotol = 0;

    for (var i2 = 0; i2 < _TransReBillModels.length; i2++) {
      var index = index1 * _TransReBillModels.length + i2;

      dynamic numberColor = index % 2 == 0 ? globalStyle22 : globalStyle222;
      dynamic numberColor_s = index % 2 == 0 ? globalStyle220 : globalStyle2220;

      indextotol = indextotol + 1;
      sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('C${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('D${indextotol + 5 - 1}').cellStyle = numberColor;
      sheet.getRangeByName('E${indextotol + 5 - 1}').cellStyle = numberColor;

      sheet.getRangeByName('F${indextotol + 5 - 1}').cellStyle = numberColor;

      for (int index_exp = 0; index_exp < expModels.length; index_exp++) {
        sheet
            .getRangeByName('${columns[6 + index_exp]}${indextotol + 5 - 1}')
            .cellStyle = (double.parse('${TransReBillModels[i2].fold(
                      0.0,
                      (previousValue, element) =>
                          previousValue +
                          (element.expser.toString() ==
                                      expModels[index_exp].ser.toString() &&
                                  element.total.toString() != '' &&
                                  element.total != null &&
                                  element.docno! ==
                                      _TransReBillModels[i2].docno!
                              ? double.parse(element.total!)
                              : 0),
                    ).toString()}') ==
                0.00)
            ? numberColor_s
            : numberColor;
      }

      sheet
          .getRangeByName(
              '${columns[expModels.length + 6]}${indextotol + 5 - 1}')
          .cellStyle = (((_TransReBillModels[i2].total_dis == null)
                  ? double.parse('0.00')
                  : double.parse('${_TransReBillModels[i2].total_bill}') -
                      double.parse('${_TransReBillModels[i2].total_dis}')) ==
              0.00)
          ? numberColor_s
          : numberColor;

      sheet
          .getRangeByName(
              '${columns[expModels.length + 7]}${indextotol + 5 - 1}')
          .cellStyle = (((_TransReBillModels[i2].total_dis == null)
                  ? double.parse('${_TransReBillModels[i2].total_bill}')
                  : double.parse('${_TransReBillModels[i2].total_dis}')) ==
              0.00)
          ? numberColor_s
          : numberColor;

      //////////-------------------------------------------------------------->
      sheet.getRangeByName('A${indextotol + 5 - 1}').setText('${i2 + 1}');

      sheet.getRangeByName('B${indextotol + 5 - 1}').setText(
            (_TransReBillModels[i2].zser == null)
                ? '${_TransReBillModels[i2].zser1}'
                : '${_TransReBillModels[i2].zser}',
          );

      sheet.getRangeByName('C${indextotol + 5 - 1}').setText(
            (_TransReBillModels[i2].znn == null)
                ? '-'
                : ((_TransReBillModels[i2].znn.toString() == ''))
                    ? '${_TransReBillModels[i2].zn}'
                    : '${_TransReBillModels[i2].znn}',
          );

      sheet
          .getRangeByName('D${indextotol + 5 - 1}')
          .setText((_TransReBillModels[i2].ln == null)
              ? '${_TransReBillModels[i2].room_number}'
              //'${_TransReBillModels[index1].room_number}'
              : '${_TransReBillModels[i2].ln}');

      sheet.getRangeByName('E${indextotol + 5 - 1}').setText(
          (_TransReBillModels[i2].cname == null)
              ? '${_TransReBillModels[i2].remark}'
              : '${_TransReBillModels[i2].cname}');

      sheet.getRangeByName('F${indextotol + 5 - 1}').setNumber((double.parse(
          (_TransReBillModels[i2].area == null)
              ? '1'
              : '${_TransReBillModels[i2].area}')));

      for (int index_exp = 0; index_exp < expModels.length; index_exp++)
        sheet
            .getRangeByName('${columns[6 + index_exp]}${indextotol + 5 - 1}')
            .setNumber(double.parse('${TransReBillModels[i2].fold(
                  0.0,
                  (previousValue, element) =>
                      previousValue +
                      (element.expser.toString() ==
                                  expModels[index_exp].ser.toString() &&
                              element.total.toString() != '' &&
                              element.total != null &&
                              element.docno! == _TransReBillModels[i2].docno!
                          ? double.parse(element.total!)
                          : 0),
                ).toString()}'));

      sheet
          .getRangeByName(
              '${columns[expModels.length + 6]}${indextotol + 5 - 1}')
          .setNumber((_TransReBillModels[i2].total_dis == null)
                  ? double.parse('0.00')
                  : double.parse('${_TransReBillModels[i2].total_bill}') -
                      double.parse('${_TransReBillModels[i2].total_dis}')
              // '${_TransReBillModels[i2].total_bill}'
              );
      sheet
          .getRangeByName(
              '${columns[expModels.length + 7]}${indextotol + 5 - 1}')
          .setNumber((_TransReBillModels[i2].total_dis == null)
              ? double.parse('${_TransReBillModels[i2].total_bill}')
              : double.parse('${_TransReBillModels[i2].total_dis}'));

      ////////------------------------------------------------------------------------------------->
    }

    sheet.getRangeByName('E${indextotol + 5 + 0}').setText('เฉพาะล็อคเสียบ : ');
    sheet
        .getRangeByName('E${indextotol + 5 + 1}')
        .setText('เฉพาะล็อคธรรมดา : ');
    sheet.getRangeByName('E${indextotol + 5 + 2}').setText('รวมทั้งหมด : ');
///////////--------------------------------------------------------->
    sheet.getRangeByName('F${indextotol + 5 + 0}').setFormula(
        '=SUMIF(D5:D${indextotol + 5 - 1} , "ล็อคเสียบ" ,F5:F${indextotol + 5 - 1})');
    sheet.getRangeByName('F${indextotol + 5 + 1}').setFormula(
        '=SUMIF(D5:D${indextotol + 5 - 1} , "<>ล็อคเสียบ" ,F5:F${indextotol + 5 - 1})');
    sheet
        .getRangeByName('F${indextotol + 5 + 2}')
        .setFormula('=SUM(F5:F${indextotol + 5 - 1})');

    for (int index_exp = 0; index_exp < expModels.length; index_exp++) {
      sheet
          .getRangeByName('${columns[6 + index_exp]}${indextotol + 5 + 0}')
          .setFormula(
              '=SUMIF(D5:D${indextotol + 5 - 1} , "ล็อคเสียบ" ,${columns[6 + index_exp]}5:${columns[6 + index_exp]}${indextotol + 5 - 1})');
      sheet
          .getRangeByName('${columns[6 + index_exp]}${indextotol + 5 + 1}')
          .setFormula(
              '=SUMIF(D5:D${indextotol + 5 - 1} , "<>ล็อคเสียบ" ,${columns[6 + index_exp]}5:${columns[6 + index_exp]}${indextotol + 5 - 1})');
      sheet
          .getRangeByName('${columns[6 + index_exp]}${indextotol + 5 + 2}')
          .setFormula(
              '=SUM(${columns[6 + index_exp]}5:${columns[6 + index_exp]}${indextotol + 5 - 1})');
    }
///////////--------------------------------------------------------->
    sheet
        .getRangeByName('${columns[expModels.length + 6]}${indextotol + 5 + 0}')
        .setFormula(
            '=SUMIF(D5:D${indextotol + 5 - 1} , "ล็อคเสียบ" ,${columns[expModels.length + 6]}5:${columns[expModels.length + 6]}${indextotol + 5 - 1})');
    sheet
        .getRangeByName('${columns[expModels.length + 6]}${indextotol + 5 + 1}')
        .setFormula(
            '=SUMIF(D5:D${indextotol + 5 - 1} , "<>ล็อคเสียบ" ,${columns[expModels.length + 6]}5:${columns[expModels.length + 6]}${indextotol + 5 - 1})');
    sheet
        .getRangeByName('${columns[expModels.length + 6]}${indextotol + 5 + 2}')
        .setFormula(
            '=SUM(${columns[expModels.length + 6]}5:${columns[expModels.length + 6]}${indextotol + 5 - 1})');
/////////---------------->
    sheet
        .getRangeByName('${columns[expModels.length + 7]}${indextotol + 5 + 0}')
        .setFormula(
            '=SUMIF(D5:D${indextotol + 5 - 1} , "ล็อคเสียบ" ,${columns[expModels.length + 7]}5:${columns[expModels.length + 7]}${indextotol + 5 - 1})');
    sheet
        .getRangeByName('${columns[expModels.length + 7]}${indextotol + 5 + 1}')
        .setFormula(
            '=SUMIF(D5:D${indextotol + 5 - 1} , "<>ล็อคเสียบ" ,${columns[expModels.length + 7]}5:${columns[expModels.length + 7]}${indextotol + 5 - 1})');
    sheet
        .getRangeByName('${columns[expModels.length + 7]}${indextotol + 5 + 2}')
        .setFormula(
            '=SUM(${columns[expModels.length + 7]}5:${columns[expModels.length + 7]}${indextotol + 5 - 1})');
///////////--------------------------------------------------------->
    for (int index_ = 0; index_ < 3; index_++) {
      sheet.getRangeByName('E${indextotol + 5 + index_}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('F${indextotol + 5 + index_}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('G${indextotol + 5 + index_}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('H${indextotol + 5 + index_}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('I${indextotol + 5 + index_}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('J${indextotol + 5 + index_}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('K${indextotol + 5 + index_}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('L${indextotol + 5 + index_}').cellStyle =
          globalStyle7;
      sheet.getRangeByName('M${indextotol + 5 + index_}').cellStyle =
          globalStyle7;
    }

/////////////////////////////////------------------------------------------------>

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          "รายงานประจำวัน(${Value_selectDate})", data, "xlsx",
          mimeType: type);
      log(path);
    } else {
      String path = await FileSaver.instance
          .saveFile("$NameFile_", data, "xlsx", mimeType: type);
      log(path);
    }
  }
}
