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

class Excgen_Mon_income_Report {
  static void excgen_Mon_income_Report(
      ser_report,
      context,
      NameFile_,
      renTal_name,
      _verticalGroupValue_NameFile,
      Value_selectDate,
      zoneModels_report,
      zoneModels_report_Sub_zone,
      zoneModeels_report_Ser_Sub_zone,
      _TransReBillModels_GropType,
      _TransReBillModels_GropType_Sub_zone,
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
    globalStyle1.fontSize = 14;
    globalStyle1.bold = true;
    globalStyle1.borders;
    globalStyle1.fontColorRgb = Color.fromARGB(255, 3, 3, 3);

    x.Style globalStyle22 = workbook.styles.add('style22');
    globalStyle22.backColorRgb = Color(0xC7F5F7FA);
    globalStyle22.numberFormat = '_(\* #,##0.00_)';
    globalStyle22.fontSize = 14;
    globalStyle22.fontName = 'Angsana New';
    globalStyle22.numberFormat;
    globalStyle22.hAlign = x.HAlignType.left;
    globalStyle22.bold = false;

    x.Style globalStyle222 = workbook.styles.add('style222');
    globalStyle222.backColorRgb = Color(0xC7E1E2E6);
    globalStyle222.numberFormat = '_(\* #,##0.00_)';
    globalStyle222.fontName = 'Angsana New';
    globalStyle222.fontSize = 14;
    globalStyle222.hAlign = x.HAlignType.left;
    globalStyle22.bold = false;
////////////-------------------------------------------------------->
    x.Style globalStyle220 = workbook.styles.add('style220');
    globalStyle220.backColorRgb = Color(0xC7F5F7FA);
    globalStyle220.numberFormat = '_(\* #,##0.00_)';
    globalStyle220.fontSize = 14;
    globalStyle220.numberFormat;
    globalStyle220.hAlign = x.HAlignType.left;
    globalStyle220.fontColorRgb = Color.fromARGB(255, 179, 37, 37);

    x.Style globalStyle2220 = workbook.styles.add('style2220');
    globalStyle2220.backColorRgb = Color(0xC7E1E2E6);
    globalStyle2220.numberFormat = '_(\* #,##0.00_)';
    globalStyle2220.numberFormat;
    globalStyle2220.fontSize = 14;
    globalStyle2220.hAlign = x.HAlignType.center;
    globalStyle2220.fontColorRgb = Color.fromARGB(255, 179, 37, 37);

    x.Style globalStyle220D = workbook.styles.add('style220D');
    globalStyle220D.backColorRgb = Color(0xC7F5F7FA);
    globalStyle220D.numberFormat = '_(\* #,##0.00_)';
    globalStyle220D.fontSize = 14;
    globalStyle220D.numberFormat;
    globalStyle220D.hAlign = x.HAlignType.center;
    globalStyle220D.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle2220D = workbook.styles.add('style2220D');
    globalStyle2220D.backColorRgb = Color(0xC7E1E2E6);
    globalStyle2220D.numberFormat = '_(\* #,##0.00_)';
    // globalStyle222.numberFormat;
    globalStyle2220D.fontSize = 14;
    globalStyle2220D.hAlign = x.HAlignType.center;
    globalStyle2220D.fontColorRgb = Color(0xFFC52611);
////////////-------------------------------------------------------->
    x.Style globalStyle7 = workbook.styles.add('style7');
    globalStyle7.backColorRgb = Color.fromARGB(255, 230, 199, 163);
    globalStyle7.fontName = 'Angsana New';
    globalStyle7.numberFormat = '_(\* #,##0.00_)';
    globalStyle7.hAlign = x.HAlignType.center;
    globalStyle7.fontSize = 14;
    globalStyle7.bold = false;
    globalStyle7.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle77 = workbook.styles.add('style77');
    globalStyle7.backColorRgb = Color.fromARGB(255, 230, 199, 163);
    globalStyle77.fontName = 'Angsana New';
    globalStyle77.numberFormat = '_(\* #,##0.00_)';
    globalStyle77.hAlign = x.HAlignType.center;
    globalStyle77.fontSize = 14;
    globalStyle77.bold = false;
    globalStyle77.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle8 = workbook.styles.add('style8');
    globalStyle8.backColorRgb = Color(0xC7F5F7FA);
    globalStyle8.fontName = 'Angsana New';
    globalStyle8.numberFormat = '_(\* #,##0.00_)';
    globalStyle8.hAlign = x.HAlignType.center;
    globalStyle8.fontSize = 14;
    globalStyle8.bold = false;
    // globalStyle8.fontColorRgb = Color(0xFFC52611);

    x.Style globalStyle88 = workbook.styles.add('style88');
    globalStyle88.backColorRgb = Color(0xC7E1E2E6);
    globalStyle88.fontName = 'Angsana New';
    globalStyle88.numberFormat = '_(\* #,##0.00_)';
    globalStyle88.hAlign = x.HAlignType.center;
    globalStyle88.fontSize = 14;
    globalStyle88.bold = true;
    // globalStyle88.fontColorRgb = Color(0xFFC52611);

    globalStyle.backColorRgb = const Color.fromARGB(255, 90, 192, 59);
    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = const Color.fromARGB(255, 147, 223, 124);

    sheet.getRangeByName('A1').cellStyle = globalStyle22;
    sheet.getRangeByName('B1').cellStyle = globalStyle22;
    // sheet.getRangeByName('C1').cellStyle = globalStyle22;
    // sheet.getRangeByName('D1').cellStyle = globalStyle22;
    // sheet.getRangeByName('E1').cellStyle = globalStyle22;
    // sheet.getRangeByName('F1').cellStyle = globalStyle22;
    // sheet.getRangeByName('G1').cellStyle = globalStyle22;

    final x.Range range = sheet.getRangeByName('A1');
    range.setText('รายงาน แสดงรายได้รายเดือน(รายเดือน)');
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password

    sheet.getRangeByName('A2').cellStyle = globalStyle22;
    sheet.getRangeByName('B2').cellStyle = globalStyle22;
    // sheet.getRangeByName('C2').cellStyle = globalStyle22;
    // sheet.getRangeByName('D2').cellStyle = globalStyle22;
    // sheet.getRangeByName('E2').cellStyle = globalStyle22;
    // sheet.getRangeByName('F2').cellStyle = globalStyle22;
    // sheet.getRangeByName('G2').cellStyle = globalStyle22;

    sheet.getRangeByName('A2').setText('${renTal_name}');
    sheet.getRangeByName('B2').setText('เดือน: ${Value_selectDate}');

    globalStyle2.hAlign = x.HAlignType.center;
    sheet.getRangeByName('A2').cellStyle = globalStyle22;
    sheet.getRangeByName('K2').cellStyle = globalStyle22;
    sheet.getRangeByName('A3').cellStyle = globalStyle22;
    sheet.getRangeByName('B3').cellStyle = globalStyle22;
    // sheet.getRangeByName('C3').cellStyle = globalStyle22;
    // sheet.getRangeByName('D3').cellStyle = globalStyle22;
    // sheet.getRangeByName('E3').cellStyle = globalStyle22;
    // sheet.getRangeByName('F3').cellStyle = globalStyle22;
    // sheet.getRangeByName('G3').cellStyle = globalStyle22;

    sheet.getRangeByName('A3').columnWidth = 50;
    sheet.getRangeByName('B3').columnWidth = 25;
    // sheet.getRangeByName('C3').columnWidth = 18;
    // sheet.getRangeByName('D3').columnWidth = 18;
    // sheet.getRangeByName('E3').columnWidth = 18;
    // sheet.getRangeByName('F3').columnWidth = 18;
    // sheet.getRangeByName('G3').columnWidth = 18;

    sheet.getRangeByName('A4').columnWidth = 50;
    sheet.getRangeByName('B4').columnWidth = 25;
    // sheet.getRangeByName('C4').columnWidth = 18;
    // sheet.getRangeByName('D4').columnWidth = 18;
    // sheet.getRangeByName('E4').columnWidth = 18;
    // sheet.getRangeByName('F4').columnWidth = 18;
    // sheet.getRangeByName('G4').columnWidth = 18;

    sheet.getRangeByName('A4').setText('โซน');
    sheet.getRangeByName('B4').setText('ยอด');
    // sheet.getRangeByName('C4').setText('เมตร');
    // sheet.getRangeByName('D4').setText('7คณา');
    // sheet.getRangeByName('E4').setText('บริหาร');
    // sheet.getRangeByName('F4').setText('บ.3');
    // sheet.getRangeByName('G4').setText('บ.4');
    sheet.getRangeByName('A4').cellStyle = globalStyle1;
    sheet.getRangeByName('B4').cellStyle = globalStyle1;
    // sheet.getRangeByName('C4').cellStyle = globalStyle1;
    // sheet.getRangeByName('D4').cellStyle = globalStyle1;
    // sheet.getRangeByName('E4').cellStyle = globalStyle1;
    // sheet.getRangeByName('F4').cellStyle = globalStyle1;
    // sheet.getRangeByName('G4').cellStyle = globalStyle1;

    String calculateTotalBills_Zone(int index1) {
      Set<String> uniqueDocnos = {};
      double totalBills = 0.0;

      totalBills = (_TransReBillModels_GropType.length == 0)
          ? 0.00
          : double.parse((_TransReBillModels_GropType.map((e) =>
              (e.zser == null)
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
                      : 0.toString())).reduce((a, b) => a + b)).toString());

      return totalBills.toString();
    }

