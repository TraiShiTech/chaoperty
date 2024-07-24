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

//////////รายงานภาษีขาย
class Excgen_SalesTaxFull2Report_Choice {
  static void exportExcel_SalesTaxFull2Report_Choice(
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      renTal_name,
      Value_Chang_Zone_SalesTax_Full2,
      salesTax_full2,
      Mon_SalesTax_Full_Mon2,
      YE_SalesTax_Full_Mon2) async {
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    DateTime datex = DateTime.now();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.name = 'รายงานภาษีขาย';
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

    sheet.getRangeByName('A1:K1').merge();
    sheet.getRangeByName('A2:K2').merge();
    sheet.getRangeByName('A3:K3').merge();
    sheet.getRangeByName('A4:K4').merge();

    sheet.getRangeByName('A1').setText(
          (Value_Chang_Zone_SalesTax_Full2 == null)
              ? 'รายงานภาษีขาย-2  (กรุณาเลือกโซน)'
              : 'รายงานภาษีขาย-2  (โซน : $Value_Chang_Zone_SalesTax_Full2)',
        );
    sheet.getRangeByName('A2').setText(
        'เดือนภาษี ${Mon_SalesTax_Full_Mon2} ${YE_SalesTax_Full_Mon2}');
    sheet.getRangeByName('A3').setText(
        'ชื่อสถานประกอบการ บริษัท ชอยส์มินิสโตร์ จำกัด เลขประจำตัวผู้เสียภาษี 0-1055-31085-43-4');
    sheet.getRangeByName('A4').setText('ชื่อสถานประกอบการ เซเว่นอีเลฟเว่น');

// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password
    for (int index = 0; index < 6; index++) {
      ////
      sheet.getRangeByName('A${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('B${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('C${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('D${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('E${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('F${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('G${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('H${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('I${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('J${index + 1}').cellStyle = globalStyle220;
      sheet.getRangeByName('K${index + 1}').cellStyle = globalStyle220;

      // sheet.getRangeByName('L${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('M${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('N${index + 1}').cellStyle = globalStyle220;

      // sheet.getRangeByName('O${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('P${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('Q${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('R${index + 1}').cellStyle = globalStyle220;
      ////
    }

    globalStyle2.hAlign = x.HAlignType.center;
    sheet.getRangeByName('A6').cellStyle = globalStyle1;
    sheet.getRangeByName('B6').cellStyle = globalStyle1;
    sheet.getRangeByName('C6').cellStyle = globalStyle1;
    sheet.getRangeByName('D6').cellStyle = globalStyle1;
    sheet.getRangeByName('E6').cellStyle = globalStyle1;
    sheet.getRangeByName('F6').cellStyle = globalStyle1;
    sheet.getRangeByName('G6').cellStyle = globalStyle1;
    sheet.getRangeByName('H6').cellStyle = globalStyle1;
    sheet.getRangeByName('I6').cellStyle = globalStyle1;
    sheet.getRangeByName('J6').cellStyle = globalStyle1;
    sheet.getRangeByName('K6').cellStyle = globalStyle1;
    // sheet.getRangeByName('L6').cellStyle = globalStyle1;
    // sheet.getRangeByName('M6').cellStyle = globalStyle1;
    // sheet.getRangeByName('N6').cellStyle = globalStyle1;
    // sheet.getRangeByName('O6').cellStyle = globalStyle1;
    // sheet.getRangeByName('P6').cellStyle = globalStyle1;
    // sheet.getRangeByName('Q6').cellStyle = globalStyle1;
    // sheet.getRangeByName('R6').cellStyle = globalStyle1;

    sheet.getRangeByName('A6').columnWidth = 10;
    sheet.getRangeByName('B6').columnWidth = 25;
    sheet.getRangeByName('C6').columnWidth = 25;
    sheet.getRangeByName('D6').columnWidth = 25;
    sheet.getRangeByName('E6').columnWidth = 25;
    sheet.getRangeByName('F6').columnWidth = 25;
    sheet.getRangeByName('G6').columnWidth = 25;
    sheet.getRangeByName('H6').columnWidth = 25;
    sheet.getRangeByName('I6').columnWidth = 25;
    sheet.getRangeByName('J6').columnWidth = 25;
    sheet.getRangeByName('K6').columnWidth = 30;
    // sheet.getRangeByName('L6').columnWidth = 25;
    // sheet.getRangeByName('M6').columnWidth = 25;
    // sheet.getRangeByName('N6').columnWidth = 25;
    // sheet.getRangeByName('O6').columnWidth = 25;
    // sheet.getRangeByName('P6').columnWidth = 25;
    // sheet.getRangeByName('Q6').columnWidth = 25;
    // sheet.getRangeByName('R6').columnWidth = 25;

    sheet.getRangeByName('A6').setText('ลำดับที่');
    sheet.getRangeByName('B6').setText('วันที่');
    sheet.getRangeByName('C6').setText('เลขใบกำกับภาษี');
    sheet.getRangeByName('D6').setText('รายชื่อลูกค้า');
    sheet.getRangeByName('E6').setText('สาขา');
    sheet.getRangeByName('F6').setText('เลขประจำตัวผู้เสียภาษี');
    sheet.getRangeByName('G6').setText('ค่าเช่า');
    sheet.getRangeByName('H6').setText('ค่าเช่า-ภาษีมูลค่าเพิ่ม');
    sheet.getRangeByName('I6').setText('ค่าบริการพื้นที่');
    sheet.getRangeByName('J6').setText('ค่าบริการพื้นที่-ภาษีมูลค่าเพิ่ม');
    sheet.getRangeByName('K6').setText('จำนวนเงินรวม');
    // sheet
    //     .getRangeByName('L6')
    //     .setText('รวมค่าบรวมค่าเช่า-ค่าบริการพื้นที่ริการพื้นที่');
    // sheet.getRangeByName('M6').setText('ค่าอุปกรณ์');
    // sheet.getRangeByName('N6').setText('ภาษีมูลค่าเพิ่ม 7% (ค่าอุปกรณ์)');

    // sheet.getRangeByName('O6').setText('รวมค่าอุปกรณ์');
    // sheet
    //     .getRangeByName('P6')
    //     .setText('ค่าเช่า-ค่าบริการ หน้าร้าน รับล่วงหน้า');
    // sheet.getRangeByName('Q6').setText('จำนวนเงินรวมทั้งสิ้น');
    // sheet.getRangeByName('R6').setText('วันเริ่มต้นสัญญา');

    int index1 = 0;
    int indextotol = 0;
    List cid_number = [];
    for (int index = 0; index < salesTax_full2.length; index++) {
      dynamic numberColor = ((index % 2) == 0) ? globalStyle22 : globalStyle222;
      sheet.getRangeByName('A${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('B${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('C${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('D${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('E${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('F${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('G${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('H${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('I${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('J${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('K${index + 7}').cellStyle = numberColor;
      // sheet.getRangeByName('L${index + 7}').cellStyle = numberColor;
      // sheet.getRangeByName('M${index + 7}').cellStyle = numberColor;
      // sheet.getRangeByName('N${index + 7}').cellStyle = numberColor;
      // sheet.getRangeByName('O${index + 7}').cellStyle = numberColor;
      // sheet.getRangeByName('P${index + 7}').cellStyle = numberColor;
      // sheet.getRangeByName('Q${index + 7}').cellStyle = numberColor;
      // sheet.getRangeByName('R${index + 7}').cellStyle = numberColor;

      sheet.getRangeByName('A${index + 7}').setText('${index + 1}');
      sheet.getRangeByName('B${index + 7}').setText(
          '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${salesTax_full2[index].daterec}'))}');
      sheet.getRangeByName('C${index + 7}').setText(
          (salesTax_full2[index].doctax == null ||
                  salesTax_full2[index].doctax.toString() == '')
              ? '${salesTax_full2[index].docno}'
              : '${salesTax_full2[index].doctax}');

      sheet.getRangeByName('D${index + 7}').setText(
            (salesTax_full2[index].cname != null)
                ? '${salesTax_full2[index].cname}'
                : '${salesTax_full2[index].remark}',
          );

      sheet.getRangeByName('E${index + 7}').setText(
          (salesTax_full2[index].zn != null)
              ? '${salesTax_full2[index].zn}'
              : '${salesTax_full2[index].znn}');

      sheet.getRangeByName('F${index + 7}').setText(
            (salesTax_full2[index].tax != null)
                ? '${salesTax_full2[index].tax}'
                : '',
          );

      sheet.getRangeByName('G${index + 7}').setNumber(
          (salesTax_full2[index].rent_pvat == null)
              ? 0.00
              : double.parse('${salesTax_full2[index].rent_pvat}'));

      sheet.getRangeByName('H${index + 7}').setNumber(
          (salesTax_full2[index].rent_vat == null)
              ? 0.00
              : double.parse('${salesTax_full2[index].rent_vat}'));

      sheet.getRangeByName('I${index + 7}').setNumber(
          (salesTax_full2[index].service_pvat == null)
              ? 0.00
              : double.parse('${salesTax_full2[index].service_pvat}'));

      sheet.getRangeByName('J${index + 7}').setNumber(
          (salesTax_full2[index].service_vat == null)
              ? 0.00
              : double.parse('${salesTax_full2[index].service_vat}'));

      sheet.getRangeByName('K${index + 7}').setNumber(
          (salesTax_full2[index].service_total == null &&
                  salesTax_full2[index].rent_total == null)
              ? 0.00
              : double.parse(salesTax_full2[index].service_total == null
                      ? '0.00'
                      : '${salesTax_full2[index].service_total}') +
                  double.parse(salesTax_full2[index].rent_total == null
                      ? '0.00'
                      : '${salesTax_full2[index].rent_total}'));

      indextotol = indextotol + 1;
    }
/////////---------------------------->
    sheet.getRangeByName('F${indextotol + 7 + 0}').setText('รวมทั้งหมด: ');
    sheet
        .getRangeByName('G${indextotol + 7 + 0}')
        .setFormula('=SUM(G7:G${indextotol + 7 - 1})');
    sheet
        .getRangeByName('H${indextotol + 7 + 0}')
        .setFormula('=SUM(H7:H${indextotol + 7 - 1})');
    sheet
        .getRangeByName('I${indextotol + 7 + 0}')
        .setFormula('=SUM(I7:I${indextotol + 7 - 1})');
    sheet
        .getRangeByName('J${indextotol + 7 + 0}')
        .setFormula('=SUM(J7:J${indextotol + 7 - 1})');
    sheet
        .getRangeByName('K${indextotol + 7 + 0}')
        .setFormula('=SUM(K7:K${indextotol + 7 - 1})');

    sheet.getRangeByName('F${indextotol + 7 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('G${indextotol + 7 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('H${indextotol + 7 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('I${indextotol + 7 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('J${indextotol + 7 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('K${indextotol + 7 + 0}').cellStyle = globalStyle7;
/////////---------------------------->
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;
    String path = await FileSaver.instance.saveFile(
        (Value_Chang_Zone_SalesTax_Full2 == null)
            ? 'รายงานภาษีขาย-2 ประจำเดือน ${Mon_SalesTax_Full_Mon2} ${YE_SalesTax_Full_Mon2} (กรุณาเลือกโซน)'
            : 'รายงานภาษีขาย-2 ประจำเดือน ${Mon_SalesTax_Full_Mon2} ${YE_SalesTax_Full_Mon2} (โซน : $Value_Chang_Zone_SalesTax_Full2)',
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
