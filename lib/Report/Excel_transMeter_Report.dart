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
import 'Report_Screen.dart';

//Excel_invoice_Report
class Excgen_transMeterReport {
  static void exportExcel_transMeterReport(
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      renTal_name,
      transMeterModels,
      Mon_transMeter_Mon,
      YE_transMeter_Mon,
      Status_transMeter_,
      zone_name_transMeter,
      Ser_BodySta1,
      expSZ_name,
      expSZModels) async {
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    DateTime datex = DateTime.now();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
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
    sheet.getRangeByName('I1').cellStyle = globalStyle22;
    sheet.getRangeByName('J1').cellStyle = globalStyle22;
    sheet.getRangeByName('K1').cellStyle = globalStyle22;
    sheet.getRangeByName('L1').cellStyle = globalStyle22;
    sheet.getRangeByName('M1').cellStyle = globalStyle22;
    sheet.getRangeByName('N1').cellStyle = globalStyle22;
    sheet.getRangeByName('O1').cellStyle = globalStyle22;

    final x.Range range = sheet.getRangeByName('D1');
    range.setText(
      (zone_name_transMeter == null)
          ? (expSZ_name.toString().trim() != 'ทั้งหมด')
              ? 'รายงาน $expSZ_name (กรุณาเลือกโซน)'
              : 'รายงาน [${expSZModels.where((model) => model.ser.toString() != '0').map((model) => model.expname).join(',')} ]  (กรุณาเลือกโซน)'
          : (expSZ_name.toString().trim() != 'ทั้งหมด')
              ? 'รายงาน $expSZ_name  (โซน : $zone_name_transMeter)'
              : 'รายงาน [${expSZModels.where((model) => model.ser.toString() != '0').map((model) => model.expname).join(',')} ]  (โซน : $zone_name_transMeter)',
      // (zone_name_transMeter == null)
      //     ? 'รายงานมิเตอร์น้ำ-ไฟฟ้า (กรุณาเลือกโซน)'
      //     : 'รายงานมิเตอร์น้ำ-ไฟฟ้า (โซน : $zone_name_transMeter) ',
      // (Ser_BodySta1 == 1)
      //     ? (zone_name_transMeter == null)
      //         ? 'รายงานมิเตอร์ไฟฟ้า (กรุณาเลือกโซน)'
      //         : 'รายงานมิเตอร์ไฟฟ้า (โซน : $zone_name_transMeter) '
      //     : (zone_name_transMeter == null)
      //         ? 'รายงานมิเตอร์น้ำ (กรุณาเลือกโซน)'
      //         : 'รายงานมิเตอร์น้ำ (โซน : $zone_name_transMeter) ',
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
    sheet.getRangeByName('A2').setText(
          (Mon_transMeter_Mon == null || YE_transMeter_Mon == null)
              ? 'เดือน: กรุณาเลือก'
              : 'เดือน: ${Mon_transMeter_Mon}(${YE_transMeter_Mon})',
        );
    // sheet.getRangeByName('G2').setText(
    //       '$day_',
    //     );

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
    sheet.getRangeByName('I4').cellStyle = globalStyle1;
    sheet.getRangeByName('J4').cellStyle = globalStyle1;
    sheet.getRangeByName('K4').cellStyle = globalStyle1;
    sheet.getRangeByName('L4').cellStyle = globalStyle1;
    sheet.getRangeByName('M4').cellStyle = globalStyle1;
    sheet.getRangeByName('N4').cellStyle = globalStyle1;
    sheet.getRangeByName('O4').cellStyle = globalStyle1;
    sheet.getRangeByName('A4').columnWidth = 10;
    sheet.getRangeByName('B4').columnWidth = 25;
    sheet.getRangeByName('C4').columnWidth = 25;
    sheet.getRangeByName('D4').columnWidth = 30;
    sheet.getRangeByName('E4').columnWidth = 25;
    sheet.getRangeByName('F4').columnWidth = 25;
    sheet.getRangeByName('G4').columnWidth = 30;
    sheet.getRangeByName('H4').columnWidth = 18;
    sheet.getRangeByName('I4').columnWidth = 18;
    sheet.getRangeByName('J4').columnWidth = 18;
    sheet.getRangeByName('K4').columnWidth = 18;
    sheet.getRangeByName('L4').columnWidth = 18;
    sheet.getRangeByName('M4').columnWidth = 18;
    sheet.getRangeByName('N4').columnWidth = 18;
    sheet.getRangeByName('O4').columnWidth = 18;

    sheet.getRangeByName('A4').setText('ลำดับ');
    sheet.getRangeByName('B4').setText('รหัสโซน');
    sheet.getRangeByName('C4').setText('โซน');
    sheet.getRangeByName('D4').setText('รหัสพื้นที่');
    sheet.getRangeByName('E4').setText('เลขที่สัญญา');
    sheet.getRangeByName('F4').setText('ชื่อร้านค้า');
    sheet.getRangeByName('G4').setText('รายการ');
    sheet.getRangeByName('H4').setText('วันที่');

    sheet.getRangeByName('I4').setText(
          'หมายเลขเครื่อง',
        );
    sheet.getRangeByName('J4').setText(
          (transMeterModels.length == 0 ||
                  transMeterModels[0].date == null ||
                  transMeterModels[0].date.toString() == '')
              ? 'เลขมิเตอร์เดือน(??)'
              : 'เลขมิเตอร์เดือน(${DateFormat.MMM('th_TH').format(DateTime.parse('${DateFormat('yyyy').format(DateTime.parse('${transMeterModels[0].date}'))}-${(DateTime.parse('${transMeterModels[0].date}').month - 1).toString().padLeft(2, '0')}-${DateFormat('dd').format(DateTime.parse('${transMeterModels[0].date}'))} 00:00:00'))})',
        );

    sheet.getRangeByName('K4').setText((transMeterModels.length == 0 ||
            transMeterModels[0].date == null ||
            transMeterModels[0].date.toString() == '')
        ? 'เลขมิเตอร์เดือน(??)'
        : 'เลขมิเตอร์เดือน(${DateFormat.MMM('th_TH').format(DateTime.parse('${transMeterModels[0].date}'))})');
    sheet.getRangeByName('L4').setText(
          'หน่วยที่ใช้',
        );
    sheet.getRangeByName('M4').setText(
          'ราคาต่อหน่วย',
        );
    sheet.getRangeByName('N4').setText(
          'รวม Vat',
        );
    sheet.getRangeByName('O4').setText(
          'หลักฐาน',
        );

    int index1 = 0;
    String Cid_now = '';
    for (int index = 0; index < transMeterModels.length; index++) {
      if (Cid_now.toString() == '${transMeterModels[index].refno}') {
      } else {
        Cid_now = '${transMeterModels[index].refno}';
        index1 = index1 + 1;
      }
      dynamic numberColor = (0 * transMeterModels.length + index1) % 2 == 0
          ? globalStyle22
          : globalStyle222;
      sheet.getRangeByName('A${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('B${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('C${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('D${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('E${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('F${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('G${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('H${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('I${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('J${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('K${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('L${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('M${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('N${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('O${index + 5}').cellStyle = numberColor;
      sheet.getRangeByName('A${index + 5}').setText(
            '${index + 1}',
          );
      sheet.getRangeByName('B${index + 5}').setText(
            '${transMeterModels[index].ser_zone}',
          );
      sheet.getRangeByName('C${index + 5}').setText(
            '${transMeterModels[index].zn}',
          );
      sheet.getRangeByName('D${index + 5}').setText(
            '${transMeterModels[index].ln}',
          );
      sheet.getRangeByName('E${index + 5}').setText(
            '${transMeterModels[index].refno}',
          );
      sheet.getRangeByName('F${index + 5}').setText(
            '${transMeterModels[index].sname}',
          );
      sheet.getRangeByName('G${index + 5}').setText(
            '${transMeterModels[index].expname}',
          );
      sheet.getRangeByName('H${index + 5}').setText(
            (transMeterModels[index].date == null ||
                    transMeterModels[index].date.toString() == '')
                ? ''
                : '${DateFormat('dd-MM').format(DateTime.parse('${transMeterModels[index].date}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${transMeterModels[index].date}'))}') + 543}',
          );

      sheet.getRangeByName('I${index + 5}').setText(
            '${transMeterModels[index].num_meter}',
          );

      sheet.getRangeByName('J${index + 5}').setNumber(
            (transMeterModels[index].ovalue == null)
                ? 0.00
                : double.parse(transMeterModels[index].ovalue!),
          );

      sheet.getRangeByName('K${index + 5}').setNumber(
            (transMeterModels[index].nvalue == null)
                ? 0.00
                : double.parse(transMeterModels[index].nvalue!),
          );
      sheet.getRangeByName('L${index + 5}').setNumber(
            (transMeterModels[index].qty == null)
                ? 0.00
                : double.parse(transMeterModels[index].qty!),
          );
      sheet.getRangeByName('M${index + 5}').setText(
            transMeterModels[index].ele_ty == '0'
                ? '${double.parse(transMeterModels[index].c_qty!)}'
                : 'อัตราพิเศษ',
            // (transMeterModels[index].pri == null)
            //     ? 0.00
            //     : double.parse(transMeterModels[index].c_qty!),
          );

      sheet.getRangeByName('N${index + 5}').setNumber(
            (transMeterModels[index].c_amt == null)
                ? 0.00
                : double.parse(transMeterModels[index].c_amt!),
          );
      sheet
          .getRangeByName('O${index + 5}')
          .setText((transMeterModels[index].img != '') ? 'พบ' : 'ไม่พบ');
    }

    // sheet.getRangeByName('H${transMeterModels.length + 5}').cellStyle =
    //     globalStyle7;
    // sheet.getRangeByName('I${transMeterModels.length + 5}').cellStyle =
    //     globalStyle7;
    sheet.getRangeByName('K${transMeterModels.length + 5}').cellStyle =
        globalStyle7;
    sheet.getRangeByName('L${transMeterModels.length + 5}').cellStyle =
        globalStyle7;
    sheet.getRangeByName('M${transMeterModels.length + 5}').cellStyle =
        globalStyle7;
    sheet.getRangeByName('N${transMeterModels.length + 5}').cellStyle =
        globalStyle7;

    sheet.getRangeByName('K${transMeterModels.length + 5}').setText(
          'รวม',
        );
    sheet.getRangeByName('L${transMeterModels.length + 5}').setFormula(
          '=SUM(J5:J${transMeterModels.length + 5 - 1})',
        );
    // sheet.getRangeByName('L${transMeterModels.length + 5}').setFormula(
    //       '=SUM(K5:K${transMeterModels.length + 5 - 1})',
    //     );
    sheet.getRangeByName('N${transMeterModels.length + 5}').setFormula(
          '=SUM(L5:L${transMeterModels.length + 5 - 1})',
        );
    // sheet.getRangeByName('M${transMeterModels.length + 5}').setNumber(
    //       transMeterModels.fold(
    //           0.0,
    //           (previousValue, element) =>
    //               previousValue + (element.img != '' ? 1.00 : 0.00)),
    //     );
    var name_File = (zone_name_transMeter == null)
        ? (expSZ_name.toString().trim() != 'ทั้งหมด')
            ? 'รายงาน$expSZ_name(กรุณาเลือกโซน)'
            : 'รายงาน[${expSZModels.where((model) => model.ser.toString() != '0').map((model) => model.expname).join(',')} ](กรุณาเลือกโซน)'
        : (expSZ_name.toString().trim() != 'ทั้งหมด')
            ? 'รายงาน$expSZ_name(โซน : $zone_name_transMeter)'
            : 'รายงาน[${expSZModels.where((model) => model.ser.toString() != '0').map((model) => model.expname).join(',')} ](โซน : $zone_name_transMeter)';
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;
    String path = await FileSaver.instance.saveFile(
        '$name_File[เดือน ${Mon_transMeter_Mon}ปี${YE_transMeter_Mon}]',
        data,
        "xlsx",
        mimeType: type);
    // (Ser_BodySta1 == 1)
    //     ? await FileSaver.instance.saveFile(
    //         'รายงานมิเตอร์ไฟฟ้า (โซน : $zone_name_transMeter) ', data, "xlsx",
    //         mimeType: type)
    //     : await FileSaver.instance.saveFile(
    //         'รายงานมิเตอร์น้ำ (โซน : $zone_name_transMeter) ', data, "xlsx",
    //         mimeType: type);
    log(path);
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