    String calculateTotalBills_Zone_Sub(int index1) {
      Set<String> uniqueDocnos = {};
      double totalBills = 0.0;

      totalBills = (_TransReBillModels_GropType_Sub_zone.length == 0)
          ? 0.00
          : double.parse((_TransReBillModels_GropType_Sub_zone.map((e) =>
              (e.zser == null)
                  ? double.parse(
                      e.zser1 == zoneModeels_report_Ser_Sub_zone[index1].ser &&
                              e.expser! == '1' &&
                              e.room_number.toString() != 'ล็อคเสียบ'
                          ? e.total_expname == null || e.total_expname! == ''
                              ? 0.toString()
                              : e.total_expname.toString()
                          : 0.toString())
                  : double.parse(
                      e.zser == zoneModeels_report_Ser_Sub_zone[index1].ser &&
                              e.expser! == '1' &&
                              e.room_number.toString() != 'ล็อคเสียบ'
                          ? e.total_expname == null || e.total_expname! == ''
                              ? 0.toString()
                              : e.total_expname.toString()
                          : 0.toString())).reduce((a, b) => a + b)).toString());
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

    String calculateTotalArea_Zone_Sub(int index1) {
      Set<String> uniqueDocnos = {};
      double totalArea = 0.0;

      for (int index = 0;
          index < _TransReBillModels_GropType_Sub_zone.length;
          index++) {
        if (_TransReBillModels_GropType_Sub_zone[index]
                .room_number
                .toString() !=
            'ล็อคเสียบ') {
          if (!uniqueDocnos
              .contains(_TransReBillModels_GropType_Sub_zone[index].docno)) {
            if (_TransReBillModels_GropType_Sub_zone[index].zser == null) {
              totalArea += double.parse(
                  _TransReBillModels_GropType_Sub_zone[index].zser1 ==
                          zoneModeels_report_Ser_Sub_zone[index1].ser
                      ? _TransReBillModels_GropType_Sub_zone[index].area ==
                                  null ||
                              _TransReBillModels_GropType_Sub_zone[index]
                                      .area! ==
                                  ''
                          ? 1.toString()
                          : _TransReBillModels_GropType_Sub_zone[index]
                              .area
                              .toString()
                      : 0.toString());
            } else {
              totalArea += double.parse(
                  _TransReBillModels_GropType_Sub_zone[index].zser ==
                          zoneModeels_report_Ser_Sub_zone[index1].ser
                      ? _TransReBillModels_GropType_Sub_zone[index].area ==
                                  null ||
                              _TransReBillModels_GropType_Sub_zone[index]
                                      .area! ==
                                  ''
                          ? 1.toString()
                          : _TransReBillModels_GropType_Sub_zone[index]
                              .area
                              .toString()
                      : 0.toString());
            }
            uniqueDocnos
                .add(_TransReBillModels_GropType_Sub_zone[index].docno!);
          }
        }
      }

      return totalArea.toString();
    }

    int indextotol = 1;
    int indextotol_ = 0;

    // for (var index1 = 0; index1 < zoneModels_report.length; index1++) {
    //   if (zoneModels_report[index1].sub_zone.toString() == '0') {
    //     var index = indextotol;
    //     dynamic numberColor = index1 % 2 == 0 ? globalStyle22 : globalStyle222;

    //     dynamic numberColor_s =
    //         index1 % 2 == 0 ? globalStyle220 : globalStyle2220;

    //     dynamic numberColor_ss =
    //         index1 % 2 == 0 ? globalStyle220D : globalStyle2220D;

    //     indextotol = indextotol + 1;
    //     sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = numberColor;

    //     sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = numberColor;
    //     // sheet.getRangeByName('C${indextotol + 5 - 1}').cellStyle = numberColor;

    //     sheet.getRangeByName('A${indextotol + 5 - 1}').columnWidth = 25;
    //     sheet.getRangeByName('B${indextotol + 5 - 1}').columnWidth = 18;
    //     // sheet.getRangeByName('C${indextotol + 5 - 1}').columnWidth = 18;

    //     sheet
    //         .getRangeByName('A${indextotol + 5 - 1}')
    //         .setText(zoneModels_report[index1].zn);
    //   }
    // }

    for (var index3 = 0; index3 < zoneModels_report_Sub_zone.length; index3++) {
      var index = indextotol;
      dynamic numberColor = index3 % 2 == 0 ? globalStyle22 : globalStyle222;

      dynamic numberColor_s =
          index3 % 2 == 0 ? globalStyle220 : globalStyle2220;

      dynamic numberColor_ss =
          index3 % 2 == 0 ? globalStyle220D : globalStyle2220D;

      sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = globalStyle22;
      // sheet.getRangeByName('C${indextotol + 5 - 1}').cellStyle = numberColor;

      sheet.getRangeByName('A${indextotol + 5 - 1}').setText(
            '${zoneModels_report_Sub_zone[index3].zn} ',
          );
      sheet.getRangeByName('B${indextotol + 5 - 1}').setNumber(
            (_TransReBillModels_GropType_Sub_zone.length == 0)
                ? 0.00
                : double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e
                            .zser ==
                        null)
                    ? double.parse(e.sub_zone ==
                                '${zoneModels_report_Sub_zone[index3].ser}' &&
                            e.expser! == '1' &&
                            e.room_number.toString() != 'ล็อคเสียบ'
                        ? e.total_expname == null || e.total_expname! == ''
                            ? 0.toString()
                            : e.total_expname.toString()
                        : 0.toString())
                    : double.parse(e.sub_zone ==
                                '${zoneModels_report_Sub_zone[index3].ser}' &&
                            e.expser! == '1' &&
                            e.room_number.toString() != 'ล็อคเสียบ'
                        ? e.total_expname == null || e.total_expname! == ''
                            ? 0.toString()
                            : e.total_expname.toString()
                        : 0.toString())).reduce((a, b) => a + b)).toString()),
          );
      indextotol = indextotol + 1;
      if ((index3 + 1) == zoneModels_report_Sub_zone.length) {
        sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle =
            globalStyle22;
        sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle =
            globalStyle22;
      }
    }
