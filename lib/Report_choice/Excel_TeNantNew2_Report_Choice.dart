import 'dart:typed_data';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:excel/excel.dart';
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

//////////รายงานผู้เช่ารายใหม่
class Excgen_TeNantNew2Report_Choice {
  static void exportExcel_TeNantNew2Report_Choice(
      context,
      NameFile_,
      _verticalGroupValue_NameFile,
      renTal_name,
      Value_Chang_Zone_People_TeNantNew,
      teNantModels_New,
      Mon_PeopleTeNantNew_Mon,
      YE_PeopleTeNantNew_Mon) async {
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    DateTime datex = DateTime.now();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'; //// GC_billPay_SalesTaxFullReport_ _Choice

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    final x.Workbook workbook = x.Workbook(3);

    final x.Worksheet sheet1 = workbook.worksheets[0];
    final x.Worksheet sheet2 = workbook.worksheets[1];
    final x.Worksheet sheet3 = workbook.worksheets[2];
    // final x.Worksheet sheet4 = workbook.worksheets[3];
    // final x.Worksheet sheet5 = workbook.worksheets[4];
    // final x.Worksheet sheet6 = workbook.worksheets[5];
    sheet1.name = 'ปะหน้าใบเสร็จ(รายงานผู้เช่ารายใหม่-2)';
    // sheet2.name = 'งปก.(รายงานผู้เช่ารายใหม่-2)';
    // sheet3.name = 'เช่า 06.67';
    // sheet4.name = 'เช่า07.67 ';
    sheet2.name = 'ค่าเช่า-ค่าบริการ';
    sheet3.name = 'ผ้ากันเปื้อน';
    //////////--------------------------->
    sheet1.pageSetup.topMargin = 1;
    sheet1.pageSetup.bottomMargin = 1;
    sheet1.pageSetup.leftMargin = 1;
    sheet1.pageSetup.rightMargin = 1;
    //////////--------------------------->
    sheet2.pageSetup.topMargin = 1;
    sheet2.pageSetup.bottomMargin = 1;
    sheet2.pageSetup.leftMargin = 1;
    sheet2.pageSetup.rightMargin = 1;
    //////////--------------------------->
    sheet3.pageSetup.topMargin = 1;
    sheet3.pageSetup.bottomMargin = 1;
    sheet3.pageSetup.leftMargin = 1;
    sheet3.pageSetup.rightMargin = 1;
    //////////--------------------------->
    // sheet4.pageSetup.topMargin = 1;
    // sheet4.pageSetup.bottomMargin = 1;
    // sheet4.pageSetup.leftMargin = 1;
    // sheet4.pageSetup.rightMargin = 1;
    // //////////--------------------------->
    // sheet5.pageSetup.topMargin = 1;
    // sheet5.pageSetup.bottomMargin = 1;
    // sheet5.pageSetup.leftMargin = 1;
    // sheet5.pageSetup.rightMargin = 1;
    // //////////--------------------------->
    // sheet6.pageSetup.topMargin = 1;
    // sheet6.pageSetup.bottomMargin = 1;
    // sheet6.pageSetup.leftMargin = 1;
    // sheet6.pageSetup.rightMargin = 1;
    //////////--------------------------->
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

    ////////////-------------------------------------------------------->
    x.Style globalStyle220_2 = workbook.styles.add('globalStyle220_2');
    globalStyle220_2.backColorRgb = Color(0xC7F5F7FA);
    globalStyle220_2.numberFormat = '_(\* #,##0.00_)';
    globalStyle220_2.fontSize = 12;
    globalStyle220_2.numberFormat;
    globalStyle220_2.hAlign = x.HAlignType.center;

    globalStyle.backColorRgb = const Color.fromARGB(255, 90, 192, 59);
    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = const Color.fromARGB(255, 147, 223, 124);

/////////--------------------------------------------->
    sheet1.getRangeByName('A1:I1').merge();
    sheet1.getRangeByName('A1:K1').merge();
    sheet1.getRangeByName('A2:K2').merge();
    sheet1.getRangeByName('A3:K3').merge();
    sheet1.getRangeByName('A4:K4').merge();

    sheet2.getRangeByName('A1:K1').merge();
    sheet2.getRangeByName('A2:K2').merge();
    sheet2.getRangeByName('A3:K3').merge();
    sheet2.getRangeByName('A4:K4').merge();

    sheet3.getRangeByName('A1:K1').merge();
    sheet3.getRangeByName('A2:K2').merge();
    sheet3.getRangeByName('A3:K3').merge();
    sheet3.getRangeByName('A4:K4').merge();

    // sheet4.getRangeByName('A1:K1').merge();
    // sheet4.getRangeByName('A2:K2').merge();
    // sheet4.getRangeByName('A3:K3').merge();
    // sheet4.getRangeByName('A4:K4').merge();

    // sheet5.getRangeByName('A1:K1').merge();
    // sheet5.getRangeByName('A2:K2').merge();
    // sheet5.getRangeByName('A3:K3').merge();
    // sheet5.getRangeByName('A4:K4').merge();

    // sheet6.getRangeByName('A1:K1').merge();
    // sheet6.getRangeByName('A2:K2').merge();
    // sheet6.getRangeByName('A3:K3').merge();
    // sheet6.getRangeByName('A4:K4').merge();

    sheet1.getRangeByName('A1').setText(
          (Value_Chang_Zone_People_TeNantNew == null)
              ? 'รายงานผู้เช่ารายใหม่-2  (กรุณาเลือกโซน)'
              : 'รายงานผู้เช่ารายใหม่-2  (โซน : $Value_Chang_Zone_People_TeNantNew)',
        );
    sheet2.getRangeByName('A1').setText(
          (Value_Chang_Zone_People_TeNantNew == null)
              ? 'รายงานผู้เช่ารายใหม่-2  (กรุณาเลือกโซน)'
              : 'รายงานผู้เช่ารายใหม่-2  (โซน : $Value_Chang_Zone_People_TeNantNew)',
        );
    sheet3.getRangeByName('A1').setText(
          (Value_Chang_Zone_People_TeNantNew == null)
              ? 'รายงานผู้เช่ารายใหม่-2  (กรุณาเลือกโซน)'
              : 'รายงานผู้เช่ารายใหม่-2  (โซน : $Value_Chang_Zone_People_TeNantNew)',
        );
    // sheet4.getRangeByName('A1').setText(
    //       (Value_Chang_Zone_People_TeNantNew == null)
    //           ? 'รายงานผู้เช่ารายใหม่-2  (กรุณาเลือกโซน)'
    //           : 'รายงานผู้เช่ารายใหม่-2  (โซน : $Value_Chang_Zone_People_TeNantNew)',
    //     );
    // sheet5.getRangeByName('A1').setText(
    //       (Value_Chang_Zone_People_TeNantNew == null)
    //           ? 'รายงานผู้เช่ารายใหม่-2  (กรุณาเลือกโซน)'
    //           : 'รายงานผู้เช่ารายใหม่-2  (โซน : $Value_Chang_Zone_People_TeNantNew)',
    //     );
    // sheet6.getRangeByName('A1').setText(
    //       (Value_Chang_Zone_People_TeNantNew == null)
    //           ? 'รายงานผู้เช่ารายใหม่-2  (กรุณาเลือกโซน)'
    //           : 'รายงานผู้เช่ารายใหม่-2  (โซน : $Value_Chang_Zone_People_TeNantNew)',
    //     );

    sheet1
        .getRangeByName('A2')
        .setText('เดือน ${Mon_PeopleTeNantNew_Mon} ${YE_PeopleTeNantNew_Mon}');
    sheet2
        .getRangeByName('A2')
        .setText('เดือน ${Mon_PeopleTeNantNew_Mon} ${YE_PeopleTeNantNew_Mon}');
    sheet3
        .getRangeByName('A2')
        .setText('เดือน ${Mon_PeopleTeNantNew_Mon} ${YE_PeopleTeNantNew_Mon}');
    // sheet4
    //     .getRangeByName('A2')
    //     .setText('เดือน ${Mon_PeopleTeNantNew_Mon} ${YE_PeopleTeNantNew_Mon}');
    // sheet5
    //     .getRangeByName('A2')
    //     .setText('เดือน ${Mon_PeopleTeNantNew_Mon} ${YE_PeopleTeNantNew_Mon}');
    // sheet6
    //     .getRangeByName('A2')
    //     .setText('เดือน ${Mon_PeopleTeNantNew_Mon} ${YE_PeopleTeNantNew_Mon}');
    sheet1.getRangeByName('A3').setText(
        'ชื่อสถานประกอบการ บริษัท ชอยส์มินิสโตร์ จำกัด เลขประจำตัวผู้เสียภาษี 0-1055-31085-43-4');
    sheet2.getRangeByName('A3').setText(
        'ชื่อสถานประกอบการ บริษัท ชอยส์มินิสโตร์ จำกัด เลขประจำตัวผู้เสียภาษี 0-1055-31085-43-4');
    sheet3.getRangeByName('A3').setText(
        'ชื่อสถานประกอบการ บริษัท ชอยส์มินิสโตร์ จำกัด เลขประจำตัวผู้เสียภาษี 0-1055-31085-43-4');
    // sheet4.getRangeByName('A3').setText(
    //     'ชื่อสถานประกอบการ บริษัท ชอยส์มินิสโตร์ จำกัด เลขประจำตัวผู้เสียภาษี 0-1055-31085-43-4');
    // sheet5.getRangeByName('A3').setText(
    //     'ชื่อสถานประกอบการ บริษัท ชอยส์มินิสโตร์ จำกัด เลขประจำตัวผู้เสียภาษี 0-1055-31085-43-4');
    // sheet6.getRangeByName('A3').setText(
    //     'ชื่อสถานประกอบการ บริษัท ชอยส์มินิสโตร์ จำกัด เลขประจำตัวผู้เสียภาษี 0-1055-31085-43-4');
    sheet1.getRangeByName('A4').setText('ชื่อสถานประกอบการ เซเว่นอีเลฟเว่น');
    sheet2.getRangeByName('A4').setText('ชื่อสถานประกอบการ เซเว่นอีเลฟเว่น');
    sheet3.getRangeByName('A4').setText('ชื่อสถานประกอบการ เซเว่นอีเลฟเว่น');
    // sheet4.getRangeByName('A4').setText('ชื่อสถานประกอบการ เซเว่นอีเลฟเว่น');
    // sheet5.getRangeByName('A4').setText('ชื่อสถานประกอบการ เซเว่นอีเลฟเว่น');
    // sheet6.getRangeByName('A4').setText('ชื่อสถานประกอบการ เซเว่นอีเลฟเว่น');
/////////--------------------------------------------->
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password
    for (int index = 0; index < 6; index++) {
      ////
      sheet1.getRangeByName('A${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('B${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('C${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('D${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('E${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('F${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('G${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('H${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('I${index + 1}').cellStyle = globalStyle220;

      sheet1.getRangeByName('J${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('K${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('L${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('M${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('N${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('O${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('P${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('Q${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('R${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('S${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('T${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('U${index + 1}').cellStyle = globalStyle220;
      sheet1.getRangeByName('V${index + 1}').cellStyle = globalStyle220;
      // sheet1.getRangeByName('W${index + 1}').cellStyle = globalStyle220;
      // sheet1.getRangeByName('X${index + 1}').cellStyle = globalStyle220;
      // sheet1.getRangeByName('Y${index + 1}').cellStyle = globalStyle220;

      ///////////////-------------------------->

      sheet2.getRangeByName('A${index + 1}').cellStyle = globalStyle220;
      sheet2.getRangeByName('B${index + 1}').cellStyle = globalStyle220;
      sheet2.getRangeByName('C${index + 1}').cellStyle = globalStyle220;
      sheet2.getRangeByName('D${index + 1}').cellStyle = globalStyle220;
      sheet2.getRangeByName('E${index + 1}').cellStyle = globalStyle220;
      sheet2.getRangeByName('F${index + 1}').cellStyle = globalStyle220;
      sheet2.getRangeByName('G${index + 1}').cellStyle = globalStyle220;
      sheet2.getRangeByName('H${index + 1}').cellStyle = globalStyle220;
      sheet2.getRangeByName('I${index + 1}').cellStyle = globalStyle220;

      sheet2.getRangeByName('J${index + 1}').cellStyle = globalStyle220;
      sheet2.getRangeByName('K${index + 1}').cellStyle = globalStyle220;

      ///////////////-------------------------->

      sheet3.getRangeByName('A${index + 1}').cellStyle = globalStyle220;
      sheet3.getRangeByName('B${index + 1}').cellStyle = globalStyle220;
      sheet3.getRangeByName('C${index + 1}').cellStyle = globalStyle220;
      sheet3.getRangeByName('D${index + 1}').cellStyle = globalStyle220;
      sheet3.getRangeByName('E${index + 1}').cellStyle = globalStyle220;
      sheet3.getRangeByName('F${index + 1}').cellStyle = globalStyle220;
      sheet3.getRangeByName('G${index + 1}').cellStyle = globalStyle220;
      sheet3.getRangeByName('H${index + 1}').cellStyle = globalStyle220;
      sheet3.getRangeByName('I${index + 1}').cellStyle = globalStyle220;

      ///////////////-------------------------->

      // sheet4.getRangeByName('A${index + 1}').cellStyle = globalStyle220;
      // sheet4.getRangeByName('B${index + 1}').cellStyle = globalStyle220;
      // sheet4.getRangeByName('C${index + 1}').cellStyle = globalStyle220;
      // sheet4.getRangeByName('D${index + 1}').cellStyle = globalStyle220;
      // sheet4.getRangeByName('E${index + 1}').cellStyle = globalStyle220;
      // sheet4.getRangeByName('F${index + 1}').cellStyle = globalStyle220;
      // sheet4.getRangeByName('G${index + 1}').cellStyle = globalStyle220;
      // sheet4.getRangeByName('H${index + 1}').cellStyle = globalStyle220;
      // sheet4.getRangeByName('I${index + 1}').cellStyle = globalStyle220;

      // ///////////////-------------------------->

      // sheet5.getRangeByName('A${index + 1}').cellStyle = globalStyle220;
      // sheet5.getRangeByName('B${index + 1}').cellStyle = globalStyle220;
      // sheet5.getRangeByName('C${index + 1}').cellStyle = globalStyle220;
      // sheet5.getRangeByName('D${index + 1}').cellStyle = globalStyle220;
      // sheet5.getRangeByName('E${index + 1}').cellStyle = globalStyle220;
      // sheet5.getRangeByName('F${index + 1}').cellStyle = globalStyle220;
      // sheet5.getRangeByName('G${index + 1}').cellStyle = globalStyle220;
      // sheet5.getRangeByName('H${index + 1}').cellStyle = globalStyle220;
      // sheet5.getRangeByName('I${index + 1}').cellStyle = globalStyle220;

      // ///////////////-------------------------->

      // sheet6.getRangeByName('A${index + 1}').cellStyle = globalStyle220;
      // sheet6.getRangeByName('B${index + 1}').cellStyle = globalStyle220;
      // sheet6.getRangeByName('C${index + 1}').cellStyle = globalStyle220;
      // sheet6.getRangeByName('D${index + 1}').cellStyle = globalStyle220;
      // sheet6.getRangeByName('E${index + 1}').cellStyle = globalStyle220;
      // sheet6.getRangeByName('F${index + 1}').cellStyle = globalStyle220;
      // sheet6.getRangeByName('G${index + 1}').cellStyle = globalStyle220;
      // sheet6.getRangeByName('H${index + 1}').cellStyle = globalStyle220;
      // sheet5.getRangeByName('I${index + 1}').cellStyle = globalStyle220;
    }

    globalStyle2.hAlign = x.HAlignType.center;
    sheet1.getRangeByName('A6').cellStyle = globalStyle1;
    sheet1.getRangeByName('B6').cellStyle = globalStyle1;
    sheet1.getRangeByName('C6').cellStyle = globalStyle1;
    sheet1.getRangeByName('D6').cellStyle = globalStyle1;
    sheet1.getRangeByName('E6').cellStyle = globalStyle1;
    sheet1.getRangeByName('F6').cellStyle = globalStyle1;
    sheet1.getRangeByName('G6').cellStyle = globalStyle1;
    sheet1.getRangeByName('H6').cellStyle = globalStyle1;
    sheet1.getRangeByName('I6').cellStyle = globalStyle1;
    sheet1.getRangeByName('J6').cellStyle = globalStyle1;
    sheet1.getRangeByName('K6').cellStyle = globalStyle1;
    sheet1.getRangeByName('L6').cellStyle = globalStyle1;
    sheet1.getRangeByName('M6').cellStyle = globalStyle1;
    sheet1.getRangeByName('N6').cellStyle = globalStyle1;
    sheet1.getRangeByName('O6').cellStyle = globalStyle1;
    sheet1.getRangeByName('P6').cellStyle = globalStyle1;
    sheet1.getRangeByName('Q6').cellStyle = globalStyle1;
    sheet1.getRangeByName('R6').cellStyle = globalStyle1;
    sheet1.getRangeByName('S6').cellStyle = globalStyle1;
    sheet1.getRangeByName('T6').cellStyle = globalStyle1;
    sheet1.getRangeByName('U6').cellStyle = globalStyle1;
    sheet1.getRangeByName('V6').cellStyle = globalStyle1;
    // sheet1.getRangeByName('W6').cellStyle = globalStyle1;
    // sheet1.getRangeByName('X6').cellStyle = globalStyle1;
    // sheet1.getRangeByName('Y6').cellStyle = globalStyle1;

    sheet1.getRangeByName('A6').columnWidth = 10;
    sheet1.getRangeByName('B6').columnWidth = 20;
    sheet1.getRangeByName('C6').columnWidth = 20;
    sheet1.getRangeByName('D6').columnWidth = 25;
    sheet1.getRangeByName('E6').columnWidth = 25;
    sheet1.getRangeByName('F6').columnWidth = 25;
    sheet1.getRangeByName('G6').columnWidth = 25;
    sheet1.getRangeByName('H6').columnWidth = 30;
    sheet1.getRangeByName('I6').columnWidth = 25;
    sheet1.getRangeByName('J6').columnWidth = 25;
    sheet1.getRangeByName('K6').columnWidth = 25;
    sheet1.getRangeByName('L6').columnWidth = 25;
    sheet1.getRangeByName('M6').columnWidth = 25;
    sheet1.getRangeByName('N6').columnWidth = 25;
    sheet1.getRangeByName('O6').columnWidth = 25;
    sheet1.getRangeByName('P6').columnWidth = 25;
    sheet1.getRangeByName('Q6').columnWidth = 25;
    sheet1.getRangeByName('R6').columnWidth = 25;
    sheet1.getRangeByName('S6').columnWidth = 25;
    sheet1.getRangeByName('T6').columnWidth = 25;
    sheet1.getRangeByName('U6').columnWidth = 25;
    sheet1.getRangeByName('V6').columnWidth = 25;
    // sheet1.getRangeByName('W6').columnWidth = 25;
    // sheet1.getRangeByName('X6').columnWidth = 25;
    // sheet1.getRangeByName('Y6').columnWidth = 25;

    sheet1.getRangeByName('A6').setText('ลำดับที่');
    sheet1.getRangeByName('B6').setText('วันที่');
    sheet1.getRangeByName('C6').setText('เลขใบกำกับภาษี');
    sheet1.getRangeByName('D6').setText('รายชื่อลูกค้า');
    sheet1.getRangeByName('E6').setText('สาขา');
    sheet1.getRangeByName('F6').setText('เลขประจำตัวผู้เสียภาษี');
    sheet1.getRangeByName('G6').setText('เงินประกัน');
    sheet1.getRangeByName('H6').setText('ภาษีมูลค่าเพิ่ม 7% (เงินประกัน)');
    sheet1.getRangeByName('I6').setText('รวมเงินประกัน');
    sheet1.getRangeByName('J6').setText('ค่าเช่า');
    sheet1.getRangeByName('K6').setText('ภาษีมูลค่าเพิ่ม 7% (ค่าเช่า)');
    sheet1.getRangeByName('L6').setText('รวมค่าเช่า');

    sheet1.getRangeByName('M6').setText('ค่าบริการพื้นที่');
    sheet1
        .getRangeByName('N6')
        .setText('ภาษีมูลค่าเพิ่ม 7% (ค่าบริการพื้นที่)');
    sheet1.getRangeByName('O6').setText('รวมค่าบริการพื้นที่');

    sheet1.getRangeByName('P6').setText('ค่าอุปกรณ์');
    sheet1.getRangeByName('Q6').setText('ภาษีมูลค่าเพิ่ม 7% (ค่าอุปกรณ์)');
    sheet1.getRangeByName('R6').setText('รวมค่าอุปกรณ์');

    sheet1.getRangeByName('S6').setText('ค่าเช่ารับล่วงหน้า');
    sheet1.getRangeByName('T6').setText('ค่าบริการล่วงหน้า');

    sheet1.getRangeByName('U6').setText('จำนวนเงินรวมทั้งสิ้น');

    sheet1.getRangeByName('V6').setText('วันเริ่มต้นสัญญา');
    // sheet1.getRangeByName('V6').setText('');
    // sheet1.getRangeByName('W6').setText('');

    // sheet1.getRangeByName('X6').setText('');
    // sheet1.getRangeByName('Y6').setText('');
//////////-------------------------------------------------->
    sheet2.getRangeByName('A6').cellStyle = globalStyle1;
    sheet2.getRangeByName('B6').cellStyle = globalStyle1;
    sheet2.getRangeByName('C6').cellStyle = globalStyle1;
    sheet2.getRangeByName('D6').cellStyle = globalStyle1;
    sheet2.getRangeByName('E6').cellStyle = globalStyle1;
    sheet2.getRangeByName('F6').cellStyle = globalStyle1;
    sheet2.getRangeByName('G6').cellStyle = globalStyle1;
    sheet2.getRangeByName('H6').cellStyle = globalStyle1;
    sheet2.getRangeByName('I6').cellStyle = globalStyle1;
    sheet2.getRangeByName('J6').cellStyle = globalStyle1;
    sheet2.getRangeByName('K6').cellStyle = globalStyle1;
    sheet2.getRangeByName('A6').columnWidth = 10;
    sheet2.getRangeByName('B6').columnWidth = 20;
    sheet2.getRangeByName('C6').columnWidth = 20;
    sheet2.getRangeByName('D6').columnWidth = 25;
    sheet2.getRangeByName('E6').columnWidth = 25;
    sheet2.getRangeByName('F6').columnWidth = 25;
    sheet2.getRangeByName('G6').columnWidth = 25;
    sheet2.getRangeByName('H6').columnWidth = 30;
    sheet2.getRangeByName('I6').columnWidth = 25;
    sheet2.getRangeByName('J6').columnWidth = 25;
    sheet2.getRangeByName('K6').columnWidth = 25;

    sheet2.getRangeByName('A6').setText('ลำดับที่');
    sheet2.getRangeByName('B6').setText('วันที่');
    sheet2.getRangeByName('C6').setText('เลขใบกำกับภาษี');
    sheet2.getRangeByName('D6').setText('รายชื่อลูกค้า');
    sheet2.getRangeByName('E6').setText('ชื่อสาขา');
    sheet2.getRangeByName('F6').setText('เลขประจำตัวผู้เสียภาษี');
    sheet2.getRangeByName('G6').setText('ค่าเช่า');
    sheet2.getRangeByName('H6').setText('ภาษีมูลค่าเพิ่ม 7%(ค่าเช่า)');
    sheet2.getRangeByName('I6').setText('ค่าบริการพื้นที่');
    sheet2.getRangeByName('J6').setText('ภาษีมูลค่าเพิ่ม 7%(ค่าบริการพื้นที่)');
    sheet2.getRangeByName('K6').setText(' จำนวนเงินรวม ');
//////////-------------------------------------------------->
    sheet3.getRangeByName('A6').cellStyle = globalStyle1;
    sheet3.getRangeByName('B6').cellStyle = globalStyle1;
    sheet3.getRangeByName('C6').cellStyle = globalStyle1;
    sheet3.getRangeByName('D6').cellStyle = globalStyle1;
    sheet3.getRangeByName('E6').cellStyle = globalStyle1;
    sheet3.getRangeByName('F6').cellStyle = globalStyle1;
    sheet3.getRangeByName('G6').cellStyle = globalStyle1;
    sheet3.getRangeByName('H6').cellStyle = globalStyle1;
    sheet3.getRangeByName('I6').cellStyle = globalStyle1;

    sheet3.getRangeByName('A6').columnWidth = 10;
    sheet3.getRangeByName('B6').columnWidth = 20;
    sheet3.getRangeByName('C6').columnWidth = 20;
    sheet3.getRangeByName('D6').columnWidth = 25;
    sheet3.getRangeByName('E6').columnWidth = 25;
    sheet3.getRangeByName('F6').columnWidth = 25;
    sheet3.getRangeByName('G6').columnWidth = 25;
    sheet3.getRangeByName('H6').columnWidth = 30;
    sheet3.getRangeByName('I6').columnWidth = 25;

    sheet3.getRangeByName('A6').setText('ลำดับที่');
    sheet3.getRangeByName('B6').setText('วันที่');
    sheet3.getRangeByName('C6').setText('เลขใบกำกับภาษี');
    sheet3.getRangeByName('D6').setText('รายชื่อลูกค้า');
    sheet3.getRangeByName('E6').setText('ชื่อสาขา');
    sheet3.getRangeByName('F6').setText('เลขประจำตัวผู้เสียภาษี');
    sheet3.getRangeByName('G6').setText('ผ้ากันเปื้อน');
    sheet3.getRangeByName('H6').setText('ภาษีมูลค่าเพิ่ม 7%(ผ้ากันเปื้อน)');
    sheet3.getRangeByName('I6').setText('จำนวนเงินรวม');

//////////-------------------------------------------------->
    int index1 = 0;
    int indextotol = 0;
    int indextotol_sheet2 = 0;
    List cid_number = [];

    for (int index = 0; index < teNantModels_New.length; index++) {
      dynamic numberColor = ((index % 2) == 0) ? globalStyle22 : globalStyle222;
      sheet1.getRangeByName('A${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('B${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('C${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('D${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('E${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('F${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('G${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('H${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('I${index + 7}').cellStyle = numberColor;

      sheet1.getRangeByName('J${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('K${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('L${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('M${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('N${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('O${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('P${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('Q${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('R${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('S${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('T${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('U${index + 7}').cellStyle = numberColor;
      sheet1.getRangeByName('V${index + 7}').cellStyle = numberColor;
      // sheet1.getRangeByName('W${index + 7}').cellStyle = numberColor;
      // sheet1.getRangeByName('X${index + 7}').cellStyle = numberColor;
      // sheet1.getRangeByName('Y${index + 7}').cellStyle = numberColor;

      sheet1.getRangeByName('A${index + 7}').setText('${index + 1}');
      sheet1.getRangeByName('B${index + 7}').setText(
            (teNantModels_New[index].datex == null ||
                    teNantModels_New[index].datex.toString() == '')
                ? ''
                : '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${teNantModels_New[index].datex}'))}',
          );
      sheet1.getRangeByName('C${index + 7}').setText(
            (teNantModels_New[index].doctax == null ||
                    teNantModels_New[index].doctax.toString() == '')
                ? (teNantModels_New[index].docno == null ||
                        teNantModels_New[index].docno.toString() == '')
                    ? ''
                    : '${teNantModels_New[index].docno}'
                : '${teNantModels_New[index].doctax}',
          );
      sheet1.getRangeByName('D${index + 7}').setText(
            (teNantModels_New[index].cname != null)
                ? '${teNantModels_New[index].cname}'
                : '${teNantModels_New[index].remark}',
          );

      sheet1.getRangeByName('E${index + 7}').setText(
            (teNantModels_New[index].zn != null)
                ? '${teNantModels_New[index].zn}'
                : '${teNantModels_New[index].znn}',
          );

      sheet1.getRangeByName('F${index + 7}').setText(
            (teNantModels_New[index].tax != null)
                ? '${teNantModels_New[index].tax}'
                : '',
          );

      sheet1.getRangeByName('G${index + 7}').setNumber(
          (teNantModels_New[index].pvat_pakan == null ||
                  teNantModels_New[index].pvat_pakan.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].pvat_pakan}'));

      sheet1.getRangeByName('H${index + 7}').setNumber(
          (teNantModels_New[index].pakan_vat == null ||
                  teNantModels_New[index].pakan_vat.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].pakan_vat}'));

      sheet1.getRangeByName('I${index + 7}').setNumber(
          (teNantModels_New[index].total_pakan == null ||
                  teNantModels_New[index].total_pakan.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].total_pakan}'));

      sheet1.getRangeByName('J${index + 7}').setNumber(
          (teNantModels_New[index].rent_pvat == null ||
                  teNantModels_New[index].rent_pvat.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].rent_pvat}'));
      sheet1.getRangeByName('K${index + 7}').setNumber(
          (teNantModels_New[index].rent_vat == null ||
                  teNantModels_New[index].rent_vat.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].rent_vat}'));
      sheet1.getRangeByName('L${index + 7}').setNumber(
          (teNantModels_New[index].rent_total == null ||
                  teNantModels_New[index].rent_total.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].rent_total}'));

      sheet1.getRangeByName('M${index + 7}').setNumber(
          (teNantModels_New[index].service_pvat == null ||
                  teNantModels_New[index].service_pvat.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].service_pvat}'));

      sheet1.getRangeByName('N${index + 7}').setNumber(
          (teNantModels_New[index].service_vat == null ||
                  teNantModels_New[index].service_vat.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].service_vat}'));

      sheet1.getRangeByName('O${index + 7}').setNumber(
          (teNantModels_New[index].service_total == null ||
                  teNantModels_New[index].service_total.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].service_total}'));
      sheet1.getRangeByName('P${index + 7}').setNumber(
          (teNantModels_New[index].equip_pvat == null ||
                  teNantModels_New[index].equip_pvat.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].equip_pvat}'));

      //---
      sheet1.getRangeByName('Q${index + 7}').setNumber(
          (teNantModels_New[index].equip_vat == null ||
                  teNantModels_New[index].equip_vat.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].equip_vat}'));

      sheet1.getRangeByName('R${index + 7}').setNumber(
          (teNantModels_New[index].equip_total == null ||
                  teNantModels_New[index].equip_total.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].equip_total}'));
      sheet1.getRangeByName('S${index + 7}').setNumber(
          (teNantModels_New[index].rent_total_future == null ||
                  teNantModels_New[index].rent_total_future.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].rent_total_future}'));
      sheet1.getRangeByName('T${index + 7}').setNumber((teNantModels_New[index]
                      .service_total_future ==
                  null ||
              teNantModels_New[index].service_total_future.toString() == '')
          ? 0.00
          : double.parse('${teNantModels_New[index].service_total_future}'));

      sheet1.getRangeByName('U${index + 7}').setNumber(
          (teNantModels_New[index].total_bill == null ||
                  teNantModels_New[index].total_bill.toString() == '')
              ? 0.00
              : double.parse('${teNantModels_New[index].total_bill}'));
      sheet1.getRangeByName('V${index + 7}').setText((teNantModels_New[index]
                      .sdate !=
                  null ||
              teNantModels_New[index].sdate.toString() != '')
          ? '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${teNantModels_New[index].sdate}'))}'
          : 'ล็อกเสียบ');

      indextotol = indextotol + 1;
    }

    for (int index = 0; index < teNantModels_New.length; index++) {
      // Choose style based on index
      dynamic numberColor = ((index % 2) == 0) ? globalStyle22 : globalStyle222;

      sheet2.getRangeByName('A${index + 7}').cellStyle = numberColor;
      sheet2.getRangeByName('B${index + 7}').cellStyle = numberColor;
      sheet2.getRangeByName('C${index + 7}').cellStyle = numberColor;
      sheet2.getRangeByName('D${index + 7}').cellStyle = numberColor;
      sheet2.getRangeByName('E${index + 7}').cellStyle = numberColor;
      sheet2.getRangeByName('F${index + 7}').cellStyle = numberColor;
      sheet2.getRangeByName('G${index + 7}').cellStyle = numberColor;
      sheet2.getRangeByName('H${index + 7}').cellStyle = numberColor;
      sheet2.getRangeByName('I${index + 7}').cellStyle = numberColor;

      sheet2.getRangeByName('J${index + 7}').cellStyle = numberColor;
      sheet2.getRangeByName('K${index + 7}').cellStyle = numberColor;

      sheet2
          .getRangeByName('A${index + 7}')
          .setText(sheet1.getRangeByName('A${index + 7}').text);

      sheet2
          .getRangeByName('B${index + 7}')
          .setText(sheet1.getRangeByName('B${index + 7}').text);
      sheet2
          .getRangeByName('C${index + 7}')
          .setText(sheet1.getRangeByName('C${index + 7}').text);
      sheet2
          .getRangeByName('D${index + 7}')
          .setText(sheet1.getRangeByName('D${index + 7}').text);
      sheet2
          .getRangeByName('E${index + 7}')
          .setText(sheet1.getRangeByName('E${index + 7}').text);
      sheet2
          .getRangeByName('F${index + 7}')
          .setText(sheet1.getRangeByName('F${index + 7}').text);
      //////////------------------->
      sheet2
          .getRangeByName('G${index + 7}')
          .setNumber(sheet1.getRangeByName('J${index + 7}').number);
      sheet2
          .getRangeByName('H${index + 7}')
          .setNumber(sheet1.getRangeByName('K${index + 7}').number);

      sheet2
          .getRangeByName('I${index + 7}')
          .setNumber(sheet1.getRangeByName('M${index + 7}').number);
      sheet2
          .getRangeByName('J${index + 7}')
          .setNumber(sheet1.getRangeByName('N${index + 7}').number);
      sheet2
          .getRangeByName('K${index + 7}')
          .setFormula('=SUM(G${index + 7}:J${index + 7})');
      indextotol_sheet2 = indextotol_sheet2 + 1;
    }
    for (int index = 0; index < teNantModels_New.length; index++) {
      // Choose style based on index
      dynamic numberColor = ((index % 2) == 0) ? globalStyle22 : globalStyle222;

      sheet3.getRangeByName('A${index + 7}').cellStyle = numberColor;
      sheet3.getRangeByName('B${index + 7}').cellStyle = numberColor;
      sheet3.getRangeByName('C${index + 7}').cellStyle = numberColor;
      sheet3.getRangeByName('D${index + 7}').cellStyle = numberColor;
      sheet3.getRangeByName('E${index + 7}').cellStyle = numberColor;
      sheet3.getRangeByName('F${index + 7}').cellStyle = numberColor;
      sheet3.getRangeByName('G${index + 7}').cellStyle = numberColor;
      sheet3.getRangeByName('H${index + 7}').cellStyle = numberColor;
      sheet3.getRangeByName('I${index + 7}').cellStyle = numberColor;

      sheet3
          .getRangeByName('A${index + 7}')
          .setText(sheet1.getRangeByName('A${index + 7}').text);

      sheet3
          .getRangeByName('B${index + 7}')
          .setText(sheet1.getRangeByName('B${index + 7}').text);
      sheet3
          .getRangeByName('C${index + 7}')
          .setText(sheet1.getRangeByName('C${index + 7}').text);
      sheet3
          .getRangeByName('D${index + 7}')
          .setText(sheet1.getRangeByName('D${index + 7}').text);
      sheet3
          .getRangeByName('E${index + 7}')
          .setText(sheet1.getRangeByName('E${index + 7}').text);
      sheet3
          .getRangeByName('F${index + 7}')
          .setText(sheet1.getRangeByName('F${index + 7}').text);
      //////////------------------->
      sheet3
          .getRangeByName('G${index + 7}')
          .setNumber(sheet1.getRangeByName('P${index + 7}').number);
      sheet3
          .getRangeByName('H${index + 7}')
          .setNumber(sheet1.getRangeByName('Q${index + 7}').number);

      sheet3
          .getRangeByName('I${index + 7}')
          .setFormula('=SUM(G${index + 7}:H${index + 7})');

      indextotol_sheet2 = indextotol_sheet2 + 1;
    }
/////////---------------------------->
    //sheet1.getRangeByName('M${indextotol + 3 + 0}').setText('รวมทั้งหมด: ');
    // sheet
    //     .getRangeByName('N${indextotol + 3 + 0}')
    //     .setFormula('=SUM(N3:N${indextotol + 3 - 1})');
    // sheet
    //     .getRangeByName('O${indextotol + 3 + 0}')
    //     .setFormula('=SUM(O3:O${indextotol + 3 - 1})');
    // sheet
    //     .getRangeByName('P${indextotol + 3 + 0}')
    //     .setFormula('=SUM(P3:P${indextotol + 3 - 1})');
    // sheet
    //     .getRangeByName('Q${indextotol + 3 + 0}')
    //     .setFormula('=SUM(Q3:Q${indextotol + 3 - 1})');

    //sheet1.getRangeByName('M${indextotol + 3 + 0}').cellStyle = globalStyle7;
    //sheet1.getRangeByName('N${indextotol + 3 + 0}').cellStyle = globalStyle7;
    //sheet1.getRangeByName('O${indextotol + 3 + 0}').cellStyle = globalStyle7;
    //sheet1.getRangeByName('P${indextotol + 3 + 0}').cellStyle = globalStyle7;
    //sheet1.getRangeByName('Q${indextotol + 3 + 0}').cellStyle = globalStyle7;

/////////---------------------------->
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    String path = await FileSaver.instance.saveFile(
        (Value_Chang_Zone_People_TeNantNew == null)
            ? 'รายงานผู้เช่ารายใหม่-2 ประจำเดือน ${Mon_PeopleTeNantNew_Mon} ${YE_PeopleTeNantNew_Mon} (กรุณาเลือกโซน)'
            : 'รายงานผู้เช่ารายใหม่-2 ประจำเดือน ${Mon_PeopleTeNantNew_Mon} ${YE_PeopleTeNantNew_Mon} (โซน : $Value_Chang_Zone_People_TeNantNew)',
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
