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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as x;
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;

class Excgen_DailyReport_category_cm {
  static void excgen_DailyReport_category_cm(
      context,
      NameFile_,
      renTal_name,
      _verticalGroupValue_NameFile,
      Value_selectDate,
      zoneModels_report,
      _TransReBillModels_GropType,
      expModels) async {
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.pageSetup.topMargin = 1;
    sheet.pageSetup.bottomMargin = 1;
    sheet.pageSetup.leftMargin = 1;
    sheet.pageSetup.rightMargin = 1;

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
    globalStyle2220.hAlign = x.HAlignType.center;
    globalStyle2220.fontColorRgb = Color.fromARGB(255, 179, 37, 37);

    x.Style globalStyle220D = workbook.styles.add('style220D');
    globalStyle220D.backColorRgb = Color(0xC7F5F7FA);
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

    sheet.getRangeByName('A1').cellStyle = globalStyle22;
    sheet.getRangeByName('B1').cellStyle = globalStyle22;
    sheet.getRangeByName('C1').cellStyle = globalStyle22;
    sheet.getRangeByName('D1').cellStyle = globalStyle22;
    sheet.getRangeByName('E1').cellStyle = globalStyle22;
    sheet.getRangeByName('F1').cellStyle = globalStyle22;
    sheet.getRangeByName('G1').cellStyle = globalStyle22;

    final x.Range range = sheet.getRangeByName('D1');
    range.setText('รายงาน รายรับรายวันแยกตามประเภท');
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

    sheet.getRangeByName('A2').setText('${renTal_name}');
    sheet.getRangeByName('G2').setText('ณ วันที่: ${Value_selectDate}');

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

    sheet.getRangeByName('A3').columnWidth = 18;
    sheet.getRangeByName('B3').columnWidth = 18;
    sheet.getRangeByName('C3').columnWidth = 18;
    sheet.getRangeByName('D3').columnWidth = 18;
    sheet.getRangeByName('E3').columnWidth = 18;
    sheet.getRangeByName('F3').columnWidth = 18;
    sheet.getRangeByName('G3').columnWidth = 18;

    sheet.getRangeByName('A4').cellStyle = globalStyle1;
    sheet.getRangeByName('B4').cellStyle = globalStyle1;
    sheet.getRangeByName('C4').cellStyle = globalStyle1;
    sheet.getRangeByName('D4').cellStyle = globalStyle1;
    sheet.getRangeByName('E4').cellStyle = globalStyle1;
    sheet.getRangeByName('F4').cellStyle = globalStyle1;
    sheet.getRangeByName('G4').cellStyle = globalStyle1;
    // sheet.getRangeByName('H4').cellStyle = globalStyle1;
    // sheet.getRangeByName('I4').cellStyle = globalStyle1;
    // sheet.getRangeByName('J4').cellStyle = globalStyle1;
    // sheet.getRangeByName('K4').cellStyle = globalStyle1;
    // sheet.getRangeByName('L4').cellStyle = globalStyle1;
    // sheet.getRangeByName('M4').cellStyle = globalStyle1;
    // sheet.getRangeByName('N4').cellStyle = globalStyle1;
    // sheet.getRangeByName('O4').cellStyle = globalStyle1;

    sheet.getRangeByName('A4').columnWidth = 18;
    sheet.getRangeByName('B4').columnWidth = 18;
    sheet.getRangeByName('C4').columnWidth = 18;
    sheet.getRangeByName('D4').columnWidth = 18;
    sheet.getRangeByName('E4').columnWidth = 18;
    sheet.getRangeByName('F4').columnWidth = 18;
    sheet.getRangeByName('G4').columnWidth = 18;

    sheet.getRangeByName('A4').setText('โซน');
    sheet.getRangeByName('B4').setText('ยอด');
    sheet.getRangeByName('C4').setText('เมตร');
    sheet.getRangeByName('D4').setText('7คณา');
    sheet.getRangeByName('E4').setText('บริหาร');
    sheet.getRangeByName('F4').setText('บ.3');
    sheet.getRangeByName('G4').setText('บ.4');

    String calculateTotalBills_Zone(int index1) {
      Set<String> uniqueDocnos = {};
      double totalBills = 0.0;

      for (int index = 0; index < _TransReBillModels_GropType.length; index++) {
        if (_TransReBillModels_GropType[index].room_number.toString() !=
            'ล็อคเสียบ') {
          if (!uniqueDocnos
              .contains(_TransReBillModels_GropType[index].docno)) {
            if (_TransReBillModels_GropType[index].zser == null) {
              totalBills += double.parse(_TransReBillModels_GropType[index]
                          .zser1 ==
                      zoneModels_report[index1].ser
                  ? _TransReBillModels_GropType[index].total_expname == null ||
                          _TransReBillModels_GropType[index].total_expname! ==
                              ''
                      ? 0.toString()
                      : _TransReBillModels_GropType[index]
                          .total_expname
                          .toString()
                  : 0.toString());
            } else {
              totalBills += double.parse(_TransReBillModels_GropType[index]
                          .zser ==
                      zoneModels_report[index1].ser
                  ? _TransReBillModels_GropType[index].total_expname == null ||
                          _TransReBillModels_GropType[index].total_expname! ==
                              ''
                      ? 0.toString()
                      : _TransReBillModels_GropType[index]
                          .total_expname
                          .toString()
                  : 0.toString());
            }
            uniqueDocnos.add(_TransReBillModels_GropType[index].docno!);
          }
        }
      }

      return totalBills.toString();
    }

    String calculateTotalArea_Zone(int index1) {
      Set<String> uniqueDocnos = {};
      double totalArea = 0.0;

      for (int index = 0; index < _TransReBillModels_GropType.length; index++) {
        if (_TransReBillModels_GropType[index].room_number.toString() !=
            'ล็อคเสียบ') {
          if (!uniqueDocnos
              .contains(_TransReBillModels_GropType[index].docno)) {
            if (_TransReBillModels_GropType[index].zser == null) {
              totalArea += double.parse(
                  _TransReBillModels_GropType[index].zser1 ==
                          zoneModels_report[index1].ser
                      ? _TransReBillModels_GropType[index].area == null ||
                              _TransReBillModels_GropType[index].area! == ''
                          ? 1.toString()
                          : _TransReBillModels_GropType[index].area.toString()
                      : 0.toString());
            } else {
              totalArea += double.parse(
                  _TransReBillModels_GropType[index].zser ==
                          zoneModels_report[index1].ser
                      ? _TransReBillModels_GropType[index].area == null ||
                              _TransReBillModels_GropType[index].area! == ''
                          ? 1.toString()
                          : _TransReBillModels_GropType[index].area.toString()
                      : 0.toString());
            }
            uniqueDocnos.add(_TransReBillModels_GropType[index].docno!);
          }
        }
      }

      return totalArea.toString();
    }

    int indextotol = 0;
    int indextotol_ = 0;

    for (var index1 = 0; index1 < zoneModels_report.length; index1++) {
      var index = indextotol;
      dynamic numberColor = index1 % 2 == 0 ? globalStyle22 : globalStyle222;

      dynamic numberColor_s =
          index1 % 2 == 0 ? globalStyle220 : globalStyle2220;

      dynamic numberColor_ss =
          index1 % 2 == 0 ? globalStyle220D : globalStyle2220D;

      indextotol = indextotol + 1;
      sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = numberColor;

      sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = ((double.parse(
                  (_TransReBillModels_GropType.map((e) => (e.zser == null)
                      ? double.parse(e.zser1 == zoneModels_report[index1].ser &&
                              e.expser! == '1' &&
                              e.room_number.toString() != 'ล็อคเสียบ'
                          ? e.total_expname == null || e.total_expname! == ''
                              ? 0.toString()
                              : e.total_expname.toString()
                          : 0.toString())
                      : double.parse(e.zser == zoneModels_report[index1].ser &&
                              e.expser! == '1' &&
                              e.room_number.toString() != 'ล็อคเสียบ'
                          ? e.total_expname == null || e.total_expname! == ''
                              ? 0.toString()
                              : e.total_expname.toString()
                          : 0.toString())).reduce(
                      (a, b) => a + b)).toString())) ==
              0.00)
          ? numberColor_s
          : numberColor;
      sheet.getRangeByName('C${indextotol + 5 - 1}').cellStyle =
          (double.parse(calculateTotalArea_Zone(index1)!) == 0.00)
              ? numberColor_s
              : numberColor;

      sheet.getRangeByName('D${indextotol + 5 - 1}').cellStyle =
          (((zoneModels_report[index1].jon! == '1' &&
                          zoneModels_report[index1].jon_book! == '1')
                      ? (double.parse(calculateTotalBills_Zone(index1)!) -
                          (double.parse(calculateTotalArea_Zone(index1)!) *
                              double.parse('${zoneModels_report[index1].b_2}')))
                      : double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_1}')) ==
                  0.00)
              ? numberColor_s
              : numberColor;

      sheet.getRangeByName('E${indextotol + 5 - 1}').cellStyle =
          ((double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_2}')) ==
                  0.00)
              ? numberColor_s
              : numberColor;

      sheet.getRangeByName('F${indextotol + 5 - 1}').cellStyle =
          (((zoneModels_report[index1].jon! == '1' &&
                          zoneModels_report[index1].jon_book! == '3')
                      ? (double.parse(calculateTotalBills_Zone(index1)!) -
                          (double.parse(calculateTotalArea_Zone(index1)!) *
                              double.parse('${zoneModels_report[index1].b_2}')))
                      : double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_3}')) ==
                  0.00)
              ? numberColor_s
              : numberColor;
      sheet.getRangeByName('G${indextotol + 5 - 1}').cellStyle =
          (((zoneModels_report[index1].jon! == '1' &&
                          zoneModels_report[index1].jon_book! == '4')
                      ? (double.parse(calculateTotalBills_Zone(index1)!) -
                          (double.parse(calculateTotalArea_Zone(index1)!) *
                              double.parse('${zoneModels_report[index1].b_2}')))
                      : double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_4}')) ==
                  0.00)
              ? numberColor_s
              : numberColor;

      sheet.getRangeByName('A${indextotol + 5 - 1}').columnWidth = 25;
      sheet.getRangeByName('B${indextotol + 5 - 1}').columnWidth = 18;
      sheet.getRangeByName('C${indextotol + 5 - 1}').columnWidth = 18;
      sheet.getRangeByName('D${indextotol + 5 - 1}').columnWidth = 18;
      sheet.getRangeByName('E${indextotol + 5 - 1}').columnWidth = 18;
      sheet.getRangeByName('F${indextotol + 5 - 1}').columnWidth = 18;
      sheet.getRangeByName('G${indextotol + 5 - 1}').columnWidth = 18;
      // sheet.getRangeByName('O${indextotol + 5 - 1}').cellStyle =
      //     (ser_dis != 0) ? numberColor : numberColor_s;

      sheet
          .getRangeByName('A${indextotol + 5 - 1}')
          .setText(zoneModels_report[index1].zn);

      sheet.getRangeByName('B${indextotol + 5 - 1}').setNumber(double.parse(
          (_TransReBillModels_GropType.map((e) => (e.zser == null)
              ? double.parse(e.zser1 == zoneModels_report[index1].ser &&
                      e.expser! == '1' &&
                      e.room_number.toString() != 'ล็อคเสียบ'
                  ? e.total_expname == null || e.total_expname! == ''
                      ? 0.toString()
                      : e.total_expname.toString()
                  : 0.toString())
              : double.parse(e.zser == zoneModels_report[index1].ser &&
                      e.expser! == '1' &&
                      e.room_number.toString() != 'ล็อคเสียบ'
                  ? e.total_expname == null || e.total_expname! == ''
                      ? 0.toString()
                      : e.total_expname.toString()
                  : 0.toString())).reduce((a, b) => a + b)).toString()));

      sheet
          .getRangeByName('C${indextotol + 5 - 1}')
          .setNumber(double.parse(calculateTotalArea_Zone(index1)!));

      sheet.getRangeByName('D${indextotol + 5 - 1}').setNumber(
          (zoneModels_report[index1].jon! == '1' &&
                  zoneModels_report[index1].jon_book! == '1')
              ? double.parse(calculateTotalBills_Zone(index1)!) -
                  ((double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_1}')) +
                      (double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_2}')) +
                      (double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_3}')) +
                      (double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_4}')))
              : double.parse(calculateTotalArea_Zone(index1)!) *
                  double.parse('${zoneModels_report[index1].b_1}'));

      sheet.getRangeByName('E${indextotol + 5 - 1}').setNumber(
          (zoneModels_report[index1].jon! == '1' &&
                  zoneModels_report[index1].jon_book! == '2')
              ? double.parse(calculateTotalBills_Zone(index1)!) -
                  ((double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_1}')) +
                      (double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_2}')) +
                      (double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_3}')) +
                      (double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_4}')))
              : double.parse(calculateTotalArea_Zone(index1)!) *
                  double.parse('${zoneModels_report[index1].b_2}'));

      sheet.getRangeByName('F${indextotol + 5 - 1}').setNumber(
          (zoneModels_report[index1].jon! == '1' &&
                  zoneModels_report[index1].jon_book! == '3')
              ? double.parse(calculateTotalBills_Zone(index1)!) -
                  ((double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_1}')) +
                      (double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_2}')) +
                      (double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_3}')) +
                      (double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_4}')))
              : double.parse(calculateTotalArea_Zone(index1)!) *
                  double.parse('${zoneModels_report[index1].b_3}'));

      sheet.getRangeByName('G${indextotol + 5 - 1}').setNumber(
          (zoneModels_report[index1].jon! == '1' &&
                  zoneModels_report[index1].jon_book! == '4')
              ? double.parse(calculateTotalBills_Zone(index1)!) -
                  ((double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_1}')) +
                      (double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_2}')) +
                      (double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_3}')) +
                      (double.parse(calculateTotalArea_Zone(index1)!) *
                          double.parse('${zoneModels_report[index1].b_4}')))
              : double.parse(calculateTotalArea_Zone(index1)!) *
                  double.parse('${zoneModels_report[index1].b_4}'));

      for (int index = 0; index < 1; index++) {
        indextotol = indextotol + 1;
        sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = numberColor;
        sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = numberColor;
        sheet.getRangeByName('C${indextotol + 5 - 1}').cellStyle = numberColor;
        sheet.getRangeByName('D${indextotol + 5 - 1}').cellStyle = numberColor;
        sheet.getRangeByName('E${indextotol + 5 - 1}').cellStyle =
            (double.parse((_TransReBillModels_GropType.map((e) => (e.zser ==
                            null)
                        ? double.parse(e.zser1 ==
                                    zoneModels_report[index1].ser &&
                                e.expser! == '1' &&
                                e.room_number.toString() == 'ล็อคเสียบ'
                            ? e.total_expname == null || e.total_expname! == ''
                                ? 0.toString()
                                : e.total_expname.toString()
                            : 0.toString())
                        : double.parse(e.zser ==
                                    zoneModels_report[index1].ser &&
                                e.expser! == '1' &&
                                e.room_number.toString() == 'ล็อคเสียบ'
                            ? e.total_expname == null || e.total_expname! == ''
                                ? 0.toString()
                                : e.total_expname.toString()
                            : 0.toString())).reduce(
                        (a, b) => a + b)).toString()) ==
                    0.00)
                ? numberColor_s
                : numberColor;
        sheet.getRangeByName('F${indextotol + 5 - 1}').cellStyle = numberColor;
        sheet.getRangeByName('G${indextotol + 5 - 1}').cellStyle = numberColor;
        sheet
            .getRangeByName('A${indextotol + 5 - 1}')
            .setText('- ล็อคเสียบ/ขาจร');

        sheet.getRangeByName('E${indextotol + 5 - 1}').setNumber(double.parse(
            (_TransReBillModels_GropType.map((e) => (e.zser == null)
                ? double.parse(e.zser1 == zoneModels_report[index1].ser &&
                        e.expser! == '1' &&
                        e.room_number.toString() == 'ล็อคเสียบ'
                    ? e.total_expname == null || e.total_expname! == ''
                        ? 0.toString()
                        : e.total_expname.toString()
                    : 0.toString())
                : double.parse(e.zser == zoneModels_report[index1].ser &&
                        e.expser! == '1' &&
                        e.room_number.toString() == 'ล็อคเสียบ'
                    ? e.total_expname == null || e.total_expname! == ''
                        ? 0.toString()
                        : e.total_expname.toString()
                    : 0.toString())).reduce((a, b) => a + b)).toString()));
      }

      for (int index_exp = 0; index_exp < expModels.length; index_exp++) {
        indextotol = indextotol + 1;
        sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = numberColor;
        sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = numberColor;
        sheet.getRangeByName('C${indextotol + 5 - 1}').cellStyle = numberColor;
        sheet.getRangeByName('D${indextotol + 5 - 1}').cellStyle = numberColor;
        sheet.getRangeByName('E${indextotol + 5 - 1}').cellStyle =
            (double.parse((_TransReBillModels_GropType.map((e) => (e.zser ==
                            null)
                        ? double.parse(e.zser1 ==
                                    zoneModels_report[index1].ser &&
                                e.expser! == '${expModels[index_exp].ser}'
                            ? e.total_expname == null || e.total_expname! == ''
                                ? 0.toString()
                                : e.total_expname.toString()
                            : 0.toString())
                        : double.parse(e.zser ==
                                    zoneModels_report[index1].ser &&
                                e.expser! == '${expModels[index_exp].ser}'
                            ? e.total_expname == null || e.total_expname! == ''
                                ? 0.toString()
                                : e.total_expname.toString()
                            : 0.toString())).reduce(
                        (a, b) => a + b)).toString()) ==
                    0.00)
                ? numberColor_s
                : numberColor;
        sheet.getRangeByName('F${indextotol + 5 - 1}').cellStyle = numberColor;
        sheet.getRangeByName('G${indextotol + 5 - 1}').cellStyle = numberColor;
        sheet
            .getRangeByName('A${indextotol + 5 - 1}')
            .setText('- ${expModels[index_exp].expname}');

        sheet.getRangeByName('E${indextotol + 5 - 1}').setNumber(double.parse(
            (_TransReBillModels_GropType.map((e) => (e.zser == null)
                ? double.parse(e.zser1 == zoneModels_report[index1].ser &&
                        e.expser! == '${expModels[index_exp].ser}'
                    ? e.total_expname == null || e.total_expname! == ''
                        ? 0.toString()
                        : e.total_expname.toString()
                    : 0.toString())
                : double.parse(e.zser == zoneModels_report[index1].ser &&
                        e.expser! == '${expModels[index_exp].ser}'
                    ? e.total_expname == null || e.total_expname! == ''
                        ? 0.toString()
                        : e.total_expname.toString()
                    : 0.toString())).reduce((a, b) => a + b)).toString()));
      }
    }

/////////////////////////////////------------------------------------------------>

    sheet.getRangeByName('A${indextotol + 5}').setText('รวมทั้งหมด: ');

    sheet
        .getRangeByName('B${(indextotol + 5)}')
        .setFormula('=SUM(B5:B${indextotol + 5 - 1})');
    sheet
        .getRangeByName('C${(indextotol + 5)}')
        .setFormula('=SUM(C5:C${indextotol + 5 - 1})');
    sheet
        .getRangeByName('D${(indextotol + 5)}')
        .setFormula('=SUM(D5:D${indextotol + 5 - 1})');
    sheet
        .getRangeByName('E${(indextotol + 5)}')
        .setFormula('=SUM(E5:E${indextotol + 5 - 1})');
    sheet
        .getRangeByName('F${(indextotol + 5)}')
        .setFormula('=SUM(F5:F${indextotol + 5 - 1})');

    sheet
        .getRangeByName('G${(indextotol + 5)}')
        .setFormula('=SUM(G5:G${indextotol + 5 - 1})');

    sheet.getRangeByName('A${(indextotol + 5)}').cellStyle = globalStyle7;
    sheet.getRangeByName('B${(indextotol + 5)}').cellStyle = globalStyle7;
    sheet.getRangeByName('C${(indextotol + 5)}').cellStyle = globalStyle7;
    sheet.getRangeByName('D${(indextotol + 5)}').cellStyle = globalStyle7;
    sheet.getRangeByName('E${(indextotol + 5)}').cellStyle = globalStyle7;
    sheet.getRangeByName('F${(indextotol + 5)}').cellStyle = globalStyle7;
    sheet.getRangeByName('G${(indextotol + 5)}').cellStyle = globalStyle7;
/////////////////--------------------------------------------------->
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          "รายงานรายรับรายวันแยกตามประเภท(${Value_selectDate})", data, "xlsx",
          mimeType: type);
      log(path);
    } else {
      String path = await FileSaver.instance
          .saveFile("$NameFile_", data, "xlsx", mimeType: type);
      log(path);
    }
  }
}