/////////////////////////////////------------------------------------------------>
    for (var index4 = 0; index4 < 3; index4++) {
      sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = globalStyle8;
      sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = globalStyle8;
      sheet.getRangeByName('A${indextotol + 5 - 1}').setText(
            (index4 == 0)
                ? 'ยอดรวมทั้งหมด'
                : (index4 == 1)
                    ? 'นำส่งเจ็ด'
                    : 'ส่วนต่างนำส่งบริหาร',
          );
      if (index4 == 0) {
        sheet
            .getRangeByName('B${(indextotol + 5 - 1)}')
            .setFormula('=SUM(B5:B${indextotol + 5 - 2})');
      } else {
        sheet.getRangeByName('B${indextotol + 5 - 1}').setNumber(0.00);
      }

      indextotol = indextotol + 1;
      if ((index4 + 1) == zoneModels_report_Sub_zone.length) {
        sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = globalStyle8;
        sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = globalStyle8;
      }
    }
    /////////////////////////////////------------------------------------------------>

    for (var index5 = 0; index5 < 2; index5++) {
      sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = globalStyle22;
      sheet.getRangeByName('A${indextotol + 5 - 1}').setText(
            (index5 == 0) ? 'ค่ารถ' : 'ห้องน้ำ',
          );
      sheet.getRangeByName('B${indextotol + 5 - 1}').setNumber(0.00);
      indextotol = indextotol + 1;
      if ((index5 + 1) == zoneModels_report_Sub_zone.length) {
        sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle =
            globalStyle22;
        sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle =
            globalStyle22;
      }
    }
    /////////////////////////////////------------------------------------------------>

    for (var index6 = 0; index6 < 3; index6++) {
      sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = globalStyle8;
      sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = globalStyle8;
      sheet.getRangeByName('A${indextotol + 5 - 1}').setText(
            (index6 == 0)
                ? 'ยอดรวมทิพย์'
                : (index6 == 1)
                    ? 'นำส่งบริหาร'
                    : 'นำส่งทิพย์',
          );
      sheet.getRangeByName('B${indextotol + 5 - 1}').setNumber(0.00);
      indextotol = indextotol + 1;
      if ((index6 + 1) == zoneModels_report_Sub_zone.length) {
        sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = globalStyle8;
        sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = globalStyle8;
      }
    }
    /////////////////////////////////------------------------------------------------>

    // indextotol = indextotol + 1;
    sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = globalStyle22;
    sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = globalStyle22;
    sheet.getRangeByName('A${indextotol + 5 - 1}').setText(
          'ล็อคเสียบ/ขาจร',
        );
    sheet.getRangeByName('B${indextotol + 5 - 1}').setNumber(
          (_TransReBillModels_GropType_Sub_zone.length == 0)
              ? 0.00
              : double.parse((_TransReBillModels_GropType_Sub_zone.map((e) =>
                  (e.zser == null)
                      ? double.parse(e.expser! == '1' &&
                              e.room_number.toString() == 'ล็อคเสียบ'
                          ? e.total_expname == null || e.total_expname! == ''
                              ? 0.toString()
                              : e.total_expname.toString()
                          : 0.toString())
                      : double.parse(e.expser! == '1' &&
                              e.room_number.toString() == 'ล็อคเสียบ'
                          ? e.total_expname == null || e.total_expname! == ''
                              ? 0.toString()
                              : e.total_expname.toString()
                          : 0.toString())).reduce((a, b) => a + b)).toString()),
        );
    /////////////////////////////////------------------------------------------------>
    for (var index_exp = 0; index_exp < expModels.length; index_exp++) {
      if (expModels[index_exp].ser.toString() != '1') {
        indextotol = indextotol + 1;
        sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle =
            globalStyle22;
        sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle =
            globalStyle22;
        sheet.getRangeByName('A${indextotol + 5 - 1}').setText(
              '${expModels[index_exp].expname}',
            );

        sheet.getRangeByName('B${indextotol + 5 - 1}').setNumber(
            // (_TransReBillModels_GropType_Sub_zone.length == 0)
            //     ? 0.00
            //     :
            double.parse((_TransReBillModels_GropType_Sub_zone.map(
                (e) => (e.zser == null)
                    ? double.parse(e.expser! == '${expModels[index_exp].ser}'
                        ? e.total_expname == null || e.total_expname! == ''
                            ? 0.toString()
                            : e.total_expname.toString()
                        : 0.toString())
                    : double.parse(e.expser! == '${expModels[index_exp].ser}'
                        ? e.total_expname == null || e.total_expname! == ''
                            ? 0.toString()
                            : e.total_expname.toString()
                        : 0.toString())).reduce((a, b) => a + b)).toString()));

        if ((index_exp + 1) == zoneModels_report_Sub_zone.length) {
          sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle =
              globalStyle22;
          sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle =
              globalStyle22;
        }
      }
    }
    /////////////////////////////////------------------------------------------------>

    for (var index7 = 0; index7 < 2; index7++) {
      indextotol = indextotol + 1;
      sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = globalStyle8;
      sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = globalStyle8;
      sheet.getRangeByName('A${indextotol + 5 - 1}').setText(
            (index7 == 0) ? 'ยอดรวมนำส่งบริหาร' : 'นำส่งบริหารทั้งหมด',
          );
      if (index7 == 0) {
        sheet.getRangeByName('B${(indextotol + 5 - 1)}').setFormula(
            '=SUM(B${(indextotol + 5 - 1) - expModels.length}:B${indextotol + 5 - 2})');
      } else {
        sheet.getRangeByName('B${indextotol + 5 - 1}').setNumber(0.00);
      }

      if ((index7 + 1) == zoneModels_report_Sub_zone.length) {
        sheet.getRangeByName('A${indextotol + 5 - 1}').cellStyle = globalStyle8;
        sheet.getRangeByName('B${indextotol + 5 - 1}').cellStyle = globalStyle8;
      }
    }
