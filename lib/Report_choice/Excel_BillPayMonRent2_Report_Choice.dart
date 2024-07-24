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

//////////รายงานค่าเช่า-2 (ประจำเดือน)
class Excgen_BillPayMonRent2Report_Choice {
  static void exportExcel_BillPayMonRent2Report_Choice(
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      renTal_name,
      Value_Chang_Zone_billpayMon2,
      billpay_Mon2,
      Mon_billpay_Mon2,
      YE_billpay_Mon2) async {
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    DateTime datex = DateTime.now();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'; //// GC_billPay_SalesTaxFullReport_ _Choice

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.name = 'รายงานค่าเช่าประจำเดือน';
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

    sheet.getRangeByName('A1:G1').merge();
    sheet.getRangeByName('A2:G2').merge();
    sheet.getRangeByName('A3:G3').merge();
    sheet.getRangeByName('A4:G4').merge();

    sheet.getRangeByName('A1').setText(
          (Value_Chang_Zone_billpayMon2 == null)
              ? 'รายงานค่าเช่า-2  (กรุณาเลือกโซน)'
              : 'รายงานค่าเช่า-2 (โซน : $Value_Chang_Zone_billpayMon2)',
        );
    sheet
        .getRangeByName('A2')
        .setText('เดือนภาษี ${Mon_billpay_Mon2} ${YE_billpay_Mon2}');
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
      // sheet.getRangeByName('H${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('I${index + 1}').cellStyle = globalStyle220;

      // sheet.getRangeByName('J${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('K${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('L${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('M${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('N${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('O${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('P${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('Q${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('R${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('S${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('T${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('U${index + 1}').cellStyle = globalStyle220;
      // sheet.getRangeByName('V${index + 1}').cellStyle = globalStyle220;

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
    // sheet.getRangeByName('H2').cellStyle = globalStyle1;
    // sheet.getRangeByName('I2').cellStyle = globalStyle1;
    // sheet.getRangeByName('J2').cellStyle = globalStyle1;
    // sheet.getRangeByName('K2').cellStyle = globalStyle1;
    // sheet.getRangeByName('L2').cellStyle = globalStyle1;
    // sheet.getRangeByName('M2').cellStyle = globalStyle1;
    // sheet.getRangeByName('N2').cellStyle = globalStyle1;
    // sheet.getRangeByName('O2').cellStyle = globalStyle1;
    // sheet.getRangeByName('P2').cellStyle = globalStyle1;
    // sheet.getRangeByName('Q2').cellStyle = globalStyle1;
    // sheet.getRangeByName('R2').cellStyle = globalStyle1;
    // sheet.getRangeByName('S2').cellStyle = globalStyle1;
    // sheet.getRangeByName('T2').cellStyle = globalStyle1;
    // sheet.getRangeByName('U2').cellStyle = globalStyle1;
    // sheet.getRangeByName('V2').cellStyle = globalStyle1;

    sheet.getRangeByName('A2').columnWidth = 10;
    sheet.getRangeByName('B2').columnWidth = 20;
    sheet.getRangeByName('C2').columnWidth = 20;
    sheet.getRangeByName('D2').columnWidth = 25;
    sheet.getRangeByName('E2').columnWidth = 25;
    sheet.getRangeByName('F2').columnWidth = 25;
    sheet.getRangeByName('G2').columnWidth = 18;
    // sheet.getRangeByName('H2').columnWidth = 30;
    // sheet.getRangeByName('I2').columnWidth = 18;
    // sheet.getRangeByName('J2').columnWidth = 18;
    // sheet.getRangeByName('K2').columnWidth = 18;
    // sheet.getRangeByName('L2').columnWidth = 18;
    // sheet.getRangeByName('M2').columnWidth = 18;
    // sheet.getRangeByName('N2').columnWidth = 18;
    // sheet.getRangeByName('O2').columnWidth = 18;
    // sheet.getRangeByName('P2').columnWidth = 18;
    // sheet.getRangeByName('Q2').columnWidth = 18;
    // sheet.getRangeByName('R2').columnWidth = 18;
    // sheet.getRangeByName('S2').columnWidth = 18;
    // sheet.getRangeByName('T2').columnWidth = 18;
    // sheet.getRangeByName('U2').columnWidth = 18;
    // sheet.getRangeByName('V2').columnWidth = 18;

    sheet.getRangeByName('A6').setText('ลำดับที่');
    sheet.getRangeByName('B6').setText('วันที่');
    sheet.getRangeByName('C6').setText('เลขใบกำกับภาษี');
    sheet.getRangeByName('D6').setText('รายชื่อลูกค้า');
    sheet.getRangeByName('E6').setText(' จำนวนเงิน');
    sheet.getRangeByName('F6').setText('ภาษีมูลค่าเพิ่ม(7%)');
    sheet.getRangeByName('G6').setText('จำนวนเงินรวมทั้งสิ้น');
    // sheet.getRangeByName('H2').setText('เงินประกัน');
    // sheet.getRangeByName('I2').setText('ค่าเช่า');

    // sheet.getRangeByName('J2').setText('ค่าบริการ');
    // sheet.getRangeByName('K2').setText('ค่าน้ำ');
    // sheet.getRangeByName('L2').setText('ค่าไฟ');
    // sheet.getRangeByName('M2').setText('เดือน');
    // sheet.getRangeByName('N2').setText('วันที่เงินเข้าบัญชี');
    // sheet.getRangeByName('O2').setText('ส่วนลด');
    // sheet.getRangeByName('P2').setText('ค่าปรับ');
    // sheet.getRangeByName('Q2').setText('ค่าเช่า+น้ำ+ไฟฟ้า+vat+ค่าปรับ(ในระบบ)');
    // sheet.getRangeByName('R2').setText('เงินเข้าบัญชี');

    // sheet.getRangeByName('S2').setText('ผลต่าง');
    // sheet.getRangeByName('T2').setText('สถานะ');

    // sheet.getRangeByName('U2').setText('ผู้ดูแล');
    // sheet.getRangeByName('V2').setText('หมายเหตุ');

    int index1 = 0;
    int indextotol = 0;
    List cid_number = [];

    for (int index = 0; index < billpay_Mon2.length; index++) {
      dynamic numberColor = ((index % 2) == 0) ? globalStyle22 : globalStyle222;
      sheet.getRangeByName('A${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('B${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('C${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('D${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('E${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('F${index + 7}').cellStyle = numberColor;
      sheet.getRangeByName('G${index + 7}').cellStyle = numberColor;
      // sheet.getRangeByName('H${index + 3}').cellStyle = numberColor;
      // sheet.getRangeByName('I${index + 3}').cellStyle = numberColor;

      // sheet.getRangeByName('J${index + 3}').cellStyle = numberColor;
      // sheet.getRangeByName('K${index + 3}').cellStyle = numberColor;
      // sheet.getRangeByName('L${index + 3}').cellStyle = numberColor;
      // sheet.getRangeByName('M${index + 3}').cellStyle = numberColor;
      // sheet.getRangeByName('N${index + 3}').cellStyle = numberColor;
      // sheet.getRangeByName('O${index + 3}').cellStyle = numberColor;
      // sheet.getRangeByName('P${index + 3}').cellStyle = numberColor;
      // sheet.getRangeByName('Q${index + 3}').cellStyle = numberColor;
      // sheet.getRangeByName('R${index + 3}').cellStyle = numberColor;
      // sheet.getRangeByName('S${index + 3}').cellStyle = numberColor;
      // sheet.getRangeByName('T${index + 3}').cellStyle = numberColor;
      // sheet.getRangeByName('U${index + 3}').cellStyle = numberColor;
      // sheet.getRangeByName('V${index + 3}').cellStyle = numberColor;

      sheet.getRangeByName('A${index + 7}').setText('${index + 1}');
      sheet.getRangeByName('B${index + 7}').setText(
          '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${billpay_Mon2[index].daterec}'))}');

      sheet.getRangeByName('C${index + 7}').setText(
            (billpay_Mon2[index].doctax == null)
                ? '${billpay_Mon2[index].docno}'
                : '${billpay_Mon2[index].doctax}',
          );

      sheet
          .getRangeByName('D${index + 7}')
          .setText('${billpay_Mon2[index].cname}');

      sheet.getRangeByName('E${index + 7}').setNumber(
          (billpay_Mon2[index].total_bill_pvat == null)
              ? 0.00
              : double.parse('${billpay_Mon2[index].total_bill_pvat}'));
      sheet.getRangeByName('F${index + 7}').setNumber(
          (billpay_Mon2[index].total_bill_vat == null)
              ? 0.00
              : double.parse('${billpay_Mon2[index].total_bill_vat}'));
      sheet.getRangeByName('G${index + 7}').setNumber(
          (billpay_Mon2[index].total_bill == null)
              ? 0.00
              : double.parse('${billpay_Mon2[index].total_bill}'));
      indextotol = indextotol + 1;
    }
/////////---------------------------->
    sheet.getRangeByName('D${indextotol + 7 + 0}').setText('รวมทั้งหมด: ');
    sheet
        .getRangeByName('E${indextotol + 7 + 0}')
        .setFormula('=SUM(E7:E${indextotol + 7 - 1})');
    sheet
        .getRangeByName('F${indextotol + 7 + 0}')
        .setFormula('=SUM(F7:F${indextotol + 7 - 1})');
    sheet
        .getRangeByName('G${indextotol + 7 + 0}')
        .setFormula('=SUM(G7:G${indextotol + 7 - 1})');

    sheet.getRangeByName('D${indextotol + 7 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('E${indextotol + 7 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('F${indextotol + 7 + 0}').cellStyle = globalStyle7;
    sheet.getRangeByName('G${indextotol + 7 + 0}').cellStyle = globalStyle7;

/////////---------------------------->
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;
    String path = await FileSaver.instance.saveFile(
        (Value_Chang_Zone_billpayMon2 == null)
            ? 'รายงานค่าเช่า-2(กรุณาเลือกโซน)'
            : 'รายงานค่าเช่า-2(โซน : $Value_Chang_Zone_billpayMon2)',
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
