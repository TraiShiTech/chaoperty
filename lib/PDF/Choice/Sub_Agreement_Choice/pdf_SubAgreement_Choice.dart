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
import '../../../Style/loadAndCacheImage.dart';

class Pdfgen_SubAgreement_Choice {
//////////---------------------------------------------------->( **** เอกสารสัญญาเช่า  Choice)

  static void exportPDF_SubAgreement_Choice(
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
    // List<double> data2 = [0.00, 0.00, 0.00];
    // String Rent_List = quotxSelectModels
    //     .where((e) =>
    //         e.expser.toString() == '1' &&
    //         // e.unitser.toString() == '1' &&
    //         e.amt_ty.toString() != '')
    //     .map((e) => e.amt_ty)
    //     .toString();

    // // Step 1: Remove parentheses
    // Rent_List = Rent_List.replaceAll('(', '').replaceAll(')', '');

    // // Step 2: Split the string by commas
    // List<String> rentStringList = Rent_List.split(',');

    // // Step 3: Convert the list of strings to a list of doubles
    // List<double> rentList =
    //     (rentStringList.map((e) => double.parse(e)).toList() == 0)
    //         ? data2
    //         : rentStringList.map((e) => double.parse(e)).toList();

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
                          'บันทึกต่ออายุสัญญาเช่าพื้นที่',
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
                        'สาขา $Form_zn',
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
                      // pw.Row(
                      //   children: [
                      //     pw.Spacer(),
                      //     pw.Container(
                      //       width: 180,
                      //       child: pw.Column(
                      //         mainAxisSize: pw.MainAxisSize.min,
                      //         crossAxisAlignment: pw.CrossAxisAlignment.end,
                      //         children: [
                      //           pw.Text(
                      //             (Get_Value_cid.toString() ==
                      //                     Form_renew_cid.toString())
                      //                 ? 'อ้างอิงสัญญาเดิมเลขที่________________'
                      //                 : 'อ้างอิงสัญญาเดิมเลขที่ ${Form_renew_cid}',
                      //             // 'อ้างอิงสัญญาเดิมเลขที่...................',
                      //             // 'ทำที่ $renTal_name ',
                      //             textAlign: pw.TextAlign.right,
                      //             style: pw.TextStyle(
                      //               fontSize: font_Size,
                      //               font: ttf,
                      //               color: Colors_pd,
                      //             ),
                      //           ),
                      //           pw.Text(
                      //             'ทำที่ บริษัท ชอยส์ มินิสโตร์ จำกัด',
                      //             // 'ทำที่ $renTal_name ',
                      //             textAlign: pw.TextAlign.right,
                      //             style: pw.TextStyle(
                      //               fontSize: font_Size,
                      //               font: ttf,
                      //               color: Colors_pd,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Spacer(),
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
                          pw.SizedBox(
                            width: 100,
                          )
                        ],
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.mm),
                      pw.Row(children: [
                        pw.Text(
                          ' ' * 12 + 'อ้างถึงสัญญาเช่าเลขที่ ',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            color: Colors_pd,
                            fontSize: font_Size,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
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
                                (Get_Value_cid.toString() ==
                                        Form_renew_cid.toString())
                                    ? ' - '
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
                          'ฉบับ ลงวันที่',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            color: Colors_pd,
                            fontSize: font_Size,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
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
                                'วันที่ ${DateFormat('dd MMM', 'TH').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('${Datex_text.text} 00:00:00')}"))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('${Datex_text.text} 00:00:00')}").year + 543}',
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
                          'คู่สัญญาทั้งสองฝ่ายระหว่าง',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            color: Colors_pd,
                            fontSize: font_Size,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf,
                          ),
                        ),
                      ]),

                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            'บริษัท ชอยส์  มินิสโตร์ จำกัด “ผู้ให้เช่า” กับ ',
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
                            'โดย',
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
                            'ผู้มีอำนาจลงนาม',
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
                            'เลขประจำตัวประชาชน',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 60,
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
                          ),
                          pw.Text(
                            'ที่อยู่ ',
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
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            'เบอร์โทรศัพท์',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 60,
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
                          ),
                          pw.Text(
                            '“ผู้เช่า” ได้ตกลงเช่าอาคารเลขที่ ',
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
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
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
                            width: 60,
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                              color: Colors_pd,
                              width: 0.3, // Underline thickness
                            ))),
                            child: pw.Text(
                              "$Form_qty",
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
                            'ตร.ม. จำนวน',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 40,
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
                            'ห้อง เพื่อประกอบกิจการ ',
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
                        ],
                      ),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Row(
                        children: [
                          pw.Text(
                            ' อัตราค่าเช่า เดือนละ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 100,
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                              color: Colors_pd,
                              width: 0.3, // Underline thickness
                            ))),
                            child: pw.Text(
                              (quotxSelectModels.length == 0)
                                  ? '0.00'
                                  : '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '1').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))}',
                              // +
                              //     '(~${convertToThaiBaht(quotxSelectModels.where((e) => e.expser.toString() == '1').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))}~)',
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
                            'บาท สัญญาสิ้นสุดถึงวันที่ ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 70,
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                              color: Colors_pd,
                              width: 0.3, // Underline thickness
                            ))),
                            child: pw.Text(
                              '${DateFormat('dd MMM', 'th').format(DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00')}"))} ${DateTime.parse("${DateFormat("dd-MM-yyyy HH:mm:ss").parse('$Form_ldate 00:00:00')}").year + 543}',
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
                            'นั้น',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 8 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'บัดนี้ ใกล้ครบกำหนดระยะเวลาตามสัญญาเช่าดังกล่าวแล้ว คู่สัญญาทั้งสองฝ่ายพิจารณาแล้วตกลงต่ออายุสัญญา',
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
                            'เช่าออกไปอีก',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 40,
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
                            (Form_rtname.toString() == 'รายวัน')
                                ? 'วัน นับตั้งแต่วันที่'
                                : (Form_rtname.toString() == 'รายเดือน')
                                    ? 'เดือน นับตั้งแต่วันที่'
                                    : (Form_rtname.toString() == 'รายปี')
                                        ? 'ปี นับตั้งแต่วันที่'
                                        : '$Form_rtname นับตั้งแต่วันที่',
                            // 'เดือน นับตั้งแต่วันที่  ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 70,
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
                          ),
                          pw.Text(
                            'ถึงวันที่ ',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                          pw.Container(
                            width: 70,
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
                          ),
                          pw.Text(
                            'โดยมีรายละเอียด ดังนี้',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              fontSize: font_Size,
                              font: ttf,
                              color: Colors_pd,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 8 * PdfPageFormat.mm),
                      pw.Row(children: [
                        pw.Text(
                          ' ' * 12 +
                              '1. คู่สัญญาตกลงอัตราค่าเช่ารายเดือน เดือนละ',
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
                              (quotxSelectModels.length == 0)
                                  ? '0.00 (~${convertToThaiBaht(0.00)}~)'
                                  : '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '1').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))} บาท ' +
                                      '(~${convertToThaiBaht(quotxSelectModels.where((e) => e.expser.toString() == '1').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))}~)',
                              // " -  บาท ( - )",
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),

                      pw.Row(children: [
                        pw.Text(
                          ' ' * 12 +
                              '2. ผู้เช่ามีเงินประกันการเช่าเดิมยอดยกมาทั้งสิ้น จำนวน',
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
                              (Get_Value_cid.toString() ==
                                      Form_renew_cid.toString())
                                  ? " - บาท ( - )"
                                  : (Form_PakanAll_Total == null ||
                                          Form_PakanAll_Total.toString() == '')
                                      ? '0.00 (~${convertToThaiBaht(0.00)}~)'
                                      : '${nFormat.format(double.parse('${Form_PakanAll_Total}'))} บาท ' +
                                          '(~${convertToThaiBaht(double.parse('${Form_PakanAll_Total}'))}~)',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                        ),
                      ]),

                      pw.Row(children: [
                        pw.Text(
                          ' ' * 15 + 'และได้ชำระเงินประกันการเช่าเพิ่มอีก',
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
                              (quotxSelectModels.length == 0)
                                  ? '0.00 (~${convertToThaiBaht(0.00)}~)'
                                  : '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '2').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))} บาท ' +
                                      '(~${convertToThaiBaht(quotxSelectModels.where((e) => e.expser.toString() == '2').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))}~)',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),

                      pw.Row(children: [
                        pw.Text(
                          ' ' * 15 + 'เงินประกันการเช่ารวมเป็นเงินทั้งสิ้น',
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
                              (quotxSelectModels.length == 0)
                                  ? (Get_Value_cid.toString() ==
                                          Form_renew_cid.toString())
                                      ? '0.00 (~${convertToThaiBaht(0.00)}~)'
                                      : '${double.parse('${Form_PakanAll_Total}') + 0.00} (~${convertToThaiBaht(double.parse('${Form_PakanAll_Total}') + 0.00)}~)'
                                  : (Get_Value_cid.toString() ==
                                          Form_renew_cid.toString())
                                      ? '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '2').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))} บาท ' +
                                          '(~${convertToThaiBaht(quotxSelectModels.where((e) => e.expser.toString() == '2').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))}~)'
                                      : '${nFormat.format(double.parse('${Form_PakanAll_Total}') + quotxSelectModels.where((e) => e.expser.toString() == '2').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))} บาท ' +
                                          '(~${convertToThaiBaht(double.parse('${Form_PakanAll_Total}') + quotxSelectModels.where((e) => e.expser.toString() == '2').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))}~)',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),

                      pw.Row(children: [
                        pw.Text(
                          ' ' * 12 +
                              '3.	ผู้เช่าตกลงรับภาระค่าใช้จ่ายในการทำประกันภัยประเภทอัคคีภัย (รายเดือน/รายปี) จำนวน',
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
                              (quotxSelectModels.length == 0)
                                  ? '0.00'
                                  : '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '23').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))} บาท ',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),

                      pw.Row(children: [
                        pw.SizedBox(
                          width: 50,
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
                              (quotxSelectModels.length == 0)
                                  ? '(~${convertToThaiBaht(0.00)}~)'
                                  : '(~${convertToThaiBaht(quotxSelectModels.where((e) => e.expser.toString() == '23').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))}~)',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                        ),
                        pw.Text(
                          'ชำระภายในวันที่',
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
                              '-',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),

                      pw.Row(children: [
                        pw.Text(
                          ' ' * 12 +
                              '4.	ผู้เช่าตกลงรับผิดชอบชำระค่าภาษีที่ดินสิ่งปลูกสร้าง (รายเดือน/รายปี) จำนวน',
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
                              (quotxSelectModels.length == 0)
                                  ? '0.00'
                                  : '${nFormat.format(quotxSelectModels.where((e) => e.expser.toString() == '22').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))} บาท ',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),

                      pw.Row(children: [
                        pw.SizedBox(
                          width: 50,
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
                              (quotxSelectModels.length == 0)
                                  ? '(~${convertToThaiBaht(0.00)}~)'
                                  : '(~${convertToThaiBaht(quotxSelectModels.where((e) => e.expser.toString() == '22').map((e) => e.total != null ? double.parse(e.total.toString()) : 0.00).fold(0.00, (a, b) => a + b))}~)',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                        ),
                        pw.Text(
                          'ชำระภายในวันที่',
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
                              '-',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                color: Colors_pd,
                                fontSize: font_Size,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      pw.SizedBox(height: 1 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            '5.	ผู้เช่าตกลงยินยอมปฏิบัติตามข้อตกลงสัญญาเดิมดังกล่าวทุกประการ',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 4 * PdfPageFormat.mm),
                      pw.Text(
                        ' ' * 12 +
                            'นอกเหนือจากนี้ให้คงเป็นไปตามสัญญาเช่าเดิมทุกประการ คู่สัญญาทั้งสองฝ่ายได้อ่านและเข้าใจข้อความโดย\nละเอียดแล้ว จึงลงลายมือชื่อไว้เป็นหลักฐานสำคัญต่อหน้าพยาน',
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: font_Size,
                          font: ttf,
                          color: Colors_pd,
                        ),
                      ),
                      pw.SizedBox(height: 8 * PdfPageFormat.mm),
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
                                  '(ลงชื่อ)___________________________ผู้ให้เช่า    ',
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
                        pw.SizedBox(width: 8 * PdfPageFormat.mm),
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
                                  '(ลงชื่อ)___________________________ผู้เช่า    ',
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
                                  '( $Form_bussshop ) ',
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
                      pw.SizedBox(height: 8 * PdfPageFormat.mm),
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
                                  '(ลงชื่อ)___________________________พยาน    ',
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
                                  '(ลงชื่อ)___________________________พยาน    ',
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
