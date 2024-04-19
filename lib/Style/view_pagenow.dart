import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/Myconstant.dart';
import '../Model/GetUser_Model.dart';
import '../Responsive/responsive.dart';
import 'colors.dart';

dynamic Now_viewpage(context, Ser_page) async {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("###0.00", "en_US");
  List<UserModel> userModels = [];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var ren = preferences.getString('renTalSer');
  var renTal_Email = preferences.getString('renTalEmail');
  var seremail_login = preferences.getString('ser');
  int total = 0;
  /////////////////////-------------------->Up_Viewpage_now
  String url1 =
      '${MyConstant().domain}/Up_Viewpagenow.php?isAdd=true&ren=$ren&page=$Ser_page&seruser=$seremail_login';
  try {
    var response = await http.get(Uri.parse(url1));

    var result = json.decode(response.body);
    if (result.toString() == 'true') {}
  } catch (e) {}
  /////////////////////-------------------->GC_Viewpage_now
  String url2 =
      '${MyConstant().domain}/GC_Viewpage_now.php?isAdd=true&ren=$ren&page=$Ser_page&emailrental=$renTal_Email';
  try {
    var response = await http.get(Uri.parse(url2));

    var result = json.decode(response.body);
    // print(result);
    if (result != null) {
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        total = total + 1;
        userModels.add(userModel);
      }
    } else {}
  } catch (e) {}
  /////////////////////-------------------->
  return '$total';
}

