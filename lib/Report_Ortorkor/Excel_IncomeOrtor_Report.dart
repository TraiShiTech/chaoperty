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

class Excgen_Income_OrtorReport {
  static void exportExcel_Income_OrtorReport(
      ser_type_repro,
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      Value_Report,
      TransReBillModels,
      TranHisBillModels,
      renTal_ser,
      renTal_name,
      zoneModels_report,
      zone_name_Trans_Mon,
      Mon_Trans_Mon,
      YE_Trans_Mon) async {
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.pageSetup.topMargin = 1;
    sheet.pageSetup.bottomMargin = 1;
    sheet.pageSetup.leftMargin = 1;
    sheet.pageSetup.rightMargin = 1;
    int all_Total = 0;
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
    globalStyle1.backColorRgb = Color.fromARGB(255, 212, 221, 185);
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
    globalStyle88.backColorRgb = Color.fromARGB(198, 235, 136, 136);
    globalStyle88.fontName = 'Angsana New';
    globalStyle88.numberFormat = '_(\* #,##0.00_)';
    globalStyle88.hAlign = x.HAlignType.center;
    globalStyle88.fontSize = 16;
    globalStyle88.bold = true;
    globalStyle88.borders;
    globalStyle88.fontColorRgb = Color.fromARGB(255, 3, 3, 3);

    globalStyle.backColorRgb = const Color.fromARGB(255, 90, 192, 59);
    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = const Color.fromARGB(255, 147, 223, 124);
    List<String> Title1 = [
      'REFTYPE',
      '*QCCORP',
      '*QCBRANCH',
      'DATE',
      '/RECEDATE',
      'DUEDATE',
      '*QCBOOK',
      'REFNO',
      '',
      'AMT',
      '*QCCOOR',
      '',
      '*QCPROD',
      '',
      'QTY',
      'PRICE',
      '*QCUM',
      '',
      '/ REMARKH1',
      '/ REMARKI1',
    ];
    List<String> Title2 = [
      'CHARACTER',
      'CHARACTER',
      'CHARACTER',
      'DATE',
      'DATE',
      'DATE',
      'CHARACTER',
      'CHARACTER',
      '',
      'NUMERIC',
      'CHARACTER',
      '',
      'CHARACTER',
      '',
      'NUMERIC',
      'NUMERIC',
      'CHARACTER',
      '',
      'CHARACTER',
      'CHARACTER',
    ];
    List<String> Title3 = [
      '2',
      '15',
      '15',
      '8',
      '8',
      '8',
      '4',
      '15',
      '',
      '15,2',
      '20',
      '',
      '20',
      '',
      '12,4',
      '15,4',
      '4.00',
      '',
      '50.00',
      '50.00',
    ];
    List<String> Title4 = [
      'รหัสเอกสาร SI = ขายเชื่อ',
      'รหัสบริษัท',
      'รหัสสาขา',
      'วันที่ของเอกสาร',
      'วันที่ยื่นภาษี',
      'วันที่ครบกำหนด',
      'เล่มที่เอกสาร',
      'เลขที่อ้างอิง  เลขที่ใบกำกับภาษี',
      '',
      'มูลค่าสินค้าไม่รวม  VAT (เป็นยอดรวมทั้งบิล  ต้องใส่ค่าให้ด้วย)',
      'รหัสลูกหนี้',
      '',
      'รหัสสินค้า',
      '',
      'จำนวนสินค้า',
      'ราคาสินค้า',
      'รหัสหน่วยนับ',
      '',
      'หมายเหตุ 1 ที่หัวเอกสาร',
      'หมายเหตุ 1 ที่รายการสินค้า',
    ];
    //////////////////----------------------------------------->
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
    //////////////////----------------------------------------->

    for (int i = 0; i < 20; i++) {
      sheet.getRangeByName('${columns[i]}1').cellStyle = globalStyle1;
      sheet.getRangeByName('${columns[i]}2').cellStyle = globalStyle1;
      sheet.getRangeByName('${columns[i]}3').cellStyle = globalStyle1;
      sheet.getRangeByName('${columns[i]}4').cellStyle = globalStyle1;
      sheet.getRangeByName('${columns[i]}4').rowHeight = 18;
      sheet.getRangeByName('${columns[i]}4').columnWidth = 18;
    }

    for (int i = 0; i < 20; i++) {
      sheet.getRangeByName('${columns[i]}1').setText('${Title1[i]}');
      sheet.getRangeByName('${columns[i]}2').setText('${Title2[i]}');
      sheet.getRangeByName('${columns[i]}3').setText('${Title3[i]}');
      sheet.getRangeByName('${columns[i]}4').setText('${Title4[i]}');
    }
    sheet.getRangeByName('I1').cellStyle = globalStyle88;
    sheet.getRangeByName('L1').cellStyle = globalStyle88;
    sheet.getRangeByName('N1').cellStyle = globalStyle88;
    sheet.getRangeByName('R1').cellStyle = globalStyle88;

    sheet.getRangeByName('I2').cellStyle = globalStyle88;
    sheet.getRangeByName('L2').cellStyle = globalStyle88;
    sheet.getRangeByName('N2').cellStyle = globalStyle88;
    sheet.getRangeByName('R2').cellStyle = globalStyle88;

    sheet.getRangeByName('I3').cellStyle = globalStyle88;
    sheet.getRangeByName('L3').cellStyle = globalStyle88;
    sheet.getRangeByName('N3').cellStyle = globalStyle88;
    sheet.getRangeByName('R3').cellStyle = globalStyle88;

    sheet.getRangeByName('I4').cellStyle = globalStyle88;
    sheet.getRangeByName('L4').cellStyle = globalStyle88;
    sheet.getRangeByName('N4').cellStyle = globalStyle88;
    sheet.getRangeByName('R4').cellStyle = globalStyle88;
/////////////////////////////////------------------------------------------------>
    int indextotol = 0;
    int indextotol_ = 0;
    int ser_dis = 0;
    String doc_no = '';
    for (var index2 = 0; index2 < TranHisBillModels.length; index2++) {
      if (TranHisBillModels[index2].docno != null) {
        if (doc_no == TranHisBillModels[index2].docno.toString()) {
          // ser_dis = ser_dis + 1;
        } else {
          doc_no = TranHisBillModels[index2].docno.toString();
          ser_dis = ser_dis + 1;
        }
      } else {
        if (doc_no == TranHisBillModels[index2].inv.toString()) {
          // ser_dis = ser_dis + 1;
        } else {
          doc_no = TranHisBillModels[index2].inv.toString();
          ser_dis = ser_dis + 1;
        }
      }

      dynamic numberColor = ser_dis % 2 == 0 ? globalStyle22 : globalStyle222;
      ///////------------------------->
      var matchingItems = TransReBillModels.where((item) =>
          item.docno.toString() == TranHisBillModels[index2].docno.toString() &&
          ser_dis == 1);

      // for (int i = 0; i < 20; i++) {
      //   if (matchingItems.isNotEmpty) {
      //     sheet.getRangeByName('${columns[i]}${indextotol + 5}').cellStyle =
      //         globalStyle222;
      //   } else {
      //     sheet.getRangeByName('${columns[i]}${indextotol + 5}').cellStyle =
      //         globalStyle22;
      //   }
      // }
      for (int i = 0; i < 20; i++) {
        sheet.getRangeByName('${columns[i]}${indextotol + 5}').cellStyle =
            numberColor;
      }
      sheet.getRangeByName('A${indextotol + 5}').setText(
          (TranHisBillModels[index2].docno != null)
              ? (TranHisBillModels[index2].doctax == null ||
                      TranHisBillModels[index2].doctax.toString().trim() == '')
                  ? '${TranHisBillModels[index2].docno.substring(0, 2)}'
                  : '${TranHisBillModels[index2].doctax.substring(0, 2)}'
              : '${TranHisBillModels[index2].inv.substring(0, 3)}'
          // (TranHisBillModels[index2].doctax == null ||
          //         TranHisBillModels[index2].doctax.toString().trim() == '')
          //     ? '${TranHisBillModels[index2].docno.substring(0, 2)}'
          //     : '${TranHisBillModels[index2].doctax.substring(0, 2)}'
          );
      sheet.getRangeByName('B${indextotol + 5}').setText('0');
      sheet.getRangeByName('C${indextotol + 5}').setText('$renTal_ser');
      sheet.getRangeByName('D${indextotol + 5}').setText((TranHisBillModels[
                      index2]
                  .daterec ==
              null)
          ? '-'
          : '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${TranHisBillModels[index2].daterec}'))}');
      sheet.getRangeByName('E${indextotol + 5}').setText(''
          // 'xx/xx/xxxx'
          );
      sheet.getRangeByName('F${indextotol + 5}').setText((TranHisBillModels[
                      index2]
                  .inv_end_date ==
              null)
          ? ''
          : '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${TranHisBillModels[index2].inv_end_date}'))}');
      sheet.getRangeByName('G${indextotol + 5}').setText('-');
      sheet.getRangeByName('H${indextotol + 5}').setText(
          (TranHisBillModels[index2].docno != null)
              ? (TranHisBillModels[index2].doctax == null ||
                      TranHisBillModels[index2].doctax.toString().trim() == '')
                  ? '${TranHisBillModels[index2].docno}'
                  : '${TranHisBillModels[index2].doctax}'
              : '${TranHisBillModels[index2].inv}');

      sheet.getRangeByName('J${indextotol + 5}').setNumber(
            (TranHisBillModels[index2].amt == null)
                ? 0.00
                : double.parse(TranHisBillModels[index2].amt!),
          );
      sheet
          .getRangeByName('K${indextotol + 5}')
          .setText('${TranHisBillModels[index2].cid}');
      sheet.getRangeByName('L${indextotol + 5}').setText((TranHisBillModels[
                      index2]
                  .sname ==
              null)
          ? (TranHisBillModels[index2].ln == null)
              ? '${TranHisBillModels[index2].remark} (รหัสพื้นที่ : ${TranHisBillModels[index2].room_number} โซน : ${TranHisBillModels[index2].zn})'
              : '${TranHisBillModels[index2].remark} (รหัสพื้นที่ : ${TranHisBillModels[index2].ln} โซน : ${TranHisBillModels[index2].zn})'
          : (TranHisBillModels[index2].ln == null)
              ? '${TranHisBillModels[index2].sname} (รหัสพื้นที่ : ${TranHisBillModels[index2].room_number} โซน : ${TranHisBillModels[index2].zn})'
              : '${TranHisBillModels[index2].sname} (รหัสพื้นที่ : ${TranHisBillModels[index2].ln} โซน : ${TranHisBillModels[index2].zn})');

      sheet
          .getRangeByName('M${indextotol + 5}')
          .setText('${TranHisBillModels[index2].expser}');

      sheet
          .getRangeByName('N${indextotol + 5}')
          .setText('${TranHisBillModels[index2].expname}');

      sheet.getRangeByName('O${indextotol + 5}').setNumber(
          (TranHisBillModels[index2].inv_qty == null ||
                  TranHisBillModels[index2].inv_qty.toString().trim() == '')
              ? 1.00
              : double.parse(TranHisBillModels[index2].inv_qty!));
      sheet.getRangeByName('P${indextotol + 5}').setNumber(
            (TranHisBillModels[index2].pvat == null)
                ? 0.00
                : double.parse(TranHisBillModels[index2].pvat!),
          );
      sheet.getRangeByName('Q${indextotol + 5}').setText(
          (TranHisBillModels[index2].unitser == null ||
                  TranHisBillModels[index2].unitser.toString().trim() == '')
              ? '0'
              : '${TranHisBillModels[index2].unitser}');

      sheet.getRangeByName('R${indextotol + 5}').setText(
          (TranHisBillModels[index2].unit == null ||
                  TranHisBillModels[index2].unit.toString().trim() == '')
              ? '-'
              : '${TranHisBillModels[index2].unit}');

      sheet.getRangeByName('S${indextotol + 5}').setText(
          (TranHisBillModels[index2].namex == null ||
                  TranHisBillModels[index2].namex.toString().trim() == '')
              ? '-'
              : '${TranHisBillModels[index2].namex}');
      sheet.getRangeByName('T${indextotol + 5}').setText((TranHisBillModels[
                      index2]
                  .date ==
              null)
          ? ''
          : '${DateFormat('เดือน MMM ', 'th').format(DateTime.parse('${TranHisBillModels[index2].date}'))}${DateTime.parse('${TranHisBillModels[index2].date}').year + 543}');
      // if (doc_no == TranHisBillModels[index2].docno.toString()) {
      //   ser_dis = ser_dis + 1;
      // } else {
      //   doc_no = TranHisBillModels[index2].docno.toString();
      //   ser_dis = 1;
      // }
      // var matchingItems = TransReBillModels.where((item) =>
      //     item.docno.toString() == TranHisBillModels[index2].docno.toString() &&
      //     ser_dis == 1);
      // if (matchingItems.isNotEmpty) {
      //   indextotol = indextotol + 1;
      //   matchingItems.forEach((item) {
      //     for (int i = 0; i < 20; i++) {
      //       sheet.getRangeByName('${columns[i]}${indextotol + 5}').cellStyle =
      //           globalStyle2220;
      //     }

      //     sheet
      //         .getRangeByName('A${indextotol + 5}')
      //         .setText('${TranHisBillModels[index2].docno.substring(0, 2)}');
      //     sheet.getRangeByName('B${indextotol + 5}').setText('0');
      //     sheet.getRangeByName('C${indextotol + 5}').setText('0');
      //     // sheet.getRangeByName('D${indextotol + 5}').setText((TranHisBillModels[
      //     //                 index2]
      //     //             .daterec ==
      //     //         null)
      //     //     ? ''
      //     //     : '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${TranHisBillModels[index2].daterec}'))}');
      //     sheet.getRangeByName('E${indextotol + 5}').setText('00/00/0000');
      //     sheet.getRangeByName('F${indextotol + 5}').setText((TranHisBillModels[
      //                     index2]
      //                 .inv_end_date ==
      //             null)
      //         ? ''
      //         : '**${DateFormat('dd/MM/yyyy').format(DateTime.parse('${TranHisBillModels[index2].inv_end_date}'))}');
      //     sheet
      //         .getRangeByName('H${indextotol + 5}')
      //         .setText('${TranHisBillModels[index2].docno}');
      //     sheet
      //         .getRangeByName('K${indextotol + 5}')
      //         .setText('${TranHisBillModels[index2].cid}');
      //     sheet.getRangeByName('L${indextotol + 5}').setText(
      //         (TranHisBillModels[index2].sname == null)
      //             ? '${TranHisBillModels[index2].remark}'
      //             : '${TranHisBillModels[index2].sname}');

      //     sheet
      //         .getRangeByName('M${indextotol + 5 - 1}')
      //         .setText('${TranHisBillModels[index2].expser}');
      //   });
      // }
      indextotol = indextotol + 1;
    }
///////------------------------->

/////////////////////////////////------------------------------------------------>
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          (ser_type_repro == '1')
              ? 'Exclusive-A-รายงานตั้งหนี้-ใบแจ้งหนี้/วางบิลOrtor ( โซน : $zone_name_Trans_Mon)_$renTal_name'
              : (ser_type_repro == '2')
                  ? 'Exclusive-A-รายงานตั้งหนี้-ใบแจ้งหนี้/วางบิลOrtor เฉพาะรายการที่มีส่วนลด ( โซน : $zone_name_Trans_Mon)_$renTal_name'
                  : (ser_type_repro == '3')
                      ? 'Exclusive-A-รายงานตั้งหนี้-ใบแจ้งหนี้/วางบิลOrtor เฉพาะล็อคเสียบ ( โซน : $zone_name_Trans_Mon)_$renTal_name'
                      : 'Exclusive-A-รายงานตั้งหนี้-ใบแจ้งหนี้/วางบิลOrtor เฉพาะรายการที่ออกใบกำกับภาษี ( โซน : $zone_name_Trans_Mon)',
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
  //////////////////----------------------------------------->
}
