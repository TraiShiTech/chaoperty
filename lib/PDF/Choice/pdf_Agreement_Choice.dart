import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../PeopleChao/Rental_Information.dart';
import '../../../../Style/ThaiBaht.dart';
import '../../Constant/Myconstant.dart';
import '../../Style/loadAndCacheImage.dart';

class Pdfgen_Agreement_Choice {
//////////---------------------------------------------------->( **** เอกสารสัญญาเช่า  Choice)

  static void exportPDF_Agreement_Choice(
    context,
    Get_Value_NameShop_index,
    Get_Value_cid,
    _verticalGroupValue,
    Form_nameshop,
    Form_typeshop,
    Form_bussshop,
    Form_bussscontact,
    Form_address,
    Form_tel,
    Form_email,
    Form_tax,
    Form_ln,
    Form_zn,
    Form_area,
    Form_qty,
    Form_sdate,
    Form_ldate,
    Form_period,
    Form_rtname,
    quotxSelectModels,
    _TransModels,
    renTal_name,
    bill_addr,
    bill_email,
    bill_tel,
    bill_tax,
    bill_name,
    newValuePDFimg,
    tableData00,
    TitleType_Default_Receipt_Name,
    Datex_text,
    _ReportValue_type_docOttor,
    Form_fid,
    Form_renew_cid,
    Form_PakanSdate,
    Form_PakanLdate,
    Form_PakanSdate_Doc,
    Form_PakanLdate_Doc,
    Form_PakanAll_amt,
    Form_PakanAll_pvat,
    Form_PakanAll_vat,
    Form_PakanAll_Total,
  ) async {
    ////
    //// ------------>(J Space Sansai)
    ///////
    final pdf = pw.Document();
    // final fontData = await rootBundle.load("ThaiFonts/Sarabun-Medium.ttf");
    // var dataint = fontData.buffer
    //     .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    // final PdfFont font = PdfFont.of(pdf, data: dataint);
    final font = await rootBundle.load("fonts/THSarabunNew.ttf");
    var Colors_pd = PdfColors.black;
    var Colors_pd2 = PdfColors.grey;
    final ttf = pw.Font.ttf(font);
    double font_Size = 13.5;
    int space_Size = 10;
    DateTime date = DateTime.now();
    // var formatter = DateFormat('MMMMd', 'th');
    String thaiDate = DateFormat('d เดือน MMM', 'th').format(date);
    var nFormat = NumberFormat("#,##0.00", "en_US");
    var nFormat2 = NumberFormat("###0.00", "en_US");
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    final ByteData image = await rootBundle.load('images/image7-11.png');
    final ByteData BG_PDF = await rootBundle.load('images/Choice_BG_PDF.png');
    final ByteData LG_PDF = await rootBundle.load('images/choice_logo2.png');
    Uint8List imageData = (image).buffer.asUint8List();
    Uint8List imageBG = (BG_PDF).buffer.asUint8List();
    Uint8List imageLG = (LG_PDF).buffer.asUint8List();
    // List netImage = [];
    // List signature_Image1 = [];
    // List signature_Image2 = [];
    // List signature_Image3 = [];
    // List signature_Image4 = [];
    List footImage = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int pageCount = 1; // Initialize the page count

    // String? base64Image_3 = preferences.getString('base64Image3');
    // String? base64Image_4 = preferences.getString('base64Image4');
    // String base64Image_new1 = (base64Image_1 == null) ? '' : base64Image_1;
    List newValuePDFimg2 = [
      'https://img.wongnai.com/p/1920x0/2022/05/10/ad606822c67d4c08a2bc6b5125be3861.jpg'
    ];

    // String base64Image_new3 = (base64Image_3 == null) ? '' : base64Image_3;
    // String base64Image_new4 = (base64Image_4 == null) ? '' : base64Image_4;
    // Uint8List data1 = base64Decode(base64Image_new2);
    // Uint8List data2 = base64Decode(base64Image_new2);
    // Uint8List data3 = base64Decode(base64Image_new3);
    // Uint8List data4 = base64Decode(base64Image_new4);
    Uint8List? resizedLogo = await getResizedLogo();
    // for (int i = 0; i < newValuePDFimg.length; i++) {
    //   netImage.add(await networkImage('${newValuePDFimg[i]}'));
    // }
    ////////////--------------------->
    // for (int i = 0; i < newValuePDFimg2.length; i++) {
    //   signature_Image1.add(await networkImage('${newValuePDFimg2[i]}'));
    // }
    // for (int i = 0; i < newValuePDFimg.length; i++) {
    //   signature_Image2.add(await networkImage('${newValuePDFimg[i]}'));
    // }
    // for (int i = 0; i < newValuePDFimg.length; i++) {
    //   signature_Image3.add(await networkImage('${newValuePDFimg[i]}'));
    // }
    // for (int i = 0; i < newValuePDFimg.length; i++) {
    //   signature_Image4.add(await networkImage('${newValuePDFimg[i]}'));
    // }
    var licence_name1 = 'สิริกร พรหมปัญญา';
    var licence_name2 = 'สิริกร พรหมปัญญา';
    var licence_name3 = 'สิริกร พรหมปัญญา';
    var licence_name4 = 'สิริกร พรหมปัญญา';
    var refid = 'LLJZX20241';

    // final signature_Image1 = await loadAndCacheImage(
    //     '${MyConstant().domain}/gen_licence_img.php?isAdd=true&ren=50&ref_id=$refid&name_id=$licence_name1&doc_id=$Get_Value_cid&extension=.png');
    // final signature_Image2 = await loadAndCacheImage(
    //     '${MyConstant().domain}/gen_licence_img.php?isAdd=true&ren=50&ref_id=$refid&name_id=$licence_name2&doc_id=$Get_Value_cid&extension=.png');
    // final signature_Image3 = await loadAndCacheImage(
    //     '${MyConstant().domain}/gen_licence_img.php?isAdd=true&ren=50&ref_id=$refid&name_id=$licence_name2&doc_id=$Get_Value_cid&extension=.png');
    // final signature_Image4 = await loadAndCacheImage(
    //     '${MyConstant().domain}/gen_licence_img.php?isAdd=true&ren=50&ref_id=$refid&name_id=$licence_name2&doc_id=$Get_Value_cid&extension=.png');

    // final tableData = [
    //   for (int index = 0; index < quotxSelectModels.length; index++)
    //     [
    //       '${nFormat.format(int.parse(quotxSelectModels[index].term!) * double.parse(quotxSelectModels[index].total!))}',
    //     ],
    // ];
    // double Sumtotal = 0;
    // for (int index = 0; index < quotxSelectModels.length; index++)
    //   Sumtotal = Sumtotal +
    //       (int.parse(quotxSelectModels[index].term!) *
    //           double.parse(quotxSelectModels[index].total!));
    String Howday = (Form_rtname.toString() == 'รายวัน')
        ? 'วัน'
        : (Form_rtname.toString() == 'รายเดือน')
            ? 'เดือน'
            : (Form_rtname.toString() == 'รายปี')
                ? 'ปี'
                : '$Form_rtname';
    double widths = await MediaQuery.of(context).size.width;
    int pange = 1;
    List<double> data2 = [0.00, 0.00, 0.00];
    String Rent_List = quotxSelectModels
        .where((e) =>
            e.expser.toString() == '1' &&
            // e.unitser.toString() == '1' &&
            e.amt_ty.toString() != '')
        .map((e) => e.amt_ty)
        .toString();

    // Step 1: Remove parentheses
    Rent_List = Rent_List.replaceAll('(', '').replaceAll(')', '');

    // Step 2: Split the string by commas
    List<String> rentStringList = Rent_List.split(',');

    // Step 3: Convert the list of strings to a list of doubles
    List<double> rentList =
        (rentStringList.map((e) => double.parse(e)).toList() == 0)
            ? data2
            : rentStringList.map((e) => double.parse(e)).toList();

///////////////////////------------------------------------------------->
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 5.00,
          marginLeft: 0.00,
          marginRight: 0.00,
          marginTop: 0.00,
        ),
        header: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Container(
                width: PdfPageFormat.a4.width + 100,
                color: PdfColors.green900,
                height: 10,
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Row(
                children: [
                  pw.Container(
                    width: 30,
                    height: 10,
                  ),
                  pw.Container(
                    height: 70,
                    width: 75,
                    decoration: (resizedLogo != null)
                        ? null
                        : pw.BoxDecoration(
                            color: PdfColors.grey200,
                            border: pw.Border.all(color: PdfColors.grey300),
                          ),
                    child: resizedLogo != null
                        ? pw.Image(
                            pw.MemoryImage(resizedLogo),
                            height: 70,
                            width: 75,
                          )
                        : pw.Center(
                            child: pw.Text(
                              '$bill_name ',
                              maxLines: 1,
                              style: pw.TextStyle(
                                fontSize: 10,
                                font: ttf,
                                color: Colors_pd,
                              ),
                            ),
                          ),
                  ),
                  // pw.Container(
                  //   height: 60,
                  //   width: 60,
                  //   decoration: pw.BoxDecoration(
                  //     color: PdfColors.grey200,
                  //     border: pw.Border.all(color: PdfColors.grey300),
                  //   ),
                  //   child: resizedLogo != null
                  //       ? pw.Image(
                  //           pw.MemoryImage(resizedLogo),
                  //           height: 60,
                  //           width: 60,
                  //         )
                  //       : pw.Center(
                  //           child: pw.Text(
                  //             '$bill_name ',
                  //             maxLines: 1,
                  //             style: pw.TextStyle(
                  //               fontSize: 10,
                  //               font: ttf,
                  //               color: Colors_pd,
                  //             ),
                  //           ),
                  //         ),
                  // ),
                  // (netImage.isEmpty)
                  //     ? pw.Container(
                  //         height: 72,
                  //         width: 70,
                  //         color: PdfColors.grey200,
                  //         child: pw.Center(
                  //           child: pw.Text(
                  //             '$renTal_name ',
                  //             maxLines: 1,
                  //             style: pw.TextStyle(
                  //               fontSize: 10,
                  //               font: ttf,
                  //               color: Colors_pd,
                  //             ),
                  //           ),
                  //         ))

                  //     // pw.Image(
                  //     //     pw.MemoryImage(iconImage),
                  //     //     height: 72,
                  //     //     width: 70,
                  //     //   )
                  //     : pw.Image(
                  //         (netImage[0]),
                  //         height: 72,
                  //         width: 70,
                  //       ),
                  pw.SizedBox(width: 1 * PdfPageFormat.mm),
                  pw.Container(
                    width: 350,
                    child: pw.Column(
                      mainAxisSize: pw.MainAxisSize.min,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          '${bill_name.toString().trim()}',
                          maxLines: 2,
                          style: pw.TextStyle(
                            fontSize: font_Size,
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                          ),
                        ),
                        pw.Text(
                          '${bill_addr.toString().trim()}',
                          maxLines: 3,
                          style: pw.TextStyle(
                            fontSize: font_Size,
                            color: Colors_pd,
                            font: ttf,
                          ),
                        ),
                        pw.Text(
                          'เลขประจำตัวผู้เสียภาษี : $bill_tax',
                          maxLines: 2,
                          style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: Colors_pd,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Spacer(),
                  if (TitleType_Default_Receipt_Name != null &&
                      TitleType_Default_Receipt_Name.toString().trim() != '')
                    pw.Container(
                      width: 80,
                      decoration: pw.BoxDecoration(
                        // color: PdfColors.grey400,
                        borderRadius: pw.BorderRadius.only(
                            topLeft: pw.Radius.circular(10),
                            topRight: pw.Radius.circular(10),
                            bottomLeft: pw.Radius.circular(10),
                            bottomRight: pw.Radius.circular(10)),
                        border:
                            pw.Border.all(color: PdfColors.grey400, width: 1),
                      ),
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Center(
                        child: pw.Text(
                          '$TitleType_Default_Receipt_Name',
                          maxLines: 1,
                          style: pw.TextStyle(
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                            color: PdfColors.grey400,
                          ),
                        ),
                      ),
                    ),
                  if (TitleType_Default_Receipt_Name != null &&
                      TitleType_Default_Receipt_Name.toString().trim() != '')
                    pw.Spacer(),
                ],
              ),
              // pw.Text(
              //   'Header - Page ${context.pageNumber} of ${context.pagesCount}',
              //   style:
              //       pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              // ),
              // pw.SizedBox(height: 1 * PdfPageFormat.mm),
              // pw.Divider(height: 2),
              // pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  (context.pageNumber.toString() == '1')
                      ? pw.Text(
                          'สัญญาเช่าพื้นที่',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            color: Colors_pd,
                            fontSize: font_Size,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                          ),
                        )
                      : pw.Text(
                          '${context.pageNumber} / ${context.pagesCount}',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            color: Colors_pd,
                            fontSize: font_Size,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                          ),
                        ),
                ],
              ),
              pw.Container(
                width: PdfPageFormat.a4.width,
                padding: pw.EdgeInsets.fromLTRB(70, 0, 50, 0),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    if (context.pageNumber.toString() == '1')
                      pw.Text(
                        '$Form_zn',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                    pw.Spacer(),
                    pw.Text(
                      'สัญญาเลขที่  $Get_Value_cid',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
            ],
          );
        },
        build: (context) {
          return [
            pw.Container(
                decoration: pw.BoxDecoration(
                  image: pw.DecorationImage(
                    image: pw.MemoryImage(
                      imageBG,
                    ),
                    fit: pw.BoxFit.fill,
                  ),
                ),
                width: PdfPageFormat.a4.width,
                padding: pw.EdgeInsets.fromLTRB(70, 0, 50, 0),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.Spacer(),
                          pw.Container(
                            width: 180,
                            child: pw.Column(
                              mainAxisSize: pw.MainAxisSize.min,
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Text(
                                  (Get_Value_cid.toString() ==
                                          Form_renew_cid.toString())
                                      ? 'อ้างอิงสัญญาเดิมเลขที่________________'
                                      : 'อ้างอิงสัญญาเดิมเลขที่ ${Form_renew_cid}',
                                  // 'อ้างอิงสัญญาเดิมเลขที่...................',
                                  // 'ทำที่ $renTal_name ',
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    color: Colors_pd,
                                  ),
                                ),
                                pw.Text(
                                  'ทำที่ บริษัท ชอยส์ มินิสโตร์ จำกัด',
                                  // 'ทำที่ $renTal_name ',
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    color: Colors_pd,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            'วันที่ ${DateFormat('dd MMM', 'TH').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('${Datex_text.text} 00:00:00')}"))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('${Datex_text.text} 00:00:00')}").year + 543}',
                            //  'วันที่  ${Datex_text.text} ',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              color: Colors_pd,
                              fontSize: font_Size,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Text(
                        'ข้อ 1. รายละเอียดคู่สัญญา',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Text(
                        ' ' * 12 +
                            'สัญญาฉบับนี้ทำขึ้นระหว่าง บริษัท ชอยส์ มินิสโตร์ จำกัด โดย นางฤทัยรัตน์ วิสิทธิ์ และนายวธัญญู ตันตรานนท์ กรรมการผู้มีอำนาจลงนาม สำนักงานใหญ่ตั้งอยู่เลขที่ 7/11 หมู่ที่5 ตำบลท่าศาลา อำเภอเมืองเชียงใหม่ จังหวัดเชียงใหม่ ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            'ซึ่งต่อไปใน สัญญานี้จะเรียกว่า “ผู้ให้เช่า” ฝ่ายหนึ่ง กับ ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  "$Form_bussshop",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'เลขประจำตัวประชาชนเลขที่ ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  "$Form_tax",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'อยู่บ้านเลขที่',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  "$Form_address",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'โทรศัพท์ ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  "$Form_tel",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'ซึ่ง',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              color: Colors_pd,
                              fontSize: font_Size,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ต่อไปในสัญญานี้จะเรียกว่า “ผู้เช่า” อีกฝ่ายหนึ่ง คู่สัญญาได้ตกลงกันมีข้อความดังต่อไปนี้',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ข้อ 2. รายละเอียดสถานที่ให้เช่า',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' ' * 12 +
                                'ผู้ให้เช่าตกลงให้เช่าและผู้เช่าตกลงรับเช่าพื้นที่ ล็อกเลขที่',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  "$Form_ln",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'ขนาดพื้นที่',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 50,
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                              color: Colors_pd,
                              width: 0.3, // Underline thickness
                            ))),
                            child: pw.Text(
                              "$Form_qty ",
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                          pw.Text(
                            'ตร.ม.',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        children: [
                          pw.Text(
                            'จำนวน',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 50,
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                              color: Colors_pd,
                              width: 0.3, // Underline thickness
                            ))),
                            child: pw.Text(
                              " $Form_qty ",
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                          pw.Text(
                            'ล็อก',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ข้อ 3. วัตถุประสงค์ของการให้เช่า',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' ' * 12 +
                                'ผู้เช่าตกลงรับพื้นที่เช่า เพื่อดำเนินกิจการร้าน ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  (Form_nameshop == null ||
                                          Form_nameshop.toString() == 'null')
                                      ? "$Form_bussshop"
                                      : "$Form_nameshop",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'เท่านั้น การเปลี่ยนแปลง',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: font_Size,
                            font: ttf,
                            color: Colors_pd,
                          ),
                          'วัตถุประสงค์ประเภทของการประกอบกิจการค้าชนิดหรือลักษณะของกิจการตลอดจนชื่อในทางการค้าของผู้เช่าจะต้องได้รับความยินยอม\nเป็นลายลักษณ์อักษรจากผู้ให้เช่าก่อนและผู้เช่าต้องไม่นำทรัพย์สินของผู้ให้เช่าไปประกอบกิจการอันนำมาซึ่งความเสียหายและเป็นที่ต้อง\nห้ามของกฎหมาย อีกทั้งสินค้าและบริการที่นำมาประกอบกิจการจะต้องไม่เป็นการละเมิดลิขสิทธิ์ สิทธิบัตร เครื่องหมายทางการค้าตาม\nกฎหมายว่าด้วยทรัพย์สินทางปัญญา หรือกฎหมายอื่นใดก็ตาม ตลอดจนห้ามนำพื้นที่ให้เช่า ไปให้ผู้อื่นเช่าช่วงต่อเป็นเด็ดขาด'),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ข้อ 4. ระยะเวลาการเช่าและการส่งมอบพื้นที่ให้เช่า',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' ' * 12 +
                                'คู่สัญญาตกลงรับเช่าพื้นที่ ตามข้อ 2. สัญญาเริ่มตั้งแต่วันที่',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}"))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}").year + 543}',
                                  // "$Form_sdate",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'ถึงวันที่ ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00')}"))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00')}").year + 543}',
                                  // "$Form_ldate",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            'ระยะเวลาการเช่า',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  "$Form_period",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            (Form_rtname.toString() == 'รายวัน')
                                ? 'วัน และผู้ให้เช่าตกลงส่งมอบพื้นที่เช่าให้แก่ผู้เช่าครอบครองในวันที่ '
                                : (Form_rtname.toString() == 'รายเดือน')
                                    ? 'เดือน และผู้ให้เช่าตกลงส่งมอบพื้นที่เช่าให้แก่ผู้เช่าครอบครองในวันที่ '
                                    : (Form_rtname.toString() == 'รายปี')
                                        ? 'ปี และผู้ให้เช่าตกลงส่งมอบพื้นที่เช่าให้แก่ผู้เช่าครอบครองในวันที่ '
                                        : '$Form_rtname และผู้ให้เช่าตกลงส่งมอบพื้นที่เช่าให้แก่ผู้เช่าครอบครองในวันที่ ',
                            //  'ปี และผู้ให้เช่าตกลงส่งมอบพื้นที่เช่าให้แก่ผู้เช่าครอบครองในวันที่ ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00')}"))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00')}").year + 543}',
                                  // "$Form_ldate",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'หากกรณีผู้เช่าเปิดดำเนินกิจการก่อนวันที่สัญญาเริ่มต้น ผู้เช่าจะต้องชำระค่าเช่าตามจริง',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ข้อ 5. อัตราค่าเช่าและการชำระ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'ผู้เช่าตกลงชำระค่าเช่าเป็นรายเดือน ให้แก่ผู้ให้เช่า ในอัตราค่าเช่าดังนี้',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      for (int index = 0; index < rentList.length; index++)
                        pw.SizedBox(
                            child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                              pw.Row(
                                children: [
                                  pw.Text(
                                    (Form_rtname.toString() == 'รายวัน')
                                        ? ' ' * 12 +
                                            '5.${index + 1} อัตราค่าเช่าในวันที่'
                                        : (Form_rtname.toString() == 'รายเดือน')
                                            ? ' ' * 12 +
                                                '5.${index + 1} อัตราค่าเช่าในเดือนที่'
                                            : (Form_rtname.toString() ==
                                                    'รายปี')
                                                ? ' ' * 12 +
                                                    '5.${index + 1} อัตราค่าเช่าในปีที่'
                                                : ' ' * 12 +
                                                    '5.${index + 1} อัตราค่าเช่าใน$Form_rtnameที่',
                                    // ' ' * 12 +
                                    //     '5.${index + 1} อัตราค่าเช่าในปีที่',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: Colors_pd,
                                    ),
                                  ),
                                  pw.Container(
                                    width: 40,
                                    height: 14,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border(
                                            bottom: pw.BorderSide(
                                      color: Colors_pd,
                                      width: 0.3, // Underline thickness
                                    ))),
                                    child: pw.Text(
                                      "  ${index + 1} ",
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        color: Colors_pd,
                                        fontSize: font_Size,
                                        fontWeight: pw.FontWeight.bold,
                                        font: ttf,
                                      ),
                                    ),
                                  ),
                                  pw.Text(
                                    'ตั้งแต่วันที่',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: Colors_pd,
                                    ),
                                  ),
                                  pw.Expanded(
                                      flex: 1,
                                      child: pw.Container(
                                        height: 14,
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border(
                                                bottom: pw.BorderSide(
                                          color: Colors_pd,
                                          width: 0.3, // Underline thickness
                                        ))),
                                        child: pw.Text(
                                          (Form_rtname.toString() == 'รายวัน')
                                              ? '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}").add(Duration(days: index)))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}").add(Duration(days: index)).year + 543}'
                                              : (Form_rtname.toString() ==
                                                      'รายเดือน')
                                                  ? '${DateFormat('dd MMM', 'th').format(DateTime(
                                                      DateTime.parse(
                                                              "${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}")
                                                          .year,
                                                      DateTime.parse(
                                                                  "${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}")
                                                              .month +
                                                          index, // Add one to the month
                                                      DateTime.parse(
                                                              "${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}")
                                                          .day,
                                                      00,
                                                      00,
                                                      00,
                                                    ))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}").year + 543}'
                                                  : (Form_rtname.toString() ==
                                                          'รายปี')
                                                      ? '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}"))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}").year + 543 + ((index == 0) ? 0 : index + 1)}'
                                                      : '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}"))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}").year + 543 + ((index == 0) ? 0 : index + 1)}',
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            color: Colors_pd,
                                            fontSize: font_Size,
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                          ),
                                        ),
                                      )),
                                  pw.Text(
                                    'ถึงวันที่',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: Colors_pd,
                                    ),
                                  ),
                                  pw.Expanded(
                                      flex: 1,
                                      child: pw.Container(
                                        height: 14,
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border(
                                                bottom: pw.BorderSide(
                                          color: Colors_pd,
                                          width: 0.3, // Underline thickness
                                        ))),
                                        child: pw.Text(
                                          (Form_rtname.toString() == 'รายวัน')
                                              ? (index + 1 == rentList.length)
                                                  ? '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00')}").add(Duration(days: (index + 1))))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00').add(Duration(days: (index + 1)))}").year + 543}'
                                                  : '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}").add(Duration(days: (index + 1))))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00').add(Duration(days: (index + 1)))}").year + 543}'
                                              : (Form_rtname.toString() ==
                                                      'รายเดือน')
                                                  ? (index + 1 ==
                                                          rentList.length)
                                                      ? '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00')}"))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00')}").year + 543}'
                                                      : '${DateFormat('dd MMM', 'th').format(DateTime(
                                                          DateTime.parse(
                                                                  "${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}")
                                                              .year,
                                                          DateTime.parse(
                                                                      "${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}")
                                                                  .month +
                                                              (index +
                                                                  1), // Add one to the month
                                                          DateTime.parse(
                                                                      "${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}")
                                                                  .day -
                                                              1,
                                                          00,
                                                          00,
                                                          00,
                                                        ))} ${DateTime(
                                                            DateTime.parse(
                                                                    "${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}")
                                                                .year,
                                                            DateTime.parse(
                                                                        "${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}")
                                                                    .month +
                                                                (index +
                                                                    1), // Add one to the month
                                                            DateTime.parse(
                                                                    "${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}")
                                                                .day,
                                                            00,
                                                            00,
                                                            00,
                                                          ).year + 543}'
                                                  : (Form_rtname.toString() ==
                                                          'รายปี')
                                                      ? (index + 1 ==
                                                              rentList.length)
                                                          ? '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00')}"))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00')}").year + 543}'
                                                          : '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}"))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}").year + 543 + (index + 1)}'
                                                      : (index + 1 ==
                                                              rentList.length)
                                                          ? '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00')}"))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00')}").year + 543}'
                                                          : '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}"))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_sdate 00:00:00')}").year + 543 + (index + 1)}',
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            color: Colors_pd,
                                            fontSize: font_Size,
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              pw.SizedBox(height: 1 * PdfPageFormat.mm),
                              pw.Row(
                                children: [
                                  pw.Text(
                                    ' ' * 12 + 'ชำระค่าเช่าเดือนละ',
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                      fontSize: font_Size,
                                      font: ttf,
                                      color: Colors_pd,
                                    ),
                                  ),
                                  pw.Expanded(
                                      flex: 1,
                                      child: pw.Container(
                                        height: 14,
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border(
                                                bottom: pw.BorderSide(
                                          color: Colors_pd,
                                          width: 0.3, // Underline thickness
                                        ))),
                                        child: pw.Text(
                                          (double.parse(rentList[index]
                                                      .toString()) ==
                                                  0.00)
                                              ? ' 0.00 บาท (~${convertToThaiBaht(0.00)}~)'
                                              : " ${nFormat.format(double.parse(rentList[index].toString()))} บาท (~${convertToThaiBaht(double.parse(rentList[index].toString()))}~) ",
                                          textAlign: pw.TextAlign.left,
                                          style: pw.TextStyle(
                                            color: Colors_pd,
                                            fontSize: font_Size,
                                            fontWeight: pw.FontWeight.bold,
                                            font: ttf,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              pw.SizedBox(height: 1 * PdfPageFormat.mm),
                            ])),
                      (rentList.length == 0 || rentList.length == 3)
                          ? pw.SizedBox(height: 10 * PdfPageFormat.mm)
                          : (rentList.length == 2 || rentList.length == 1)
                              ? pw.SizedBox(height: 20 * PdfPageFormat.mm)
                              : pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'โดยผู้เช่าตกลงจะชำระค่าเช่า ให้แก่ผู้ให้เช่าโดยชำระผ่านทางบัญชีธนาคารกรุงเทพ จำกัด (มหาชน)  สาขาท่าแพ ประเภทออมทรัพย์ เลขที่บัญชี 251-4-93765-1 ชื่อบัญชี “บริษัท ชอยส์ มินิสโตร์ จำกัด”',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        ' ' * 12 +
                            'อนึ่ง การชำระค่าเช่ารายเดือน ผู้เช่าต้องชำระค่าเช่าล่วงหน้าภายในวันสุดท้ายของเดือนปฏิทินก่อนหน้า โดยถือเป็นค่าเช่า',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            'รายเดือนของเดือนถัดไป หากผู้เช่าไม่ทำการชำระภายในเวลาที่กำหนด ผู้ให้เช่ามีสิทธิคิดค่าปรับวันละ   ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  (quotxSelectModels.length == 0)
                                      ? '0.00 (~${convertToThaiBaht(0.00)}~)'
                                      : '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '17').map((e) => e.amt != null ? double.parse(e.amt.toString()) : 0.00).fold(0.00, (a, b) => a + b))} บาท ',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            'นับตั้งแต่วันที่เลยกำหนดชำระ และหากผู้เช่ายังไม่ชำระค่าเช่าและค่าปรับภายในวันที่',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 50,
                            // height: 13,
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                              color: Colors_pd,
                              width: 0.3, // Underline thickness
                            ))),
                            child: pw.Text(
                              "5",
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                          pw.Text(
                            'ของเดือนถัดไป ผู้ให้เช่ามีสิทธิบอกเลิก',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.Text(
                        'สัญญาได้ทันที ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ข้อ 6. ค่าเช่าสาธารณูปโภคและการชำระ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'ผู้ให้เช่าตกลงให้เช่า และผู้เช่าตกลงรับเช่าสาธารณูปโภคตลอดอายุสัญญาให้แก่ผู้ให้เช่า ตามรายการใบแจ้งหนี้ของทาง\nผู้ให้เช่า ตามอัตราค่าเช่า (ยังไม่รวมภาษีมูลเพิ่ม) ดังนี้ ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Text(
                        ' ' * 12 + '6.1 ค่ากระแสไฟฟ้า ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' ' * 12 + '- ชำระค่าธรรมเนียมมิเตอร์ไฟฟ้าจำนวน',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '20').map((e) => e.pvat != null && e.pvat.toString() != '' ? double.parse(e.pvat.toString()) : 0.00).reduce((a, b) => a + b))} บาท ',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'บาท ภาษีมูลค่าเพิ่ม ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '20').map((e) => e.vat != null && e.vat.toString() != '' ? double.parse(e.vat.toString()) : 0.00).reduce((a, b) => a + b))} บาท ',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'บาท ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' ' * 12 + 'รวม',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 100,
                            // height: 13,
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                              color: Colors_pd,
                              width: 0.3, // Underline thickness
                            ))),
                            child: pw.Text(
                              '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '20').map((e) => e.total != null && e.total.toString() != '' ? double.parse(e.total.toString()) : 0.00).reduce((a, b) => a + b))} บาท ',
                              // " - บาท (   -    )",
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                          pw.Text(
                            'ชำระครั้งแรก',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' ' * 12 + '- ชำระในอัตราหน่วยละ ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 100,
                            // height: 13,
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                              color: Colors_pd,
                              width: 0.3, // Underline thickness
                            ))),
                            child: pw.Text(
                              " ${quotxSelectModels.where((model) => model.expser == '6').map((model) => model.qty).join(', ')} บาท",
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                          pw.Text(
                            'ตามจำนวนตัวเลขที่ระบุไว้ในมาตรกระแสไฟฟ้า',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' ' * 12 +
                                '- ชำระค่ากระแสไฟฟ้า “แบบเหมาจ่าย” ในอัตราเดือนละ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 100,
                            // height: 13,
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                              color: Colors_pd,
                              width: 0.3, // Underline thickness
                            ))),
                            child: pw.Text(
                              " - บาท (   -    )",
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 + '6.2 ค่าน้ำประปา ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' ' * 12 + '- ชำระค่าธรรมเนียมมิเตอร์น้ำประปา',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '21').map((e) => e.pvat != null && e.pvat.toString() != '' ? double.parse(e.pvat.toString()) : 0.00).reduce((a, b) => a + b))} บาท ',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'บาท ภาษีมูลค่าเพิ่ม ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '21').map((e) => e.vat != null && e.vat.toString() != '' ? double.parse(e.vat.toString()) : 0.00).reduce((a, b) => a + b))} บาท ',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'บาท ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' ' * 12 + 'รวม',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 100,
                            // height: 13,
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                              color: Colors_pd,
                              width: 0.3, // Underline thickness
                            ))),
                            child: pw.Text(
                              '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '21').map((e) => e.total != null && e.total.toString() != '' ? double.parse(e.total.toString()) : 0.00).reduce((a, b) => a + b))} บาท ',
                              // " - บาท (   -    )",
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                          pw.Text(
                            'ชำระครั้งแรก',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' ' * 12 + '- ชำระในอัตราหน่วยละ ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 100,
                            // height: 13,
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                              color: Colors_pd,
                              width: 0.3, // Underline thickness
                            ))),
                            child: pw.Text(
                              " ${quotxSelectModels.where((model) => model.expser == '7').map((model) => model.qty).join(', ')} บาท",
                              // " - บาท (   -    )",
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                          pw.Text(
                            'ตามจำนวนตัวเลขที่ระบุไว้ในมาตรวัดการใช้น้ำ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' ' * 12 +
                                '- ชำระค่าน้ำประปา “แบบเหมาจ่าย” ในอัตราเดือนละ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 100,
                            // height: 13,
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                              color: Colors_pd,
                              width: 0.3, // Underline thickness
                            ))),
                            child: pw.Text(
                              " - บาท (   -    )",
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ข้อ 7. เงินประกัน',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          color: Colors_pd,
                          fontSize: font_Size,
                          fontWeight: pw.FontWeight.bold,
                          font: ttf,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 + '7.1 ประกันการเช่า',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' ' * 12 +
                                'ผู้เช่าจะต้องวางเงินประกันการเช่าแก่ผู้ให้เช่า เป็นจำนวนเงินทั้งหมด',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  (quotxSelectModels.length == 0)
                                      ? '0.00 (~${convertToThaiBaht(0.00)}~)'
                                      : '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '2').map((e) => e.pvat != null ? double.parse(e.pvat.toString()) : 0.00).fold(0.00, (a, b) => a + b))}',
                                  // (Form_PakanAll_pvat == null ||
                                  //         Form_PakanAll_pvat.toString() == '')
                                  //     ? '0.00'
                                  //     : '${nFormat.format(double.parse('${Form_PakanAll_pvat}'))}',
                                  // "26,000  ",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'บาท ภาษีมูลค่าเพิ่ม',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  (quotxSelectModels.length == 0)
                                      ? '0.00 (~${convertToThaiBaht(0.00)}~)'
                                      : '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '2').map((e) => e.vat != null ? double.parse(e.vat.toString()) : 0.00).fold(0.00, (a, b) => a + b))}',
                                  // (Form_PakanAll_vat == null ||
                                  //         Form_PakanAll_vat.toString() == '')
                                  //     ? '0.00'
                                  //     : '${nFormat.format(double.parse('${Form_PakanAll_vat}'))}',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'บาท',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            'รวมเป็นเงิน จำนวนทั้งหมด',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  (quotxSelectModels.length == 0)
                                      ? '0.00 (~${convertToThaiBaht(0.00)}~)'
                                      : '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '2').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))} บาท ',
                                  // (Form_PakanAll_Total == null ||
                                  //         Form_PakanAll_Total.toString() == '')
                                  //     ? '0.00 (~${convertToThaiBaht(0.00)}~)'
                                  //     : '${nFormat.format(double.parse('${Form_PakanAll_Total}'))} บาท ' +
                                  //         '(~${convertToThaiBaht(double.parse('${Form_PakanAll_Total}'))}~)',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'โดยเงินจำนวนดังกล่าวเป็นเงินมาจาก',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            'ประกันการเช่าจากสัญญาเดิม เลขที่',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  (Get_Value_cid.toString() ==
                                          Form_renew_cid.toString())
                                      ? '-'
                                      : '${Form_renew_cid}',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'จำนวน',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  (Get_Value_cid.toString() ==
                                          Form_renew_cid.toString())
                                      ? " - บาท ( - )"
                                      : (Form_PakanAll_Total == null ||
                                              Form_PakanAll_Total.toString() ==
                                                  '')
                                          ? '0.00 (~${convertToThaiBaht(0.00)}~)'
                                          : '${nFormat.format(double.parse('${Form_PakanAll_Total}'))} บาท ' +
                                              '(~${convertToThaiBaht(double.parse('${Form_PakanAll_Total}'))}~)',
                                  // " - บาท  (     -          ) ",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'และผู้เช่าวางเงินประกันการเช่าเพิ่ม',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            'จำนวน',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  " - ",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'จำนวน',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  " - บาท (     -          ) ",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'โดยมีกำหนดชำระ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  " - ",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'เพื่อเป็นการประกันการชำระค่าเช่าและประกันการปฏิบัติตามสัญญานี้รวมถึงค่าเสียหายใดๆที่ผู้เช่าต้องรับผิดตามสัญญานี้โดยหากมีการ\nต่อสัญญาแล้วผู้ให้เช่าปรับอัตราค่าเช่าเพิ่มขึ้น ผู้เช่าจะต้องวางเงินประกันเพิ่มตามการปรับอัตราค่าเช่า  ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'อนึ่ง เมื่อสัญญานี้สิ้นสุดลงผู้เช่าได้ส่งมอบสถานที่ให้เช่าคืนให้แก่ผู้ให้เช่าและผู้ให้เช่าได้ตรวจรับมอบสถานที่ให้เช่า \nเรียบร้อยแล้วไม่ปรากฏความเสียหายใด ๆ ผู้ให้เช่าจะคืนเงินประกันการเช่าดังกล่าวโดยไม่มีดอกเบี้ยให้แก่ผู้เช่าภายในระยะเวลา 45 วัน',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'กรณีที่ผู้เช่ามีหนี้สินที่ค้างชำระต่อผู้ให้เช่า ผู้ให้เช่ามีสิทธิหักเงินประกันนี้ได้  และหากยังมีเงินเหลืออยู่ ผู้ให้เช่าจะคืนให้แก่\nผู้เช่าแต่หากหักหนี้สินที่ค้างชำระจากเงินประกันแล้วยังไม่คุ้มกับเงินที่ผู้เช่าค้างชำระ ผู้ให้เช่ามีสิทธิเรียกร้องจากผู้เช่าจนครบ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 10 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 + '7.2 ประกันการตกแต่ง',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' ' * 12 +
                                'ขณะที่ผู้เช่าทำการตกแต่งพื้นที่ให้เช่า ผู้เช่าจะต้องวางเงินประกันการตกแต่งให้แก่ผู้ให้เช่าเป็นจำนวน',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  " -  บาท (  -  )",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            'โดยมีกำหนดชำระ ภายในวันที่',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  " -  ",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                          pw.Text(
                            'กรณีเกิดความเสียหายใดๆอันเกิดจากการตกแต่งที่ผู้เช่าต้องรับผิดตามสัญญานี้หรือหาก',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ความเสียหายยังไม่เพียงพอ ผู้ให้เช่ามีสิทธิเรียกค่าเสียหายเพิ่มเติมจนกว่าจะได้รับชำระจนครบถ้วน เมื่อผู้เช่าทำการตกแต่ง\nพื้นที่ให้เช่าเสร็จสิ้นแล้ว ผู้ให้เช่าจะคืนเงินประกันการตกแต่งภายใน 45 วัน นับตั้งแต่ตัวแทนของผู้ให้เช่าได้ทำการตรวจสอบ\nความเสียหายเรียบร้อย และไม่ปรากฏความเสียหายใด ๆ อันเกิดจากการตกแต่งพื้นที่ให้เช่า',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ข้อ 8. ภาษีที่ดินสิ่งปลูกสร้าง และภาษีอื่น ๆ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'ผู้เช่าช่วงตกลงรับภาระในภาษีที่ดินและสิ่งปลูกสร้าง และภาษีอื่นใดที่เกี่ยวข้องกับทรัพย์สินที่เช่า ซึ่งจะต้องชำระ\nตามกฎหมายในอัตราที่รัฐกำหนด ตั้งแต่วันที่เริ่มสัญญาตลอดจนสิ้นอายุของสัญญานี้ โดยผู้เช่าช่วงต้องชำระค่าภาษีภายในเวลาที่\nผู้ให้เช่าช่วงกำหนด หากผู้เช่าช่วงมิได้ชำระค่าภาษีใดๆ ตามที่ตกลงไว้ในวรรคแรก หรือได้ชำระแล้วแต่ขาดเงินไปจำนวนเท่าใด\nและผู้ให้เช่าช่วงได้ชำระค่าภาษีนั้นให้แล้ว ผู้เช่าช่วงจะต้องชดใช้ค่าภาษีที่ผู้ให้เช่าช่วงได้ชำระให้ทั้งหมดให้ผู้ให้เช่าช่วง ภายในเวลา\nที่ผู้ให้เช่าช่วงกำหนด',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ข้อ 9. การต่ออายุสัญญา',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '9.1 ผู้ให้เช่ามีสิทธิกำหนดอัตราค่าเช่าใหม่เพิ่มขึ้นทุก ๆ ปี  ปีละไม่เกิน    10      %',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '9.2 หากครบกำหนดอายุสัญญาเช่านี้แล้ว ผู้เช่ามีความประสงค์จะต่ออายุสัญญา ผู้เช่าต้องแจ้งความจำนงเป็นลายลักษณ์อักษร\nให้ผู้ให้เช่าทราบล่วงหน้าไม่น้อยกว่า 90 วัน ก่อนสิ้นสุดอายุสัญญานี้  ผู้ให้เช่าจะพิจารณาให้ผู้เช่า รับเช่าต่อไป หรือไม่ก็ได้\nหากให้เช่าต่อ ผู้เช่าจะต้องทำสัญญาฉบับใหม่กับผู้ให้เช่า ทุกคราวที่มีการต่อสัญญาก่อนสัญญานี้จะสิ้นสุดลง หากผู้เช่าไม่แจ้งความ\nจำนงว่าจะขอรับเช่าต่อหรือผู้เช่าไม่ทำสัญญาฉบับใหม่กับผู้ให้เช่าก่อนที่สัญญานี้จะสิ้นสุดลง ให้ถือว่าไม่มีการให้เช่าต่อภายหลัง\nครบกำหนดอายุสัญญานี้กันอีกต่อไป ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ข้อ 10. สิทธิและหน้าที่ของผู้เช่า',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '10.1 ผู้เช่าจะต้องดูแลรักษาพื้นที่ให้เช่าเสมือนวิญญูชนจะพึงดูแลรักษาทรัพย์ของตน และผู้เช่าจะต้องเป็นผู้เสียค่าใช้จ่าย\nในการบำรุงรักษา และซ่อมแซมทรัพย์สินภายในพื้นที่ให้เช่าเอง',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '10.2 ผู้เช่าจะต้องไม่นำสินค้า สิ่งของ วัตถุไวไฟและ/หรือวัตถุอันตรายอื่นใดที่ผิดกฎหมายมาเก็บรักษาไว้ภายในพื้นที่ให้เช่า\nหากเกิดความเสียหายอันสืบเนื่องจากความผิดของผู้เช่าเอง ต้องชดใช้ค่าเสียหายทั้งหมดที่เกิดขึ้น',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '10.3 ผู้เช่าจะต้องไม่กระทำการใด ๆ ให้เป็นที่รบกวนหรือก่อให้เกิดความเดือดร้อนรำคาญแก่ผู้เช่ารายอื่น',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '10.4 กรณีผู้เช่าจะทำการตกแต่ง ดัดแปลง ต่อเติม หรือก่อสร้างพื้นที่ให้เช่า จะต้องได้รับคำยินยอมจากผู้ให้เช่าก่อนเท่านั้น\nหากฝ่าฝืนไม่ปฏิบัติตามเงื่อนไขดังกล่าว ผู้เช่าจะต้องรับผิดในความเสียหายและชดใช้ค่าใช้จ่ายที่เกิดขึ้นทั้งหมด',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '10.5 ผู้เช่าต้องรับผิดชอบและชดใช้ค่าใช้จ่ายทั้งปวงอันเกี่ยวกับอุบัติเหตุ หรือความเสียหายใด ๆ ต่อบุคคล ทรัพย์สิน\nซึ่งเกิดในหรือจากสถานที่ให้เช่าหรือการดำเนินงานในสถานที่ให้เช่าของผู้เช่า นับตั้งแต่วันที่ผู้เช่าเข้าครอบครองพื้นที่',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      (rentList.length > 4)
                          ? pw.SizedBox(height: 1 * PdfPageFormat.mm)
                          : pw.SizedBox(height: 20 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '10.6 การติดตั้งป้ายชื่อร้าน ป้ายโฆษณา ภาษีป้าย หรือสิ่งใดๆ ก็ตามของผู้เช่าที่แสดงต่อสาธารณชน อันเกิดจาก\nการประกอบกิจการของผู้เช่าต้องได้รับความยินยอมจากผู้ให้เช่าเสียก่อน หากฝ่าฝืนผู้ให้เช่ามีสิทธิที่จะถอดถอนป้ายที่มิได้รับอนุญาต\nนั้นออกโดยมิต้องรับผิดชอบต่อความเสียหายและสูญหายใดๆ ที่เกิดขึ้นแก่ผู้เช่า',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '10.7 ผู้ให้เช่าหรือตัวแทนมีสิทธิเข้าไปและตรวจตราในสถานที่ให้เช่าได้ตลอด ผู้เช่า ลูกจ้างและบริวารของผู้เช่าจะต้องอำนวย\nความสะดวกให้แก่ผู้ให้เช่าหรือตัวแทนเสมอ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '10.8  ผู้เช่าจะต้องไม่ประกอบกิจการในลักษณะเดียวกันหรือคล้ายคลึงกันกับกิจการของผู้ให้เช่าในการประกอบการค้า\nประเภทมินิมาร์ท,คอนวีเนี่ยนสโตร์ หรือซุปเปอร์มาร์เก็ต รวมตลอดทั้งกิจการที่ผู้ให้เช่าเห็นว่ามีลักษณะในทำนองเดียวกันกับธุรกิจ\nการค้าของผู้ให้เช่าเป็นอันขาด',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '10.9 ผู้เช่าเป็นผู้ดูแลรักษาบ่อดักไขมันตามตำแหน่งที่ผู้ให้เช่าจัดเตรียมไว้ให้ รวมถึงรับผิดชอบจัดการกากไขมันจาก\nบ่อดักไขมัน หากผู้เช่ามิได้ดำเนินการดูแลรักษาหรือจัดการกากไขมันตามข้างต้น ผู้ให้เช่ามีสิทธิดำเนินการเรียกเก็บค่าใช้จ่ายจากผู้เช่าได้',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '10.10 ผู้เช่าเป็นผู้รับผิดชอบสิ่งปฏิกูล ขยะมูลฝอย ที่มาจากการประกอบกิจการของผู้เช่า หรือผู้ที่มาใช้เช่าจากผู้เช่า',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ข้อ 11. กรณีบอกเลิกหรือสิ้นสุดสัญญา',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '11.1 หากการประกอบธุรกิจการค้าของผู้เช่าไม่เป็นไปตามเป้าหมาย และผู้เช่าต้องการบอกเลิกสัญญาก่อนครบกำหนด\nตามสัญญาจะต้องบอกกล่าวแก่ผู้ให้เช่าไม่น้อยกว่า 90 วัน โดยผู้ให้เช่ามีสิทธิเรียกค่าเสียหายอันเกิดแต่การบอกเลิกสัญญาดังกล่าว\nและริบเงินประกันการเช่าทั้งหมด',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '11.2 หากผู้เช่าผิดสัญญาเช่าข้อหนึ่งข้อใด หรือถูกยึดทรัพย์บังคับคดี  หรือถูกฟ้องให้เป็นบุคคลล้มละลาย  ผู้ให้เช่ามีสิทธิ\nเลิกสัญญานี้ได้ทันทีโดยไม่ต้องบอกกล่าวก่อนล่วงหน้า',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '11.3 ห้ามมิให้ผู้เช่านำพื้นที่ให้เช่าทั้งหมดหรือแต่บางส่วนไปให้บุคคลอื่นรับเช่าช่วงต่อ หรือโอนสิทธิและหน้าที่\nหรือนำสิทธิตามสัญญานี้ไปเป็นหลักประกันใดๆกับธนาคารหรือบุคคลอื่น ไม่ว่าโดยทางตรงหรือทางอ้อม รวมทั้งการเปลี่ยนแปลง\nประเภทกิจการค้าต่างจากเดิม โดยปราศจากการอนุมัติจากผู้ให้เช่าก่อน ผู้ให้เช่ามีสิทธิบอกเลิกสัญญาได้ทันที',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '11.4 ผู้เช่าจะไม่ใช้พื้นที่เกินกว่าที่ระบุไว้ในสัญญาเช่านี้ หากฝ่าฝืนและผู้ให้เช่าตรวจพบว่าใช้พื้นที่เกินจากที่ระบุไว้ในสัญญา\nผู้ให้เช่ามีสิทธิบอกเลิกสัญญาหรือปรับเพิ่มอัตราค่าเช่าโดยคำนวนจากพื้นที่ส่วนเกินได้',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '11.5 หากผู้เช่าไม่เริ่มประกอบกิจการค้าในสถานที่ให้เช่าภายในกำหนดเวลาวันเริ่มสัญญานี้ ให้ถือว่าผู้เช่าผิดสัญญา\nและผู้ให้เช่ามีสิทธิบอกเลิกสัญญา และยึดเงินประกันการเช่านี้ได้',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '11.6 เมื่อสัญญาเช่านี้ ระงับสิ้นไปหรือเลิกกันไม่ว่าด้วยกรณีใดๆ ก็ตาม ผู้เช่าตกลงให้สิ่งต่อเติม ตกแต่ง ก่อสร้าง หรือดัดแปลง\nที่ได้ทำขึ้นดังกล่าว และติดตรึงตราไม่สามารถรื้อถอนโดยไม่ก่อให้เกิดความเสียหายต่อพื้นที่ให้เช่าได้ ไม่ว่าจะกระทำโดยได้รับความยินยอม\nจากผู้ให้เช่าหรือไม่ก็ตาม ให้ตกเป็นส่วนควบของพื้นที่ให้เช่า และให้ตกเป็นกรรมสิทธิ์ของผู้ให้เช่าทั้งสิ้นทันที\nโดยผู้เช่าตกลงไม่เรียกร้องค่าทดแทนและค่าเสียหายใดๆ ทั้งสิ้น ทั้งนี้ผู้ให้เช่ามีสิทธิพิจารณาว่าจะรับเอาหรือให้ผู้เช่ารื้อถอนพร้อม\nปรับปรุงพื้นที่ให้เป็นสภาพดังเดิมด้วยค่าใช้จ่ายของผู้เช่าเอง หรือพิจารณาเป็นอย่างอื่นได้ตามที่เห็นสมควร',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      (rentList.length > 4)
                          ? pw.SizedBox(height: 1 * PdfPageFormat.mm)
                          : pw.SizedBox(height: 20 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '11.7 ผู้เช่าต้องขนย้ายทรัพย์สินและบริวารออกไปจากพื้นที่ให้เช่าให้แล้วเสร็จภายใน 7 วัน นับแต่วันที่สัญญาเช่าสิ้นสุดลง\nหรือกรณีที่ผู้ให้เช่าต้องการให้รื้อถอนปรับปรุงพื้นที่ให้เช่าให้กลับคืนสู่สภาพเดิม ผู้เช่าต้องดำเนินการให้แล้วเสร็จภายใน 14 วัน นับแต่\nวันที่สัญญาเช่าสิ้นสุดลง และหากพ้นกำหนดระยะเวลาตามที่กล่าวมาข้างต้นแล้วผู้เช่ายังไม่ขนย้ายทรัพย์สิน บริวาร และหรือ รื้อถอน',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            'ปรับปรุงพื้นที่ให้เช่าให้กลับคืนสู่สภาพเดิมให้แล้วเสร็จตามสัญญา ผู้เช่าตกลงชำระค่าปรับในอัตราวันละ  ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Container(
                                // height: 13,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                        bottom: pw.BorderSide(
                                  color: Colors_pd,
                                  width: 0.3, // Underline thickness
                                ))),
                                child: pw.Text(
                                  " -  บาท ( -  ) ",
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'โดยหากผู้เช่ายังคงปล่อยทิ้งทรัพย์สินไว้ในพื้นที่ให้เช่า ให้ทรัพย์สินนั้นตกเป็นกรรมสิทธิ์ของผู้ให้เช่าทันที\nโดยให้ผู้ให้เช่ามีสิทธิ จำหน่าย จ่าย โอน หรือจัดการทรัพย์สิน ยึดเงินประกัน ตลอดจนเรียกร้องค่าใช้จ่าย อันเกิดแต่การจัดการทรัพย์สิน\nของผู้เช่า และ/หรือรื้อถอน ปรับปรุงพื้นที่ให้เช่า ให้กลับคืนสู่สภาพเดิมจากผู้เช่า โดยผู้เช่าไม่มีสิทธิเรียกร้องทรัพย์สิน หรือเรียกร้อง\nค่าเสียหายใด ๆ ทั้งสิ้นจากผู้ให้เช่า',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ข้อ 12. การบอกกล่าว',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'การบอกกล่าวตามสัญญานี้ หากฝ่ายหนึ่งฝ่ายใดได้ทำเป็นหนังสือและจัดส่งทางไปรษณีย์ลงทะเบียนไปยังคู่สัญญาอีกฝ่ายหนึ่ง\nตามที่อยู่ที่ระบุไว้ข้างต้นในสัญญานี้ ให้ถือว่าเป็นการบอกกล่าวที่ชอบด้วยกฎหมาย และคู่สัญญาอีกฝ่ายหนึ่งได้รับทราบแล้ว',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        'ข้อ 13. การแจ้งการประมวลผลข้อมูลส่วนบุคคล (Privacy Notice)',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 + '13.1 การเก็บ และใช้ข้อมูลส่วนบุคคล',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'ผู้ให้เช่าได้เก็บรวบรวมและหรือใช้ข้อมูลส่วนบุคคลของผู้เช่า ได้แก่ สำเนาบัตรประจำตัวประชาชน ,สำเนาทะเบียนบ้าน,\nสำเนาบัญชีธนาคารเอกสารสำคัญใด ๆ  ที่มีข้อมูลส่วนบุคคล (“ข้อมูลส่วนบุคคล”) เป็นระยะเวลาทั้งหมด 10 ปี (สิบปี)\nนับจากวันที่สัญญาฉบับนี้สิ้นสุดลง โดยมีวัตถุประสงค์เพื่อตรวจสอบความเป็นตัวตนของผู้เช่าเป็นหลักฐานในการก่อตั้งสิทธิเรียกร้อง\nและเพื่อใช้ตามวัตถุประสงค์ตามสัญญาฉบับนี้เรียกร้อง และเพื่อใช้ตามวัตถุประสงค์ตามสัญญาฉบับนี้เท่านั้น โดยไม่นำข้อมูลส่วน\nบุคคลดังกล่าวไปใช้เพื่อวัตถุประสงค์อื่นใดนอกจากสัญญาฉบับนี้แต่อย่างใด',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'ทั้งนี้ หากผู้เช่าไม่ส่งมอบข้อมูลส่วนบุคคลดังกล่าวแก่ผู้ให้เช่า จะทำให้การจัดทำสัญญาฉบับนี้ไม่สมบูรณ์ อันเป็นฐาน\nการประมวลผลเพื่อเป็นการจำเป็นเพื่อการปฏิบัติตามสัญญาและเป็นการจำเป็นเพื่อประโยชน์โดยชอบด้วยกฎหมาย ตามมาตรา 24\n(3),(5)ของพระราชบัญญัติคุ้มครองข้อมูลส่วนบุคคล พ.ศ. 2562 ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'ทั้งนี้ ผู้เช่าในฐานะเจ้าของข้อมูลส่วนบุคคลรับทราบว่าตนเองมีสิทธิดังนี้ (1) สิทธิในการเข้าถึงและรับสำเนาข้อมูลส่วน\nบุคคลที่ผู้ให้เช่าได้ทำการเก็บรวบรวมและหรือใช้ได้ ตลอดจนสิทธิในการคัดค้าน การประมวลผลข้อมูลส่วนบุคคล (2) เมื่อพ้น\nระยะเวลาทั้งหมด 10 ปี (สิบปี) นับจากวันที่สัญญาฉบับนี้สิ้นสุดลง ผู้ให้เช่าจะทำการลบหรือทำลายข้อมูลส่วนบุคคล (3)  สิทธิในการ\nขอให้ผู้ให้เช่าระงับการใช้ข้อมูลส่วนบุคคล หากผู้ให้เช่าได้ใช้ข้อมูลส่วนบุคคลไม่เป็นไป ตามวัตถุประสงค์ตามวรรคแรกข้างต้น\n(4) สิทธิในการขอแก้ไขข้อมูลส่วนบุคคลให้ถูกต้องเป็นปัจจุบัน สมบูรณ์และไม่ก่อให้เกิดความเข้าใจผิด (5) สิทธิในการร้องเรียน\nผู้ให้เช่าใช้สิทธิข้างต้นจะต้องจัดทำเป็นลายลักษณ์อักษร และแจ้งต่อผู้ให้เช่าภายในระยะเวลาอันสมควร  และไม่เกินระยะเวลาที่\nกฎหมายกำหนด โดยผู้ให้เช่าจะปฏิบัติตามข้อกำหนดทางกฎหมายที่เกี่ยวข้องกับสิทธิ ของเจ้าของข้อมูลส่วนบุคคล และผู้ให้เช่า\nขอสงวนสิทธิ์ในการคิดค่าเช่าใดๆ ที่เกี่ยวข้องและจำเป็นต่อการใช้สิทธิดังกล่าว',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      (rentList.length > 4)
                          ? pw.SizedBox(height: 10 * PdfPageFormat.mm)
                          : pw.SizedBox(height: 35 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 + '13.2 การเปิดเผยข้อมูลส่วนบุคคล',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'เพื่อประโยชน์ของผู้เช่าตามวัตถุประสงค์ในสัญญาเช่านี้ ผู้ให้เช่าอาจเปิดเผยข้อมูลของผู้เช่าให้กับหน่วยงานอื่นของผู้ให้เช่า\nรวมถึงบริษัทในเครือและบริษัทย่อย เพื่อวัตถุประสงค์ในการปฏิบัติตามภาระผูกพันตามสัญญา ประโยชน์ที่ชอบด้วยกฎหมายการ\nปฏิบัติตามกฎหมาย และวัตถุประสงค์อื่น ๆ ภายใต้กฎหมายไทยผู้เช่ารับทราบว่าหากมีเหตุร้องเรียนเกี่ยวกับข้อมูลส่วนบุคคล\nสามารถติดต่อประสานงานมายังเจ้าหน้าที่คุ้มครองข้อมูลส่วนบุคคลได้ในช่องทางดังนี้',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'เจ้าหน้าที่คุ้มครองข้อมูลส่วนบุคคล (Data Protection Officer: DPO) / ผู้ควบคุมข้อมูลส่วนบุคคล (Data Controller)',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 + 'บริษัท ชอยส์ มินิสโตร์ จำกัด ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'เลขที่ 7/11 หมู่ที่ 5 ตำบลท่าศาลา อำเภอเมืองเชียงใหม่ จังหวัดเชียงใหม่ 50000',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 + 'Email Address : privacy@choice.co.th',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 10 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'สัญญานี้ทำขึ้นเป็น 2 ฉบับ  มีข้อความถูกต้องตรงกันทุกประการ  ทั้งสองฝ่ายต่างได้อ่านและเข้าใจข้อความทั้งหมดในสัญญาดี\nโดยตลอดเห็นว่าถูกต้องตามเจตนาและความประสงค์ทุกประการแล้ว จึงได้ลงลายมือชื่อไว้เป็นหลักฐานต่อหน้าพยาน\nและต่างเก็บรักษาไว้ฝ่ายละ 1 ฉบับ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 10 * PdfPageFormat.mm),
                      pw.Row(children: [
                        pw.Expanded(
                            flex: 1,
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                // (signature_Image1.isEmpty)
                                //     ? pw.Text(
                                //         '',
                                //         maxLines: 1,
                                //         style: pw.TextStyle(
                                //           fontSize: 10,
                                //           font: ttf,
                                //           color: Colors_pd,
                                //         ),
                                //       )
                                //     : pw.Image(
                                //         pw.MemoryImage(signature_Image1),
                                //         // (signature_Image1[0]),
                                //         height: 30,
                                //         width: 100,
                                //       ),
                                pw.Text(
                                  'ลงชื่อ___________________________ผู้ให้เช่า    ',
                                  textAlign: pw.TextAlign.justify,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                pw.Text(
                                  '( นางฤทัยรัตน์ วิสิทธิ์ และ นายวธัญญู ตันตรานนท์ ) ',
                                  textAlign: pw.TextAlign.justify,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                        pw.SizedBox(width: 5 * PdfPageFormat.mm),
                        pw.Expanded(
                            flex: 1,
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                // (signature_Image2.isEmpty)
                                //     ? pw.Text(
                                //         '',
                                //         maxLines: 1,
                                //         style: pw.TextStyle(
                                //           fontSize: 10,
                                //           font: ttf,
                                //           color: Colors_pd,
                                //         ),
                                //       )
                                //     : pw.Image(
                                //         pw.MemoryImage(signature_Image2),
                                //         height: 30,
                                //         width: 100,
                                //       ),
                                pw.Text(
                                  'ลงชื่อ___________________________ผู้เช่า    ',
                                  textAlign: pw.TextAlign.justify,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                pw.Text(
                                  '(___________________________) ',
                                  textAlign: pw.TextAlign.justify,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                      ]),
                      pw.SizedBox(height: 20 * PdfPageFormat.mm),
                      pw.Row(children: [
                        pw.Expanded(
                            flex: 1,
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                // (signature_Image3.isEmpty)
                                //     ? pw.Text(
                                //         '',
                                //         maxLines: 1,
                                //         style: pw.TextStyle(
                                //           fontSize: 10,
                                //           font: ttf,
                                //           color: Colors_pd,
                                //         ),
                                //       )
                                //     : pw.Image(
                                //         pw.MemoryImage(signature_Image3),
                                //         height: 30,
                                //         width: 100,
                                //       ),
                                pw.Text(
                                  'ลงชื่อ___________________________พยาน    ',
                                  textAlign: pw.TextAlign.justify,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                pw.Text(
                                  '(___________________________) ',
                                  textAlign: pw.TextAlign.justify,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                        pw.SizedBox(width: 5 * PdfPageFormat.mm),
                        pw.Expanded(
                            flex: 1,
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                // (signature_Image4.isEmpty)
                                //     ? pw.Text(
                                //         '',
                                //         maxLines: 1,
                                //         style: pw.TextStyle(
                                //           fontSize: 10,
                                //           font: ttf,
                                //           color: Colors_pd,
                                //         ),
                                //       )
                                //     : pw.Image(
                                //         pw.MemoryImage(signature_Image4),
                                //         height: 30,
                                //         width: 100,
                                //       ),
                                pw.Text(
                                  'ลงชื่อ___________________________พยาน    ',
                                  textAlign: pw.TextAlign.justify,
                                  style: pw.TextStyle(
                                    color: Colors_pd,
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                                pw.Text(
                                  '(___________________________) ',
                                  textAlign: pw.TextAlign.justify,
                                  style: pw.TextStyle(
                                    fontSize: font_Size,
                                    font: ttf,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                      ]),
                    ])),
          ];
        },
        footer: (context) {
          return pw.Column(
            children: [
              pw.Container(
                  width: PdfPageFormat.a4.width,
                  padding: pw.EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          "${context.pageNumber} / ${context.pagesCount}..........",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: Colors_pd,
                            fontSize: font_Size - 2,
                            font: ttf,
                          ),
                        ),
                      ])),
              pw.Stack(
                children: [
                  pw.Container(
                      width: PdfPageFormat.a4.width,
                      height: 55,
                      child: pw.Center(
                        child: pw.Container(
                            width: widths,
                            height: 25,
                            child: pw.Column(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                mainAxisSize: pw.MainAxisSize.min,
                                children: [
                                  pw.Row(children: [
                                    pw.Expanded(
                                        child: pw.Container(
                                      color: PdfColors.red,
                                      height: 5,
                                    ))
                                  ]),
                                  pw.Row(children: [
                                    pw.Expanded(
                                        child: pw.Container(
                                      color: PdfColors.green900,
                                      height: 8,
                                    ))
                                  ]),
                                  pw.Row(children: [
                                    pw.Expanded(
                                        child: pw.Container(
                                      color: PdfColors.red,
                                      height: 5,
                                    ))
                                  ]),
                                ])),
                      )),
                  pw.Positioned(
                      top: 4,
                      right: 50,
                      child: pw.Container(
                          width: 50.0,
                          height: 50.0,
                          child: pw.Image(pw.MemoryImage(imageData)))),
                  pw.Positioned(
                    top: 4,
                    left: 40,
                    child: pw.Text(
                      "CHOICE MINI STORE CO., LTD. 7/11 VILLAGE NO.5, THA SALA SUB-DISTRICT, MUEANG CHIANG MAI DISTRICT, CHIANG MAI PROVINANCE 50000",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        color: Colors_pd,
                        fontSize: font_Size - 4,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                      ),
                    ),
                  ),
                  pw.Positioned(
                    bottom: 4,
                    right: 120,
                    child: pw.Text(
                      "Sub Area Licencee: Chiang Mai, Lamphun, Mae-Hong-Son",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        color: Colors_pd,
                        fontSize: font_Size - 4,
                        font: ttf,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    // final bytes = await pdf.save();

    // final dir = await getApplicationDocumentsDirectory();
    // final file = File('${dir.path}/name');
    // await file.writeAsBytes(bytes);
    // return file;
    // final List<int> bytes = await pdf.save();
    // final Uint8List data = Uint8List.fromList(bytes);
    // MimeType type = MimeType.PDF;
    // final dir = await FileSaver.instance.saveFile(
    //     "ใบเสนอราคา(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
    //     data,
    //     "pdf",
    //     mimeType: type);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RentalInforman_Agreement(
            doc: pdf,
            context: context,
            ////////////------------------->
            ///
            Get_Value_NameShop_index: Get_Value_NameShop_index,
            Get_Value_cid: Get_Value_cid,
            verticalGroupValue: _verticalGroupValue,
            Form_nameshop: Form_nameshop,
            Form_typeshop: Form_typeshop,
            Form_bussshop: Form_bussshop,
            Form_bussscontact: Form_bussscontact,
            Form_address: Form_address,
            Form_tel: Form_tel,
            Form_email: Form_email,
            Form_tax: Form_tax,
            Form_ln: Form_ln,
            Form_zn: Form_zn,
            Form_area: Form_area,
            Form_qty: Form_qty,
            Form_sdate: Form_sdate,
            Form_ldate: Form_ldate,
            Form_period: Form_period,
            Form_rtname: Form_rtname,
            quotxSelectModels: quotxSelectModels,
            TransModels: _TransModels,
            renTal_name: renTal_name,
            bill_addr: bill_addr,
            bill_email: bill_email,
            bill_tel: bill_tel,
            bill_tax: bill_tax,
            bill_name: bill_name,
            newValuePDFimg: newValuePDFimg,
          ),
        ));
  }
}