/////////////////////////////////------------------------------------------------>

    sheet.getRangeByName('A${indextotol + 5}').setText('ยอดรวมรายรับ : ');

    sheet.getRangeByName('B${indextotol + 5}').setNumber(0.00);

    sheet.getRangeByName('A${(indextotol + 5)}').cellStyle = globalStyle7;
    sheet.getRangeByName('B${(indextotol + 5)}').cellStyle = globalStyle7;
    /////////////////////////////////------------------------------------------------>

    indextotol = indextotol + 1;
    sheet.getRangeByName('A${indextotol + 5}').cellStyle = globalStyle8;
    sheet.getRangeByName('B${indextotol + 5}').cellStyle = globalStyle8;
    // sheet.getRangeByName('A${indextotol + 5}').setText('ผู้ตรวจสอบ : ');
    sheet
        .getRangeByName('B${indextotol + 5}')
        .setText('.................................................');
    /////////////////////////////////------------------------------------------------>
    indextotol = indextotol + 1;
    sheet.getRangeByName('A${indextotol + 5}').cellStyle = globalStyle8;
    sheet.getRangeByName('B${indextotol + 5}').cellStyle = globalStyle8;
    // sheet.getRangeByName('A${indextotol + 5}').setText('ผู้ตรวจสอบ : ');
    sheet.getRangeByName('B${indextotol + 5}').setText('ผู้ตรวจสอบ');
    /////////////////////////////////------------------------------------------------>
    indextotol = indextotol + 1;
    sheet.getRangeByName('A${indextotol + 5}').cellStyle = globalStyle22;
    sheet.getRangeByName('B${indextotol + 5}').cellStyle = globalStyle22;
    /////////////////////////////////------------------------------------------------>

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance
          .saveFile('รายงานแสดงรายได้(รายเดือน)', data, "xlsx", mimeType: type);
      log(path);
    } else {
      String path = await FileSaver.instance
          .saveFile("$NameFile_", data, "xlsx", mimeType: type);
      log(path);
    }
  }
}