dynamic Now_viewpageAlldata(context, Ser_page) async {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("###0.00", "en_US");
  List<UserModel> userModels = [];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var ren = preferences.getString('renTalSer');
  var renTal_Email = preferences.getString('renTalEmail');
  var seremail_login = preferences.getString('ser');
  int total = 0;

  /////////////////////-------------------->Up_Viewpage_now
  String url1 =
      '${MyConstant().domain}/Up_Viewpagenow.php?isAdd=true&ren=$ren&page=$Ser_page&seruser=$seremail_login';
  try {
    var response = await http.get(Uri.parse(url1));

    var result = json.decode(response.body);
    if (result.toString() == 'true') {}
  } catch (e) {}
  /////////////////////-------------------->
  String url2 =
      '${MyConstant().domain}/GC_Viewpage_now.php?isAdd=true&ren=$ren&page=$Ser_page&emailrental=$renTal_Email';
  try {
    var response = await http.get(Uri.parse(url2));

    var result = json.decode(response.body);
    // print(result);
    if (result != null) {
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        total = total + 1;
        userModels.add(userModel);
      }
    } else {}
  } catch (e) {}
  /////////////////////-------------------->
  List menu = [
    'หน้าหลัก',
    'พื้นที่เช่า',
    'ผู้เช่า',
    'บัญชี',
    'จัดการ',
    'รายงาน',
    'ทะเบียน',
    'ตั้งค่า',
    'จัดการข้อมูลส่วนตัว'
  ];
  /////////////////////-------------------->
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: AppbackgroundColor.Sub_Abg_Colors,
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(10.0),
      actionsPadding: const EdgeInsets.all(6.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child:
                  Icon(Icons.highlight_off, size: 30, color: Colors.red[700]),
            ),
          ),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          }),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            dragStartBehavior: DragStartBehavior.start,
            child: Row(
              children: [
                Container(
                    width: 600,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              minFontSize: 10,
                              maxFontSize: 20,
                              ' ผู้ใช้งานขณะนี้ ( ${menu[int.parse(Ser_page.toString())]} )',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
                                  //fontSize: 10.0
                                  //fontSize: 10.0
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: AppbackgroundColor.TiTile_Colors,
                          // color: Colors.brown[200],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          // border: Border.all(
                          //     color: Colors.grey, width: 1),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              child: Text(
                                '...',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AdminScafScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Email',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AdminScafScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'ชื่อ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AdminScafScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'ตำแหน่ง',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AdminScafScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                            // Expanded(
                            //   flex: 1,
                            //   child: Text(
                            //     'เวลาอัพเดตล่าสุด',
                            //     textAlign: TextAlign.center,
                            //     style: TextStyle(
                            //         color:
                            //             AdminScafScreen_Color.Colors_Text1_,
                            //         fontWeight: FontWeight.bold,
                            //         fontFamily: FontWeight_.Fonts_T),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // height:
                          //     MediaQuery.of(context).size.height / 4.8,
                          decoration: const BoxDecoration(
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                            // border: Border.all(
                            //     color: Colors.grey, width: 1),
                          ),
                          child: StreamBuilder(
                            stream: Stream.periodic(const Duration(seconds: 0)),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                // itemExtent: 50,
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: userModels.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String email = '${userModels[index].email}';
                                  int emailLength = email.length;
                                  String firstTwoCharacters =
                                      email.substring(0, 2);
                                  String lastFourCharacters =
                                      email.substring(emailLength - 4);
                                  String censoredEmail =
                                      '$firstTwoCharacters${'*' * (emailLength - 6)}$lastFourCharacters';

                                  String connected_ =
                                      '${userModels[index].connected}';

                                  DateTime connectedTime =
                                      DateTime.parse(connected_);

                                  DateTime currentTime = DateTime.now();

                                  Duration difference =
                                      currentTime.difference(connectedTime);

                                  int minutesPassed = difference.inMinutes;
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        // color: Colors.green[100]!
                                        //     .withOpacity(0.5),
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 60,
                                            child: AutoSizeText(
                                              minFontSize: 8,
                                              maxFontSize: 16,
                                              '${index + 1}',
                                              textAlign: TextAlign.left,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: AdminScafScreen_Color
                                                      .Colors_Text1_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 8,
                                              maxFontSize: 16,
                                              '${censoredEmail} ',
                                              textAlign: TextAlign.left,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: AdminScafScreen_Color
                                                      .Colors_Text1_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 8,
                                              maxFontSize: 16,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              '${userModels[index].fname} ${userModels[index].lname}',
                                              style: const TextStyle(
                                                  color: AdminScafScreen_Color
                                                      .Colors_Text1_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 8,
                                              maxFontSize: 16,
                                              '${userModels[index].position}',
                                              textAlign: TextAlign.left,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: AdminScafScreen_Color
                                                      .Colors_Text1_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

List colorList = [
  Colors.orange,
  Colors.grey,
  Colors.black,
  Colors.white,
  Colors.green,
  Colors.white
];
// Random random = Random();
// Color randomColor = colorList[random.nextInt(colorList.length)];
Widget viewpage(context, Ser_page) {
  var nFormat = NumberFormat("#,##0", "en_US");
  var nFormat2 = NumberFormat("###0.00", "en_US");
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
    child: InkWell(
        onTap: () async {
          Now_viewpageAlldata(context, Ser_page);
        },
        child: Container(
          height: 35,
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: AppbackgroundColor.TiTile_Colors,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Row(
            children: [
              // const Icon(Icons.people, color: Colors.yellow),
              StreamBuilder(
                  stream: Stream.periodic(const Duration(minutes: 1)),
                  builder: (context, snapshot) {
                    return Padding(
                        padding: const EdgeInsets.all(0),
                        child: FutureBuilder(
                          future: Now_viewpage(context, Ser_page),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // While fetching data
                              return const SizedBox(
                                  height: 20,
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              // If there's an error
                              return const Text('ผู้ใช้งาน: ??');
                            } else {
                              // Data fetched successfully
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      StreamBuilder(
                                          stream: Stream.periodic(
                                              const Duration(
                                                  milliseconds: 1600)),
                                          builder: (context, snapshot) {
                                            int randomIndex = Random()
                                                .nextInt(colorList.length);
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Icon(
                                                Icons.people,
                                                color: colorList[randomIndex],
                                                size: 16,
                                              ),
                                            );
                                          }),
                                      Positioned(
                                          top: -5,
                                          left: 0,
                                          child: Container(
                                            // decoration: const BoxDecoration(
                                            //   color: Colors.white,
                                            //   borderRadius: BorderRadius.only(
                                            //       topLeft: Radius.circular(20),
                                            //       topRight: Radius.circular(20),
                                            //       bottomLeft: Radius.circular(20),
                                            //       bottomRight: Radius.circular(20)),
                                            // ),
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              '${nFormat.format(double.parse(snapshot.data.toString()))}',
                                              // '${userModels.length}***/$connected_Minutes/$ser_user/$email_user',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          ))
                                    ],
                                  ),
                                  const AutoSizeText(
                                    'ผู้ใช้งาน',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    minFontSize: 10,
                                    maxFontSize: 20,
                                    style: TextStyle(
                                      // decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        )

                        //  AutoSizeText(
                        //   'ผู้ใช้งาน ${Now_viewpage('5')} คน',
                        //   overflow: TextOverflow.ellipsis,
                        //   minFontSize: 10,
                        //   maxFontSize: 20,
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.bold,
                        //     fontFamily: FontWeight_.Fonts_T,
                        //   ),
                        // ),
                        );
                  })
            ],
          ),
        )),
  );
}
