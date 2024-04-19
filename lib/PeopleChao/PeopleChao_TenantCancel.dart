// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';

// import '../Style/colors.dart';

// class PeopleChao_TenantCancel extends StatefulWidget {
//   const PeopleChao_TenantCancel({super.key});

//   @override
//   State<PeopleChao_TenantCancel> createState() =>
//       _PeopleChao_TenantCancelState();
// }

// class _PeopleChao_TenantCancelState extends State<PeopleChao_TenantCancel> {
//   @override
//   Widget build(BuildContext context) {
//     return ScrollConfiguration(
//       behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
//         PointerDeviceKind.touch,
//         PointerDeviceKind.mouse,
//       }),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         dragStartBehavior: DragStartBehavior.start,
//         child: Row(
//           children: [
//             SizedBox(
//               width: (Responsive.isDesktop(context))
//                   ? MediaQuery.of(context).size.width * 0.858
//                   : 1200,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
//                     child: Container(
//                         width: (Responsive.isDesktop(context))
//                             ? MediaQuery.of(context).size.width * 0.858
//                             : 1200,
//                         decoration: const BoxDecoration(
//                           color: AppbackgroundColor.TiTile_Colors,
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               topRight: Radius.circular(10),
//                               bottomLeft: Radius.circular(0),
//                               bottomRight: Radius.circular(0)),
//                         ),
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Expanded(child: Next_page_Web()),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: AutoSizeText(
//                                     minFontSize: 10,
//                                     maxFontSize: 25,
//                                     maxLines: 2,
//                                     'เลขที่สัญญา/เสนอราคา',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         color: PeopleChaoScreen_Color
//                                             .Colors_Text1_,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: FontWeight_.Fonts_T
//                                         //fontSize: 10.0
//                                         ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: AutoSizeText(
//                                     minFontSize: 10,
//                                     maxFontSize: 25,
//                                     maxLines: 2,
//                                     'ชื่อผู้ติดต่อ',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         color: PeopleChaoScreen_Color
//                                             .Colors_Text1_,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: FontWeight_.Fonts_T
//                                         //fontSize: 10.0
//                                         ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: AutoSizeText(
//                                     minFontSize: 10,
//                                     maxFontSize: 25,
//                                     maxLines: 2,
//                                     'ชื่อร้านค้า',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         color: PeopleChaoScreen_Color
//                                             .Colors_Text1_,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: FontWeight_.Fonts_T
//                                         //fontSize: 10.0
//                                         ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: AutoSizeText(
//                                     minFontSize: 10,
//                                     maxFontSize: 25,
//                                     maxLines: 2,
//                                     'โซนพื้นที่',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         color: PeopleChaoScreen_Color
//                                             .Colors_Text1_,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: FontWeight_.Fonts_T
//                                         //fontSize: 10.0
//                                         ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: AutoSizeText(
//                                     minFontSize: 10,
//                                     maxFontSize: 25,
//                                     maxLines: 2,
//                                     'รหัสพื้นที่',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         color: PeopleChaoScreen_Color
//                                             .Colors_Text1_,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: FontWeight_.Fonts_T
//                                         //fontSize: 10.0
//                                         ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: AutoSizeText(
//                                     minFontSize: 10,
//                                     maxFontSize: 25,
//                                     maxLines: 2,
//                                     'ประเภท',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         color: PeopleChaoScreen_Color
//                                             .Colors_Text1_,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: FontWeight_.Fonts_T
//                                         //fontSize: 10.0
//                                         ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: AutoSizeText(
//                                     minFontSize: 10,
//                                     maxFontSize: 25,
//                                     maxLines: 2,
//                                     'วันที่ยกเลิก/ทำรายการ',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         color: PeopleChaoScreen_Color
//                                             .Colors_Text1_,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: FontWeight_.Fonts_T
//                                         //fontSize: 10.0
//                                         ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: AutoSizeText(
//                                     minFontSize: 10,
//                                     maxFontSize: 25,
//                                     maxLines: 2,
//                                     'เหตุผล',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         color: PeopleChaoScreen_Color
//                                             .Colors_Text1_,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: FontWeight_.Fonts_T
//                                         //fontSize: 10.0
//                                         ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: AutoSizeText(
//                                     minFontSize: 10,
//                                     maxFontSize: 25,
//                                     maxLines: 2,
//                                     'สถานะ',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         color: PeopleChaoScreen_Color
//                                             .Colors_Text1_,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: FontWeight_.Fonts_T
//                                         //fontSize: 10.0
//                                         ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: AutoSizeText(
//                                     minFontSize: 10,
//                                     maxFontSize: 25,
//                                     maxLines: 2,
//                                     '...',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         color: PeopleChaoScreen_Color
//                                             .Colors_Text1_,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: FontWeight_.Fonts_T
//                                         //fontSize: 10.0
//                                         ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         )),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//                     child: Column(
//                       children: [
//                         Container(
//                           height: MediaQuery.of(context).size.height * 0.65,
//                           width: (Responsive.isDesktop(context))
//                               ? MediaQuery.of(context).size.width * 0.858
//                               : 1200,
//                           decoration: const BoxDecoration(
//                             color: AppbackgroundColor.Sub_Abg_Colors,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(0),
//                                 topRight: Radius.circular(0),
//                                 bottomLeft: Radius.circular(0),
//                                 bottomRight: Radius.circular(0)),
//                             // border: Border.all(color: Colors.grey, width: 1),
//                           ),
//                           child: teNantModels.isEmpty
//                               ? SizedBox(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       const CircularProgressIndicator(),
//                                       StreamBuilder(
//                                         stream: Stream.periodic(
//                                             const Duration(milliseconds: 25),
//                                             (i) => i),
//                                         builder: (context, snapshot) {
//                                           if (!snapshot.hasData)
//                                             return const Text('');
//                                           double elapsed = double.parse(
//                                                   snapshot.data.toString()) *
//                                               0.05;
//                                           return Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: (elapsed > 8.00)
//                                                 ? const Text(
//                                                     'ไม่พบข้อมูล',
//                                                     style: TextStyle(
//                                                         color:
//                                                             PeopleChaoScreen_Color
//                                                                 .Colors_Text2_,
//                                                         fontFamily:
//                                                             Font_.Fonts_T
//                                                         //fontSize: 10.0
//                                                         ),
//                                                   )
//                                                 : Text(
//                                                     'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
//                                                     // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
//                                                     style: const TextStyle(
//                                                         color:
//                                                             PeopleChaoScreen_Color
//                                                                 .Colors_Text2_,
//                                                         fontFamily:
//                                                             Font_.Fonts_T
//                                                         //fontSize: 10.0
//                                                         ),
//                                                   ),
//                                           );
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               : ListView.builder(
//                                   controller: _scrollController1,
//                                   // itemExtent: 50,
//                                   physics:
//                                       const AlwaysScrollableScrollPhysics(),
//                                   shrinkWrap: true,
//                                   itemCount: teNantModels.length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return Material(
//                                       color: tappedIndex_ == index.toString()
//                                           ? tappedIndex_Color.tappedIndex_Colors
//                                               .withOpacity(0.5)
//                                           : AppbackgroundColor.Sub_Abg_Colors,
//                                       child: Container(
//                                         // color: Colors.white,
//                                         // color: tappedIndex_ == index.toString()
//                                         //     ? tappedIndex_Color.tappedIndex_Colors
//                                         //         .withOpacity(0.5)
//                                         //     : null,
//                                         child: ListTile(
//                                             onTap: () {
//                                               setState(() {
//                                                 tappedIndex_ = index.toString();
//                                               });
//                                             },
//                                             title: Container(
//                                               decoration: const BoxDecoration(
//                                                 // color: Colors.green[100]!
//                                                 //     .withOpacity(0.5),
//                                                 border: Border(
//                                                   bottom: BorderSide(
//                                                     color: Colors.black12,
//                                                     width: 1,
//                                                   ),
//                                                 ),
//                                               ),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       child: Tooltip(
//                                                         richMessage: TextSpan(
//                                                           text: teNantModels[
//                                                                           index]
//                                                                       .docno ==
//                                                                   null
//                                                               ? teNantModels[index]
//                                                                           .cid ==
//                                                                       null
//                                                                   ? ''
//                                                                   : '${teNantModels[index].cid}'
//                                                               : '${teNantModels[index].docno}',
//                                                           style:
//                                                               const TextStyle(
//                                                             color: HomeScreen_Color
//                                                                 .Colors_Text1_,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontFamily:
//                                                                 FontWeight_
//                                                                     .Fonts_T,
//                                                             //fontSize: 10.0
//                                                           ),
//                                                         ),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(5),
//                                                           color:
//                                                               Colors.grey[200],
//                                                         ),
//                                                         child: AutoSizeText(
//                                                           minFontSize: 10,
//                                                           maxFontSize: 25,
//                                                           maxLines: 1,
//                                                           teNantModels[index]
//                                                                       .docno ==
//                                                                   null
//                                                               ? teNantModels[index]
//                                                                           .cid ==
//                                                                       null
//                                                                   ? ''
//                                                                   : '${teNantModels[index].cid}'
//                                                               : '${teNantModels[index].docno}',
//                                                           textAlign:
//                                                               TextAlign.left,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           style:
//                                                               const TextStyle(
//                                                                   color: PeopleChaoScreen_Color
//                                                                       .Colors_Text2_,
//                                                                   //fontWeight: FontWeight.bold,
//                                                                   fontFamily: Font_
//                                                                       .Fonts_T),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       child: AutoSizeText(
//                                                         minFontSize: 10,
//                                                         maxFontSize: 25,
//                                                         maxLines: 1,
//                                                         teNantModels[index]
//                                                                     .cname ==
//                                                                 null
//                                                             ? teNantModels[index]
//                                                                         .cname_q ==
//                                                                     null
//                                                                 ? ''
//                                                                 : '${teNantModels[index].cname_q}'
//                                                             : '${teNantModels[index].cname}',
//                                                         textAlign:
//                                                             TextAlign.left,
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         style: const TextStyle(
//                                                             color: PeopleChaoScreen_Color
//                                                                 .Colors_Text2_,
//                                                             //fontWeight: FontWeight.bold,
//                                                             fontFamily:
//                                                                 Font_.Fonts_T),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       child: Tooltip(
//                                                         richMessage: TextSpan(
//                                                           text: teNantModels[
//                                                                           index]
//                                                                       .sname ==
//                                                                   null
//                                                               ? teNantModels[index]
//                                                                           .sname_q ==
//                                                                       null
//                                                                   ? ''
//                                                                   : '${teNantModels[index].sname_q}'
//                                                               : '${teNantModels[index].sname}',
//                                                           style:
//                                                               const TextStyle(
//                                                             color: HomeScreen_Color
//                                                                 .Colors_Text1_,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontFamily:
//                                                                 FontWeight_
//                                                                     .Fonts_T,
//                                                             //fontSize: 10.0
//                                                           ),
//                                                         ),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(5),
//                                                           color:
//                                                               Colors.grey[200],
//                                                         ),
//                                                         child: AutoSizeText(
//                                                           minFontSize: 10,
//                                                           maxFontSize: 25,
//                                                           maxLines: 1,
//                                                           teNantModels[index]
//                                                                       .sname ==
//                                                                   null
//                                                               ? teNantModels[index]
//                                                                           .sname_q ==
//                                                                       null
//                                                                   ? ''
//                                                                   : '${teNantModels[index].sname_q}'
//                                                               : '${teNantModels[index].sname}',
//                                                           textAlign:
//                                                               TextAlign.left,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           style:
//                                                               const TextStyle(
//                                                                   color: PeopleChaoScreen_Color
//                                                                       .Colors_Text2_,
//                                                                   //fontWeight: FontWeight.bold,
//                                                                   fontFamily: Font_
//                                                                       .Fonts_T),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: AutoSizeText(
//                                                       minFontSize: 10,
//                                                       maxFontSize: 25,
//                                                       maxLines: 1,
//                                                       '${teNantModels[index].zn}',
//                                                       textAlign: TextAlign.left,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: const TextStyle(
//                                                           color:
//                                                               PeopleChaoScreen_Color
//                                                                   .Colors_Text2_,
//                                                           //fontWeight: FontWeight.bold,
//                                                           fontFamily:
//                                                               Font_.Fonts_T),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: Tooltip(
//                                                       richMessage: TextSpan(
//                                                         text:
//                                                             '${teNantModels[index].ln}',
//                                                         style: const TextStyle(
//                                                           color: HomeScreen_Color
//                                                               .Colors_Text1_,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontFamily:
//                                                               FontWeight_
//                                                                   .Fonts_T,
//                                                           //fontSize: 10.0
//                                                         ),
//                                                       ),
//                                                       decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(5),
//                                                         color: Colors.grey[200],
//                                                       ),
//                                                       child: AutoSizeText(
//                                                         minFontSize: 10,
//                                                         maxFontSize: 25,
//                                                         maxLines: 1,
//                                                         '${teNantModels[index].ln}',
//                                                         textAlign:
//                                                             TextAlign.left,
//                                                         style: const TextStyle(
//                                                             color: PeopleChaoScreen_Color
//                                                                 .Colors_Text2_,
//                                                             //fontWeight: FontWeight.bold,
//                                                             fontFamily:
//                                                                 Font_.Fonts_T),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: AutoSizeText(
//                                                       minFontSize: 10,
//                                                       maxFontSize: 25,
//                                                       maxLines: 1,
//                                                       '${teNantModels[index].rtname}',
//                                                       textAlign: TextAlign.left,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: const TextStyle(
//                                                           color:
//                                                               PeopleChaoScreen_Color
//                                                                   .Colors_Text2_,
//                                                           //fontWeight: FontWeight.bold,
//                                                           fontFamily:
//                                                               Font_.Fonts_T),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: AutoSizeText(
//                                                       minFontSize: 10,
//                                                       maxFontSize: 25,
//                                                       maxLines: 1,
//                                                       '${teNantModels[index].cc_date}',
//                                                       textAlign: TextAlign.left,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: const TextStyle(
//                                                           color:
//                                                               PeopleChaoScreen_Color
//                                                                   .Colors_Text2_,
//                                                           //fontWeight: FontWeight.bold,
//                                                           fontFamily:
//                                                               Font_.Fonts_T),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: Tooltip(
//                                                       richMessage: TextSpan(
//                                                         text:
//                                                             '${teNantModels[index].cc_remark}',
//                                                         style: TextStyle(
//                                                           color: HomeScreen_Color
//                                                               .Colors_Text1_,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontFamily:
//                                                               FontWeight_
//                                                                   .Fonts_T,
//                                                           //fontSize: 10.0
//                                                         ),
//                                                       ),
//                                                       decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(5),
//                                                         color: Colors.grey[200],
//                                                       ),
//                                                       child: AutoSizeText(
//                                                         minFontSize: 10,
//                                                         maxFontSize: 25,
//                                                         maxLines: 1,
//                                                         '${teNantModels[index].cc_remark}',
//                                                         textAlign:
//                                                             TextAlign.left,
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         style: const TextStyle(
//                                                             color: PeopleChaoScreen_Color
//                                                                 .Colors_Text2_,
//                                                             //fontWeight: FontWeight.bold,
//                                                             fontFamily:
//                                                                 Font_.Fonts_T),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: AutoSizeText(
//                                                       minFontSize: 10,
//                                                       maxFontSize: 25,
//                                                       maxLines: 1,
//                                                       '${teNantModels[index].st}',
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: const TextStyle(
//                                                           color:
//                                                               PeopleChaoScreen_Color
//                                                                   .Colors_Text2_,
//                                                           //fontWeight: FontWeight.bold,
//                                                           fontFamily:
//                                                               Font_.Fonts_T),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment.end,
//                                                       children: [
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                           child: InkWell(
//                                                             onTap: () async {
//                                                               if (renTal_lavel <=
//                                                                   2) {
//                                                                 Navigator.pop(
//                                                                     context);
//                                                                 infomation();
//                                                               } else {
//                                                                 setState(() {
//                                                                   tappedIndex_ =
//                                                                       index
//                                                                           .toString();
//                                                                 });
//                                                                 List
//                                                                     newValuePDFimg =
//                                                                     [];
//                                                                 for (int index =
//                                                                         0;
//                                                                     index < 1;
//                                                                     index++) {
//                                                                   if (renTalModels[
//                                                                               0]
//                                                                           .imglogo!
//                                                                           .trim() ==
//                                                                       '') {
//                                                                     // newValuePDFimg.add(
//                                                                     //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
//                                                                   } else {
//                                                                     newValuePDFimg
//                                                                         .add(
//                                                                             '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
//                                                                   }
//                                                                 }
//                                                                 var ser_teNant =
//                                                                     teNantModels[
//                                                                             index]
//                                                                         .quantity;
//                                                                 var Cid = teNantModels[index]
//                                                                             .docno ==
//                                                                         null
//                                                                     ? '${teNantModels[index].cid}'
//                                                                     : '${teNantModels[index].docno}';
//                                                                 _showMyDialog_SAVE(
//                                                                     Cid,
//                                                                     newValuePDFimg);
//                                                               }
//                                                             },
//                                                             child: Container(
//                                                               width: 130,
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 color: Colors
//                                                                     .red
//                                                                     .shade200,
//                                                                 borderRadius: const BorderRadius
//                                                                         .only(
//                                                                     topLeft:
//                                                                         Radius.circular(
//                                                                             10),
//                                                                     topRight: Radius
//                                                                         .circular(
//                                                                             10),
//                                                                     bottomLeft:
//                                                                         Radius.circular(
//                                                                             10),
//                                                                     bottomRight:
//                                                                         Radius.circular(
//                                                                             10)),
//                                                               ),
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .all(2.0),
//                                                               child:
//                                                                   AutoSizeText(
//                                                                 minFontSize: 10,
//                                                                 maxFontSize: 25,
//                                                                 maxLines: 1,
//                                                                 'เรียกดู',
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .center,
//                                                                 overflow:
//                                                                     TextOverflow
//                                                                         .ellipsis,
//                                                                 style: const TextStyle(
//                                                                     color: PeopleChaoScreen_Color.Colors_Text2_,
//                                                                     //fontWeight: FontWeight.bold,
//                                                                     fontFamily: Font_.Fonts_T),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                         ),
//                         Container(
//                             width: MediaQuery.of(context).size.width,
//                             decoration: const BoxDecoration(
//                               color: AppbackgroundColor.Sub_Abg_Colors,
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(0),
//                                   topRight: Radius.circular(0),
//                                   bottomLeft: Radius.circular(10),
//                                   bottomRight: Radius.circular(10)),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Row(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: InkWell(
//                                           onTap: () {
//                                             _scrollController1.animateTo(
//                                               0,
//                                               duration:
//                                                   const Duration(seconds: 1),
//                                               curve: Curves.easeOut,
//                                             );
//                                           },
//                                           child: Container(
//                                               decoration: BoxDecoration(
//                                                 // color: AppbackgroundColor
//                                                 //     .TiTile_Colors,
//                                                 borderRadius:
//                                                     const BorderRadius.only(
//                                                         topLeft:
//                                                             Radius.circular(6),
//                                                         topRight:
//                                                             Radius.circular(6),
//                                                         bottomLeft:
//                                                             Radius.circular(6),
//                                                         bottomRight:
//                                                             Radius.circular(8)),
//                                                 border: Border.all(
//                                                     color: Colors.grey,
//                                                     width: 1),
//                                               ),
//                                               padding:
//                                                   const EdgeInsets.all(3.0),
//                                               child: const Text(
//                                                 'Top',
//                                                 style: TextStyle(
//                                                     color: Colors.grey,
//                                                     fontSize: 10.0,
//                                                     fontFamily:
//                                                         FontWeight_.Fonts_T),
//                                               )),
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           if (_scrollController1.hasClients) {
//                                             final position = _scrollController1
//                                                 .position.maxScrollExtent;
//                                             _scrollController1.animateTo(
//                                               position,
//                                               duration:
//                                                   const Duration(seconds: 1),
//                                               curve: Curves.easeOut,
//                                             );
//                                           }
//                                         },
//                                         child: Container(
//                                             decoration: BoxDecoration(
//                                               // color: AppbackgroundColor
//                                               //     .TiTile_Colors,
//                                               borderRadius:
//                                                   const BorderRadius.only(
//                                                       topLeft:
//                                                           Radius.circular(6),
//                                                       topRight:
//                                                           Radius.circular(6),
//                                                       bottomLeft:
//                                                           Radius.circular(6),
//                                                       bottomRight:
//                                                           Radius.circular(6)),
//                                               border: Border.all(
//                                                   color: Colors.grey, width: 1),
//                                             ),
//                                             padding: const EdgeInsets.all(3.0),
//                                             child: const Text(
//                                               'Down',
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 10.0,
//                                                   fontFamily:
//                                                       FontWeight_.Fonts_T),
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: Alignment.centerRight,
//                                   child: Row(
//                                     children: [
//                                       InkWell(
//                                         onTap: _moveUp1,
//                                         child: const Padding(
//                                             padding: EdgeInsets.all(8.0),
//                                             child: Align(
//                                               alignment: Alignment.centerLeft,
//                                               child: Icon(
//                                                 Icons.arrow_upward,
//                                                 color: Colors.grey,
//                                               ),
//                                             )),
//                                       ),
//                                       Container(
//                                           decoration: BoxDecoration(
//                                             // color: AppbackgroundColor
//                                             //     .TiTile_Colors,
//                                             borderRadius:
//                                                 const BorderRadius.only(
//                                                     topLeft: Radius.circular(6),
//                                                     topRight:
//                                                         Radius.circular(6),
//                                                     bottomLeft:
//                                                         Radius.circular(6),
//                                                     bottomRight:
//                                                         Radius.circular(6)),
//                                             border: Border.all(
//                                                 color: Colors.grey, width: 1),
//                                           ),
//                                           padding: const EdgeInsets.all(3.0),
//                                           child: const Text(
//                                             'Scroll',
//                                             style: TextStyle(
//                                                 color: Colors.grey,
//                                                 fontSize: 10.0,
//                                                 fontFamily:
//                                                     FontWeight_.Fonts_T),
//                                           )),
//                                       InkWell(
//                                         onTap: _moveDown1,
//                                         child: const Padding(
//                                             padding: EdgeInsets.all(8.0),
//                                             child: Align(
//                                               alignment: Alignment.centerRight,
//                                               child: Icon(
//                                                 Icons.arrow_downward,
//                                                 color: Colors.grey,
//                                               ),
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             )),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
    
//   }
// }
