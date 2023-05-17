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

class Excgen_ExpenseReport_cm {
  static void exportExcel_ExpenseReport_cm(
      context, NameFile_, _verticalGroupValue_NameFile, Value_Report) async {
    // PinCode_, NameFile_, _verticalGroupValue_NameFile
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    x.Style globalStyle = workbook.styles.add('style');
    globalStyle.fontName = 'Angsana New';
    globalStyle.numberFormat = '_(\$* #,##0_)';
    globalStyle.fontSize = 20;

    globalStyle.backColorRgb = const Color.fromARGB(255, 90, 192, 59);
    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = const Color.fromARGB(255, 147, 223, 124);
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
    final x.Range range = sheet.getRangeByName('E1');
    range.setText('รายงานรายจ่าย');
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password

    sheet.getRangeByName('A2').cellStyle = globalStyle2;
    sheet.getRangeByName('B2').cellStyle = globalStyle2;
    sheet.getRangeByName('C2').cellStyle = globalStyle2;
    sheet.getRangeByName('D2').cellStyle = globalStyle2;
    sheet.getRangeByName('E2').cellStyle = globalStyle2;
    sheet.getRangeByName('F2').cellStyle = globalStyle2;
    sheet.getRangeByName('G2').cellStyle = globalStyle2;
    sheet.getRangeByName('H2').cellStyle = globalStyle2;
    sheet.getRangeByName('I2').cellStyle = globalStyle2;
    sheet.getRangeByName('J2').cellStyle = globalStyle2;
    sheet.getRangeByName('J2').setText(
        'ณ วันที่: ${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');

    sheet.getRangeByName('A3').cellStyle = globalStyle2;
    sheet.getRangeByName('B3').cellStyle = globalStyle2;
    sheet.getRangeByName('C3').cellStyle = globalStyle2;
    sheet.getRangeByName('D3').cellStyle = globalStyle2;
    sheet.getRangeByName('E3').cellStyle = globalStyle2;
    sheet.getRangeByName('F3').cellStyle = globalStyle2;
    sheet.getRangeByName('G3').cellStyle = globalStyle2;
    sheet.getRangeByName('H3').cellStyle = globalStyle2;
    sheet.getRangeByName('I3').cellStyle = globalStyle2;
    sheet.getRangeByName('J3').cellStyle = globalStyle2;
    sheet.getRangeByName('A3').setText('ลำดับ');
    sheet.getRangeByName('B3').setText('ชื่อผู้ติดต่อ');
    sheet.getRangeByName('C3').setText('ชื่อร้านค้า');
    sheet.getRangeByName('D3').setText('โซนพื้นที่');
    sheet.getRangeByName('E3').setText('รหัสพื้นที่');
    sheet.getRangeByName('F3').setText('ขนาดพื้นที่(ต.ร.ม.)');
    sheet.getRangeByName('G3').setText('ระยะเวลาการเช่า');
    sheet.getRangeByName('H3').setText('วันเริ่มสัญญา');
    sheet.getRangeByName('I3').setText('วันสิ้นสุดสัญญา');
    sheet.getRangeByName('J3').setText('สถานะ');
    final double width = 15;

    for (var i = 0; i < 10; i++) {
      print('customerAndAreaModels[i].ser ////-----> ${i}');
      sheet.getRangeByName('A${i + 4}').setText('$i');
      sheet.getRangeByName('B${i + 4}').setText('$i');
      sheet.getRangeByName('C${i + 4}').setText('$i');
      sheet.getRangeByName('D${i + 4}').setText('$i');
      sheet.getRangeByName('E${i + 4}').setText('$i');
      sheet.getRangeByName('F${i + 4}').setText('$i');
      sheet.getRangeByName('G${i + 4}').setText('');
      sheet.getRangeByName('H${i + 4}').setText('');
      sheet.getRangeByName('I${i + 4}').setText('');
      sheet.getRangeByName('J${i + 4}').setText('');
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          "รายงานรายจ่าย(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
          data,
          "xlsx",
          mimeType: type);
      log(path);
    } else {
      String path = await FileSaver.instance
          .saveFile("$NameFile_", data, "xlsx", mimeType: type);
      log(path);
    }
  }
}
