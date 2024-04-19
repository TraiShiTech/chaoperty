import 'dart:convert';
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
import '../Report/Report_Screen.dart';

class Excgen_InvoiceOrtorkorReport {
  static void exportExcel_invoiceOrtorkorReport(
      context,
      NameFile_,
      Ser_BodySta1,
      _verticalGroupValue_NameFile,
      Value_Report,
      InvoiceModels,
      _InvoiceModels,
      expModels,
      renTal_name,
      zone_name_Invoice_Mon,
      zone_name_Invoice_Daily,
      YE_Invoice_Mon,
      Mon_Invoice_Mon,
      Value_InvoiceDate_Daily) async {
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    List<String> monthsInThai = [
      'ม.ค.', // January
      'ก.พ.', // February
      'มี.ค.', // March
      'เม.ย.', // April
      'พ.ค.', // May
      'มิ.ย.', // June
      'ก.ค.', // July
      'ส.ค.', // August
      'ก.ย.', // September
      'ต.ค.', // October
      'พ.ย.', // November
      'ธ.ค.', // December
    ];
    DateTime datex = DateTime.now();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    final x.Workbook workbook = x.Workbook();
    List<String> columns = [];

///////-----------------------------> Add column names from A to Z
    for (int i = 0; i < 26; i++) {
      columns.add(String.fromCharCode(65 + i)); // A-Z
    }

///////-----------------------------> Add column names from A to Z followed by A to Z (AA to AZ)
    for (int i = 0; i < 26; i++) {
      for (int j = 0; j < 26; j++) {
        columns.add(String.fromCharCode(65 + i) +
            String.fromCharCode(65 + j)); // A-Z followed by A-Z (AA-AZ)
      }
    }
////////------------------------------>
    Future<String> read_SumGCExpSer(int index, serexp) async {
      String textdata = '${InvoiceModels[index].exp_array}';

      // String textdata2 = await textdata.substring(1, textdata.length - 1);

      try {
        List<dynamic> dataList = json.decode(textdata);

        double amt = dataList
            .whereType<Map<String, dynamic>>()
            .where((element) => element['ser_exp'].toString() == '$serexp')
            .map((element) => double.parse(element['amt_exp'].toString()))
            .fold(0, (prev, wht) => prev + wht);
        return '${nFormat.format(double.parse(amt.toString()))}';
      } catch (e) {
        return '$e';
      }
    }

//////////////////------------------------------------------->
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
    globalStyle222.hAlign = x.HAlignType.left;
////////////-------------------------------------------------------->
    x.Style globalStyle220 = workbook.styles.add('style220');
    globalStyle220.backColorRgb = Color.fromARGB(197, 207, 183, 248);
    globalStyle220.fontName = 'Angsana New';
    globalStyle220.numberFormat = '_(\* #,##0.00_)';
    globalStyle220.hAlign = x.HAlignType.center;
    globalStyle220.fontSize = 16;
    globalStyle220.bold = true;
    globalStyle220.borders;
    globalStyle220.fontColorRgb = Color.fromARGB(255, 3, 3, 3);

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

    sheet.getRangeByName('A1').cellStyle = globalStyle22;
    sheet.getRangeByName('B1').cellStyle = globalStyle22;
    sheet.getRangeByName('C1').cellStyle = globalStyle22;
    sheet.getRangeByName('D1').cellStyle = globalStyle22;
    sheet.getRangeByName('E1').cellStyle = globalStyle22;
    sheet.getRangeByName('F1').cellStyle = globalStyle22;
    sheet.getRangeByName('G1').cellStyle = globalStyle22;
    sheet.getRangeByName('H1').cellStyle = globalStyle22;
    for (int i = 0; i < expModels.length * 2; i++) {
      sheet.getRangeByName('${columns[7 + (i + 1)]}1').cellStyle =
          globalStyle22;
    }
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 1)]}1')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 2)]}1')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 3)]}1')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 4)]}1')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 5)]}1')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 6)]}1')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 7)]}1')
        .cellStyle = globalStyle22;

    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 8)]}1')
        .cellStyle = globalStyle22;

    final x.Range range = sheet.getRangeByName('D1');
    range.setText(
      (zone_name_Invoice_Mon == null)
          ? '$Value_Report (กรุณาเลือกโซน)'
          : '$Value_Report (โซน : ${zone_name_Invoice_Mon})',
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

    for (int i = 0; i < expModels.length * 2; i++) {
      sheet.getRangeByName('${columns[7 + (i + 1)]}2').cellStyle =
          globalStyle22;
    }
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 1)]}2')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 2)]}2')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 3)]}2')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 4)]}2')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 5)]}2')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 6)]}2')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 7)]}2')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 8)]}2')
        .cellStyle = globalStyle22;

    sheet.getRangeByName('A2').setText(
          (Ser_BodySta1 == 1)
              ? 'เดือน : ${monthsInThai[int.parse(Mon_Invoice_Mon!) - 1]} ${int.parse(YE_Invoice_Mon!) + 543}'
              : 'วันที่ : ${DateFormat('dd-MM').format(DateTime.parse('${Value_InvoiceDate_Daily}'))}-${DateTime.parse('${Value_InvoiceDate_Daily}').year + 543}',
        );
    sheet.getRangeByName('A3').setText(
          'ทั้งหมด : ${InvoiceModels.length} รายการ',
        );

    sheet.getRangeByName('A3').cellStyle = globalStyle22;
    sheet.getRangeByName('B3').cellStyle = globalStyle22;
    sheet.getRangeByName('C3').cellStyle = globalStyle22;
    sheet.getRangeByName('D3').cellStyle = globalStyle22;
    sheet.getRangeByName('E3').cellStyle = globalStyle22;
    sheet.getRangeByName('F3').cellStyle = globalStyle22;
    sheet.getRangeByName('G3').cellStyle = globalStyle22;
    sheet.getRangeByName('H3').cellStyle = globalStyle22;
    for (int i = 0; i < expModels.length * 2; i++) {
      sheet.getRangeByName('${columns[7 + (i + 1)]}3').cellStyle =
          globalStyle22;
    }
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 1)]}3')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 2)]}3')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 3)]}3')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 4)]}3')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 5)]}3')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 6)]}3')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 7)]}3')
        .cellStyle = globalStyle22;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 8)]}3')
        .cellStyle = globalStyle22;
    // sheet.getRangeByName('H2').setText(' ข้อมูล ณ วันที่: ${day_}');
    globalStyle2.hAlign = x.HAlignType.center;
    sheet.getRangeByName('A4').cellStyle = globalStyle1;
    sheet.getRangeByName('B4').cellStyle = globalStyle1;
    sheet.getRangeByName('C4').cellStyle = globalStyle1;
    sheet.getRangeByName('D4').cellStyle = globalStyle1;
    sheet.getRangeByName('E4').cellStyle = globalStyle1;
    sheet.getRangeByName('F4').cellStyle = globalStyle1;
    sheet.getRangeByName('G4').cellStyle = globalStyle1;
    sheet.getRangeByName('H4').cellStyle = globalStyle1;
    for (int i = 0; i < expModels.length * 2; i++) {
      sheet.getRangeByName('${columns[7 + (i + 1)]}4').cellStyle =
          globalStyle220;
    }
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 1)]}4')
        .cellStyle = globalStyle1;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 2)]}4')
        .cellStyle = globalStyle1;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 3)]}4')
        .cellStyle = globalStyle1;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 4)]}4')
        .cellStyle = globalStyle1;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 5)]}4')
        .cellStyle = globalStyle1;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 6)]}4')
        .cellStyle = globalStyle1;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 7)]}4')
        .cellStyle = globalStyle1;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 8)]}4')
        .cellStyle = globalStyle1;

    sheet.getRangeByName('A4').columnWidth = 30;
    sheet.getRangeByName('B4').columnWidth = 25;
    sheet.getRangeByName('C4').columnWidth = 25;
    sheet.getRangeByName('D4').columnWidth = 30;
    sheet.getRangeByName('E4').columnWidth = 25;
    sheet.getRangeByName('F4').columnWidth = 25;
    sheet.getRangeByName('G4').columnWidth = 30;
    sheet.getRangeByName('H4').columnWidth = 18;
    for (int i = 0; i < expModels.length * 2; i++) {
      sheet.getRangeByName('${columns[7 + (i + 1)]}4').columnWidth = 18;
    }
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 1)]}4')
        .columnWidth = 18;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 2)]}4')
        .columnWidth = 18;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 3)]}4')
        .columnWidth = 18;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 4)]}4')
        .columnWidth = 18;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 5)]}4')
        .columnWidth = 18;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 6)]}4')
        .columnWidth = 18;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 7)]}4')
        .columnWidth = 25;
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 8)]}4')
        .columnWidth = 25;

    sheet.getRangeByName('A4').setText('บริษัท');
    sheet.getRangeByName('B4').setText('เลขที่ใบแจ้งหนี้');
    sheet.getRangeByName('C4').setText('สถานะ');
    sheet.getRangeByName('D4').setText('วันที่ออกใบแจ้งหนี้');
    sheet.getRangeByName('E4').setText('วันที่ครบกำหนด');

    sheet.getRangeByName('F4').setText(
          'ชื่อลูกค้า',
        );

    sheet.getRangeByName('G4').setText(
          'รอบการเช่า',
        );

    sheet.getRangeByName('H4').setText('ล็อค ');
    for (int i = 0; i < expModels.length; i++) {
      sheet.getRangeByName('${columns[7 + (i + 1 + i)]}4').setText(
            'QTY',
          );
      sheet.getRangeByName('${columns[7 + (i + 2 + i)]}4').setText(
            '${expModels[i].expname}',
          );
    }

    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 1)]}4')
        .setText(
          'ภาษีมูลค่าเพิ่ม',
        );
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 2)]}4')
        .setText(
          'ภาษีหัก ณ ที่จ่าย',
        );
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 3)]}4')
        .setText(
          'ส่วนลด',
        );
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 4)]}4')
        .setText(
          'ยอดรวม',
        );
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 5)]}4')
        .setText(
          'ยอดสุทธิ',
        );
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 6)]}4')
        .setText(
          'หมายเหตุ',
        );
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 7)]}4')
        .setText(
          'โซน',
        );
    sheet
        .getRangeByName(
            '${columns[7 + (int.parse('${expModels.length}') * 2 + 8)]}4')
        .setText(
          'เลขที่รับชำระ',
        );

    int index1 = 0;
    int indextotol = 0;
    List cid_number = [];
    for (int index = 0; index < InvoiceModels.length; index++) {
      indextotol = indextotol + 1;

      dynamic numberColor =
          ((indextotol % 2) == 0) ? globalStyle22 : globalStyle222;

      sheet.getRangeByName('A${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('B${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('C${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('D${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('E${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('F${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('G${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('H${index + 5}').cellStyle = numberColor;
      for (int i = 0; i < expModels.length * 2; i++) {
        sheet.getRangeByName('${columns[7 + (i + 1)]}${index + 5}').cellStyle =
            numberColor;
      }
      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 1)]}${index + 5}')
          .cellStyle = numberColor;
      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 2)]}${index + 5}')
          .cellStyle = numberColor;
      sheet
          .getRangeByName( 
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 3)]}${index + 5}')
          .cellStyle = numberColor;
      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 4)]}${index + 5}')
          .cellStyle = numberColor;
      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 5)]}${index + 5}')
          .cellStyle = numberColor;
      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 6)]}${index + 5}')
          .cellStyle = numberColor;
      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 7)]}${index + 5}')
          .cellStyle = numberColor;
      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 8)]}${index + 5}')
          .cellStyle = numberColor;
