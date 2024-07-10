import 'dart:typed_data';
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

//////////รายงานค่าบริการพื้นที่หน้าร้าน
class Excgen_AreaServiceFeeShortReport_Choice {
  static void exportExcel_AreaServiceFeeShortReport_Choice(
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      renTal_name,
      Value_Chang_Zone_Area_servicefee_short,
      Area_servicefee_short,
      Mon_Area_servicefee_short_Mon,
      YE_Area_servicefee_short_Mon) async {
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    DateTime datex = DateTime.now();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'; ////

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.name = 'ค่าบริการพื้นที่หน้าร้าน_Date';
    sheet.pageSetup.topMargin = 1;
    sheet.pageSetup.bottomMargin = 1;
    sheet.pageSetup.leftMargin = 1;
    sheet.pageSetup.rightMargin = 1;

    final x.Worksheet sheet2 =
        workbook.worksheets.addWithName('ค่าบริการพื้นที่หน้าร้าน_Date_Store');
    sheet2.pageSetup.topMargin = 1;
    sheet2.pageSetup.bottomMargin = 1;
    sheet2.pageSetup.leftMargin = 1;
    sheet2.pageSetup.rightMargin = 1;

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
    x.Style globalStyle220 = workbook.styles.add('globalStyle220');
    globalStyle220.backColorRgb = Color(0xC7F5F7FA);
    globalStyle220.numberFormat = '_(\* #,##0.00_)';
    globalStyle220.fontSize = 12;
    globalStyle220.numberFormat;
    globalStyle220.hAlign = x.HAlignType.center;

    x.Style globalStyle2220 = workbook.styles.add('style2220');
    globalStyle2220.backColorRgb = Color(0xC7E1E2E6);
    globalStyle2220.numberFormat = '_(\* #,##0.00_)';
    // globalStyle222.numberFormat;
    globalStyle2220.fontSize = 12;
    globalStyle2220.hAlign = x.HAlignType.center;
    globalStyle2220.fontColorRgb = Color.fromARGB(255, 37, 127, 179);

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
/////////------------------------------------------->sheet-1
    sheet.getRangeByName('A1:F1').merge();
    sheet.getRangeByName('A2:F2').merge();
    sheet.getRangeByName('A3:F3').merge();
    // sheet.getRangeByName('A4:F4').merge();

    sheet.getRangeByName('A1').setText(
          (Value_Chang_Zone_Area_servicefee_short == null)
              ? 'รายงานค่าบริการพื้นที่หน้าร้าน  (กรุณาเลือกโซน)'
              : 'รายงานค่าบริการพื้นที่หน้าร้าน  (โซน : $Value_Chang_Zone_Area_servicefee_short)',
        );
    sheet.getRangeByName('A2').setText(
        'เดือนภาษี ${Mon_Area_servicefee_short_Mon} ${YE_Area_servicefee_short_Mon}');
/////////------------------------------------------->sheet-2
    sheet2.getRangeByName('A1:F1').merge();
    sheet2.getRangeByName('A2:F2').merge();
    sheet2.getRangeByName('A3:F3').merge();
    // sheet.getRangeByName('A4:F4').merge();

    sheet2.getRangeByName('A1').setText(
          (Value_Chang_Zone_Area_servicefee_short == null)
              ? 'รายงานค่าบริการพื้นที่หน้าร้าน  (กรุณาเลือกโซน)'
              : 'รายงานค่าบริการพื้นที่หน้าร้าน  (โซน : $Value_Chang_Zone_Area_servicefee_short)',
        );
    sheet2.getRangeByName('A2').setText(
        'เดือนภาษี ${Mon_Area_servicefee_short_Mon} ${YE_Area_servicefee_short_Mon}');
/////////------------------------------------------->
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password
    for (int index = 0; index < 4; index++) {
      ////
      sheet.getRangeByName('A${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('B${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('C${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('D${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('E${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('F${index + 1}').cellStyle = globalStyle220;

      sheet2.getRangeByName('A${index + 1}').cellStyle = globalStyle220;
      sheet2.getRangeByName('B${index + 1}').cellStyle = globalStyle220;
      sheet2.getRangeByName('C${index + 1}').cellStyle = globalStyle220;
      sheet2.getRangeByName('D${index + 1}').cellStyle = globalStyle220;
      sheet2.getRangeByName('E${index + 1}').cellStyle = globalStyle220;
    }

    globalStyle2.hAlign = x.HAlignType.center;
    sheet.getRangeByName('A4').cellStyle = globalStyle1;
    sheet.getRangeByName('B4').cellStyle = globalStyle1;
    sheet.getRangeByName('C4').cellStyle = globalStyle1;
    sheet.getRangeByName('D4').cellStyle = globalStyle1;
    sheet.getRangeByName('E4').cellStyle = globalStyle1;
    sheet.getRangeByName('F4').cellStyle = globalStyle1;

    // sheet.getRangeByName('G6').cellStyle = globalStyle1;
    // sheet.getRangeByName('H6').cellStyle = globalStyle1;
    // sheet.getRangeByName('I6').cellStyle = globalStyle1;

    sheet.getRangeByName('A4').columnWidth = 10;
    sheet.getRangeByName('B4').columnWidth = 20;
    sheet.getRangeByName('C4').columnWidth = 20;
    sheet.getRangeByName('D4').columnWidth = 25;
    sheet.getRangeByName('E4').columnWidth = 25;
    sheet.getRangeByName('F4').columnWidth = 25;
    sheet.getRangeByName('G4').columnWidth = 18;
    sheet.getRangeByName('H4').columnWidth = 30;
    sheet.getRangeByName('I4').columnWidth = 18;

    sheet.getRangeByName('A4').setText('ลำดับที่');
    sheet.getRangeByName('B4').setText('วันที่');
    sheet.getRangeByName('C4').setText('จำนวนเงินก่อนภาษี');
    sheet.getRangeByName('D4').setText('ภาษีมูลค่าเพิ่ม 7%');
    sheet.getRangeByName('E4').setText('จำนวนเงินรวมทั้งสิ้น');

/////////------------------------------------------->
    sheet2.getRangeByName('A4').cellStyle = globalStyle1;
    sheet2.getRangeByName('B4').cellStyle = globalStyle1;
    sheet2.getRangeByName('C4').cellStyle = globalStyle1;
    sheet2.getRangeByName('D4').cellStyle = globalStyle1;
    sheet2.getRangeByName('E4').cellStyle = globalStyle1;
    sheet2.getRangeByName('F4').cellStyle = globalStyle1;

    // sheet.getRangeByName('G6').cellStyle = globalStyle1;
    // sheet.getRangeByName('H6').cellStyle = globalStyle1;
    // sheet.getRangeByName('I6').cellStyle = globalStyle1;

    sheet2.getRangeByName('A4').columnWidth = 10;
    sheet2.getRangeByName('B4').columnWidth = 20;
    sheet2.getRangeByName('C4').columnWidth = 20;
    sheet2.getRangeByName('D4').columnWidth = 25;
    sheet2.getRangeByName('E4').columnWidth = 25;
    sheet2.getRangeByName('F4').columnWidth = 25;
    sheet2.getRangeByName('G4').columnWidth = 18;
    sheet2.getRangeByName('H4').columnWidth = 30;
    sheet2.getRangeByName('I4').columnWidth = 18;

    sheet2.getRangeByName('A4').setText('ลำดับที่');
    sheet2.getRangeByName('B4').setText('วันที่');
    sheet2.getRangeByName('C4').setText('สาขา');
    sheet2.getRangeByName('D4').setText('จำนวนเงินก่อนภาษี');
    sheet2.getRangeByName('E4').setText('ภาษีมูลค่าเพิ่ม 7%');
    sheet2.getRangeByName('F4').setText('จำนวนเงินรวมทั้งสิ้น');
/////////------------------------------------------->
    int index1 = 0;
    int indextotol = 0;
    List cid_number = [];
    for (int index = 0; index < Area_servicefee_short.length; index++) {
      dynamic numberColor = ((index % 2) == 0) ? globalStyle22 : globalStyle222;
      sheet.getRangeByName('A${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('B${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('C${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('D${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('E${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('F${index + 5}').cellStyle = numberColor;
      // sheet.getRangeByName('G${index + 7}').cellStyle = numberColor;
      // sheet.getRangeByName('H${index + 7}').cellStyle = numberColor;
      // sheet.getRangeByName('I${index + 7}').cellStyle = numberColor;

      sheet.getRangeByName('A${index + 5}').setText('${index + 1}');
      sheet
          .getRangeByName('B${index + 5}')
          .setText('${Area_servicefee_short[index].daterec}');

      sheet.getRangeByName('C${index + 5}').setNumber(
          (Area_servicefee_short[index].sum_all_amt == null)
              ? 0.00
              : double.parse('${Area_servicefee_short[index].sum_all_amt}'));
      sheet.getRangeByName('D${index + 5}').setNumber(
          (Area_servicefee_short[index].sum_all_vat == null)
              ? 0.00
              : double.parse('${Area_servicefee_short[index].sum_all_vat}'));
      sheet.getRangeByName('E${index + 5}').setNumber(
          (Area_servicefee_short[index].total_bill == null)
              ? 0.00
              : double.parse('${Area_servicefee_short[index].total_bill}'));

      indextotol = indextotol + 1;
    }
/////////------------------------------------------->
    for (int index = 0; index < Area_servicefee_short.length; index++) {
      dynamic numberColor = ((index % 2) == 0) ? globalStyle22 : globalStyle222;
      sheet2.getRangeByName('A${index + 5}').cellStyle = numberColor;
      sheet2.getRangeByName('B${index + 5}').cellStyle = numberColor;
      sheet2.getRangeByName('C${index + 5}').cellStyle = numberColor;
      sheet2.getRangeByName('D${index + 5}').cellStyle = numberColor;
      sheet2.getRangeByName('E${index + 5}').cellStyle = numberColor;
      sheet2.getRangeByName('F${index + 5}').cellStyle = numberColor;
      // sheet.getRangeByName('G${index + 7}').cellStyle = numberColor;
      // sheet.getRangeByName('H${index + 7}').cellStyle = numberColor;
      // sheet.getRangeByName('I${index + 7}').cellStyle = numberColor;

      sheet2.getRangeByName('A${index + 5}').setText('${index + 1}');
      sheet2
          .getRangeByName('B${index + 5}')
          .setText('${Area_servicefee_short[index].daterec}');
      sheet2.getRangeByName('C${index + 5}').setText(
          (Area_servicefee_short[index].zn != null)
              ? '${Area_servicefee_short[index].zn}'
              : '${Area_servicefee_short[index].znn}');
      sheet2.getRangeByName('D${index + 5}').setNumber(
          (Area_servicefee_short[index].sum_all_amt == null)
              ? 0.00
              : double.parse('${Area_servicefee_short[index].sum_all_amt}'));
      sheet2.getRangeByName('E${index + 5}').setNumber(
          (Area_servicefee_short[index].sum_all_vat == null)
              ? 0.00
              : double.parse('${Area_servicefee_short[index].sum_all_vat}'));
      sheet2.getRangeByName('F${index + 5}').setNumber(
          (Area_servicefee_short[index].total_bill == null)
              ? 0.00
              : double.parse('${Area_servicefee_short[index].total_bill}'));

      indextotol = indextotol + 1;
    }

/////////---------------------------->
    sheet.getRangeByName('C${indextotol + 5 + 0}').setText('รวมทั้งหมด: ');
    sheet
        .getRangeByName('D${indextotol + 5 + 0}')
        .setFormula('=SUM(D5:D${indextotol + 5 - 1})');
    sheet
        .getRangeByName('E${indextotol + 5 + 0}')
        .setFormula('=SUM(E5:E${indextotol + 5 - 1})');
    sheet
        .getRangeByName('F${indextotol + 5 + 0}')
        .setFormula('=SUM(F5:F${indextotol + 5 - 1})');
    sheet.getRangeByName('C${indextotol + 5 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('D${indextotol + 5 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('E${indextotol + 5 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('F${indextotol + 5 + 0}').cellStyle = globalStyle7;
/////////---------------------------->
    sheet2.getRangeByName('B${indextotol + 5 + 0}').setText('รวมทั้งหมด: ');
    sheet2
        .getRangeByName('C${indextotol + 5 + 0}')
        .setFormula('=SUM(C5:C${indextotol + 5 - 1})');
    sheet2
        .getRangeByName('D${indextotol + 5 + 0}')
        .setFormula('=SUM(D5:D${indextotol + 5 - 1})');
    sheet2
        .getRangeByName('E${indextotol + 5 + 0}')
        .setFormula('=SUM(E5:E${indextotol + 5 - 1})');
    sheet2.getRangeByName('B${indextotol + 5 + 0}').cellStyle = globalStyle7;
    sheet2.getRangeByName('C${indextotol + 5 + 0}').cellStyle = globalStyle7;
    sheet2.getRangeByName('D${indextotol + 5 + 0}').cellStyle = globalStyle7;
    sheet2.getRangeByName('E${indextotol + 5 + 0}').cellStyle = globalStyle7;
/////////---------------------------->

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;
    String path = await FileSaver.instance.saveFile(
        (Value_Chang_Zone_Area_servicefee_short == null)
            ? 'รายงานค่าบริการพื้นที่หน้าร้าน ประจำเดือน ${Mon_Area_servicefee_short_Mon} ${YE_Area_servicefee_short_Mon} (กรุณาเลือกโซน)'
            : 'รายงานค่าบริการพื้นที่หน้าร้าน ประจำเดือน ${Mon_Area_servicefee_short_Mon} ${YE_Area_servicefee_short_Mon} (โซน : $Value_Chang_Zone_Area_servicefee_short)',
        data,
        "xlsx",
        mimeType: type);
    log(path);
    cid_number.clear();
    // if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
    //   String path = await FileSaver.instance.saveFile(
    //       "ผู้เช่า(${Status[Status_ - 1]})(ณ วันที่${day_})", data, "xlsx",
    //       mimeType: type);
    //   log(path);
    // } else {
    //   String path = await FileSaver.instance
    //       .saveFile("$NameFile_", data, "xlsx", mimeType: type);
    //   log(path);
    // }
  }
}
