import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Style/colors.dart';
import 'Add_Custo_Screen.dart';
import 'Customer_Screen.dart';
import 'Meter_Screen.dart';
import 'Systemlog_Screen.dart';

class BureauScreen extends StatefulWidget {
  const BureauScreen({super.key});

  @override
  State<BureauScreen> createState() => _BureauScreenState();
}

class _BureauScreenState extends State<BureauScreen> {
  @override
  int Status_ = 1;

  // List Status = ['ทะเบียนลูกค้า', 'ทะเบียนมิเตอร์', 'ประวัติการใช้งาน'];
  List Status = ['ทะเบียนลูกค้า', 'ประวัติการใช้งาน', 'เพิ่มข้อมูลลูกค้า'];
  Widget build(BuildContext context) {
    return Container(
      // color: AppbackgroundColor.Sub_Abg_Colors,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 2, 0),
              child: Container(
                width: 100,
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
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    AutoSizeText(
                      'ทะเบียน ',
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 8,
                      maxFontSize: 20,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: ReportScreen_Color.Colors_Text1_,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontWeight_.Fonts_T,
                      ),
                    ),
                    AutoSizeText(
                      ' > >',
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 8,
                      maxFontSize: 20,
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontWeight_.Fonts_T,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppbackgroundColor.TiTile_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
              // border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                }),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      for (int i = 0; i < Status.length; i++)
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  Status_ = i + 1;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (i + 1 == 1)
                                      ? Colors.deepPurple[300]
                                      : (i + 1 == 2)
                                          ? Colors.green[300]
                                          : (i + 1 == 3)
                                              ? Colors.orange[300]
                                              : Colors.teal[300],
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border: (Status_ == i + 1)
                                      ? Border.all(
                                          color: Colors.white, width: 1)
                                      : null,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    Status[i],
                                    style: TextStyle(
                                        color: (Status_ == i + 1)
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily: FontWeight_.Fonts_T),
                                  ),
                                ),
                              ),
                            )),
                    ])),
              ),
            ),
          ),
        ),
        (Status_ == 1)
            ? CustomerScreen()
            : (Status_ == 2)
                ? SystemlogScreen()
                : Add_Custo_Screen()
      ]),
    );
  }
}