///////////-------------------------------------------------->
      sheet.getRangeByName('A${index + 5}').setText(
            '${renTal_name}',
          );
      sheet.getRangeByName('B${index + 5}').setText(
            '${InvoiceModels[index].inv}',
          );
      // sheet.getRangeByName('B${index + 5}').setText(
      //       '${InvoiceModels[index].docno}',
      //     );
      sheet.getRangeByName('C${index + 5}').setText(
            '-',
          );
      sheet.getRangeByName('D${index + 5}').setText(
            '${DateFormat('dd-MM').format(DateTime.parse('${InvoiceModels[index].daterec}'))}-${DateTime.parse('${InvoiceModels[index].daterec}').year + 543}',
          );
      sheet.getRangeByName('E${index + 5}').setText(
            '${DateFormat('dd-MM').format(DateTime.parse('${InvoiceModels[index].date}'))}-${DateTime.parse('${InvoiceModels[index].date}').year + 543}',
          );

      sheet.getRangeByName('F${index + 5}').setText(
            '${InvoiceModels[index].scname}',
          );

      sheet.getRangeByName('G${index + 5}').setText(
            (InvoiceModels[index].date == null ||
                    InvoiceModels[index].date.toString() == '')
                ? '${InvoiceModels[index].date}'
                : '${DateFormat('MMM', 'th_TH').format(DateTime.parse('${InvoiceModels[index].date}'))} ${DateTime.parse('${InvoiceModels[index].date}').year + 543}',
            // (Ser_BodySta1 == 1)
            //     ? '${monthsInThai[int.parse(Mon_Invoice_Mon!) - 1]} ${int.parse(YE_Invoice_Mon!) + 543}'
            //     : '${DateFormat('dd-MM').format(DateTime.parse('${Value_InvoiceDate_Daily}'))}-${DateTime.parse('${Value_InvoiceDate_Daily}').year + 543}',
          );

      sheet.getRangeByName('H${index + 5}').setText(
            '${InvoiceModels[index].ln}',
          );

////////////-------------------------------------->

///////----------------------------->
      String textdata = '${InvoiceModels[index].exp_array}';
      List<dynamic> dataList = json.decode(textdata);
      double sumWhtExp = dataList
          .whereType<Map<String, dynamic>>()
          .map((element) => double.parse(element['wht_exp'].toString()))
          .fold(0, (prev, wht) => prev + wht);
      double sumNWhtExp = dataList
          .whereType<Map<String, dynamic>>()
          .map((element) => double.parse(element['nwht_exp'].toString()))
          .fold(0, (prev, wht) => prev + wht);
///////----------------------------->
      for (int index2 = 0; index2 < expModels.length; index2++) {
        double qty = dataList
            .whereType<Map<String, dynamic>>()
            .where((element) =>
                element['ser_exp'].toString() == '${expModels[index2].ser}')
            .map((element) => double.parse(element['qty_exp'].toString()))
            .fold(0, (prev, wht) => prev + wht);
        double amt = dataList
            .whereType<Map<String, dynamic>>()
            .where((element) =>
                element['ser_exp'].toString() == '${expModels[index2].ser}')
            .map((element) => double.parse(element['amt_exp'].toString()))
            .fold(0, (prev, wht) => prev + wht);
        sheet
            .getRangeByName('${columns[7 + (index2 + 1 + index2)]}${index + 5}')
            .setNumber(
              qty,
            );
        sheet
            .getRangeByName('${columns[7 + (index2 + 2 + index2)]}${index + 5}')
            .setNumber(
              amt,
            );
      }

      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 1)]}${index + 5}')
          .setNumber(
            double.parse(InvoiceModels[index].total_vat.toString()),
            // sumWhtExp,
          );

      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 2)]}${index + 5}')
          .setNumber(
            double.parse(InvoiceModels[index].total_wht.toString()),
            // sumNWhtExp,
          );

      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 3)]}${index + 5}')
          .setNumber(
            double.parse(InvoiceModels[index].amt_dis.toString()),
            // (double.parse(InvoiceModels[index].total_bill.toString()) -
            //     double.parse(InvoiceModels[index].total_dis.toString())),
          );

      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 4)]}${index + 5}')
          .setNumber(
            double.parse(InvoiceModels[index].total_bill.toString()),
          );

      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 5)]}${index + 5}')
          .setNumber(
            double.parse(InvoiceModels[index].total_dis.toString()),
          );

      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 6)]}${index + 5}')
          .setText(
            '${InvoiceModels[index].remark}',
          );
      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 7)]}${index + 5}')
          .setText(
            '${InvoiceModels[index].zn}',
          );
      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + 8)]}${index + 5}')
          .setText(
            (InvoiceModels[index].docno == null ||
                    InvoiceModels[index].docno.toString() == '')
                ? 'รอชำระ'
                : '${InvoiceModels[index].docno}',
          );
    }

    sheet.getRangeByName('H${InvoiceModels.length + 5}').cellStyle =
        globalStyle7;
    sheet.getRangeByName('H${InvoiceModels.length + 5}').setText(
          'รวม',
        );
    for (int i = 0; i < expModels.length * 2; i++) {
      sheet
          .getRangeByName('${columns[7 + (i + 1)]}${InvoiceModels.length + 5}')
          .cellStyle = globalStyle7;
      sheet.getRangeByName('${columns[7 + (i + 1)]}${indextotol + 5}').setFormula(
          '=SUM(${columns[7 + (i + 1)]}5:${columns[7 + (i + 1)]}${indextotol + 5 - 1})');
    }
    for (int i = 0; i < 5; i++) {
      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + (i + 1))]}${InvoiceModels.length + 5}')
          .cellStyle = globalStyle7;

      sheet
          .getRangeByName(
              '${columns[7 + (int.parse('${expModels.length}') * 2 + i + 1)]}${InvoiceModels.length + 5}')
          .setFormula(
              '=SUM(${columns[7 + (int.parse('${expModels.length}') * 2 + i + 1)]}5:${columns[7 + (int.parse('${expModels.length}') * 2 + i + 1)]}${indextotol + 5 - 1})');
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;
    //  (Ser_BodySta1 == 1)
    //         ? '$Value_Report (โซน : $zone_name_Invoice_Mon) ${monthsInThai[int.parse(Mon_Invoice_Mon!) - 1]} ${int.parse(YE_Invoice_Mon!) + 543}'
    //         : '$Value_Report (โซน : $zone_name_Invoice_Mon) ${DateFormat('MMM', 'th_TH').format(DateTime.parse('${Value_InvoiceDate_Daily}'))} ${DateTime.parse('${Value_InvoiceDate_Daily}').year + 543}',
    String path = (Ser_BodySta1 == 1)
        ? await FileSaver.instance.saveFile(
            'Exclusive-B-${Value_Report}Ortor(โซน_$zone_name_Invoice_Mon)เดือน_$Mon_Invoice_Mon ${int.parse(YE_Invoice_Mon!) + 543}',
            data,
            "xlsx",
            mimeType: type)
        : await FileSaver.instance.saveFile(
            'Exclusive-B-${Value_Report}Ortor(โซน_$zone_name_Invoice_Daily)วันที่_${DateFormat('dd-MM').format(DateTime.parse('${Value_InvoiceDate_Daily}'))}_${DateTime.parse('${Value_InvoiceDate_Daily}').year + 543}',
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
