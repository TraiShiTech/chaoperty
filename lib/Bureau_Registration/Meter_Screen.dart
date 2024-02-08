// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class MeterScreen extends StatefulWidget {
  const MeterScreen({super.key});

  @override
  State<MeterScreen> createState() => _MeterScreenState();
}

class _MeterScreenState extends State<MeterScreen> {
  int Ser_Body = 0;
  @override
  void initState() {
    super.initState();
  }

  ///////////////------------------------------------------------------->
  Future<void> Addelectric_meter_() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Center(
              child: Text(
            'เพิ่มมิเตอร์ไฟฟ้า',
            style: TextStyle(
              color: CustomerScreen_Color.Colors_Text1_,
              fontWeight: FontWeight.bold,
              fontFamily: FontWeight_.Fonts_T,
            ),
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    // controller:
                    //     Form1_text,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 13) {
                        return 'ใส่ข้อมูลให้ครบถ้วน ';
                      }
                      // if (int.parse(value.toString()) < 13) {
                      //   return '< 13';
                      // }
                      return null;
                    },
                    // maxLength: 13,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.3),
                        filled: true,
                        prefixIcon: const Icon(Icons.electrical_services,
                            color: Colors.red),
                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        labelText: 'รหัสเครื่องมิเตอร์ไฟฟ้า',
                        labelStyle: const TextStyle(
                          color: ManageScreen_Color.Colors_Text2_,
                          // fontWeight:
                          //     FontWeight.bold,
                          fontFamily: Font_.Fonts_T,
                        )),
                    inputFormatters: <TextInputFormatter>[
                      // for below version 2 use this
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      // for version 2 and greater youcan also use this
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: const Center(
                        child: Text(
                          'บันทึก',
                          style: TextStyle(
                            // fontSize: 15,
                            color: Colors.white,
                            fontFamily: Font_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: const Center(
                        child: Text(
                          'ปิด',
                          style: TextStyle(
                            // fontSize: 15,
                            color: Colors.white,
                            fontFamily: Font_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

///////////////------------------------------------------------------->
  Future<void> Addwater_meter_() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Center(
              child: Text(
            'เพิ่มมิเตอร์น้ำ',
            style: TextStyle(
              color: CustomerScreen_Color.Colors_Text1_,
              fontWeight: FontWeight.bold,
              fontFamily: FontWeight_.Fonts_T,
            ),
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    // controller:
                    //     Form1_text,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 13) {
                        return 'ใส่ข้อมูลให้ครบถ้วน ';
                      }
                      // if (int.parse(value.toString()) < 13) {
                      //   return '< 13';
                      // }
                      return null;
                    },
                    // maxLength: 13,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.3),
                        filled: true,
                        prefixIcon: const Icon(Icons.water, color: Colors.blue),
                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        labelText: 'รหัสเครื่องมิเตอร์น้ำ',
                        labelStyle: const TextStyle(
                          color: ManageScreen_Color.Colors_Text2_,
                          // fontWeight:
                          //     FontWeight.bold,
                          fontFamily: Font_.Fonts_T,
                        )),
                    inputFormatters: <TextInputFormatter>[
                      // for below version 2 use this
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      // for version 2 and greater youcan also use this
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: const Center(
                        child: Text(
                          'บันทึก',
                          style: TextStyle(
                            // fontSize: 15,
                            color: Colors.white,
                            fontFamily: Font_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: const Center(
                        child: Text(
                          'ปิด',
                          style: TextStyle(
                            // fontSize: 15,
                            color: Colors.white,
                            fontFamily: Font_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

///////////////------------------------------------------------------->
  Future<void> delete_meter_(type, Number, index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Center(
              child: Text(
            'ลบมิเตอร์$type',
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontFamily: FontWeight_.Fonts_T,
            ),
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                    child: Center(
                        child: Text(
                      'รหัสเครื่อง : $Number',
                      style: const TextStyle(
                        color: CustomerScreen_Color.Colors_Text2_,
                        // fontWeight: FontWeight.bold,
                        fontFamily: Font_.Fonts_T,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: const Center(
                        child: Text(
                          'ลบ',
                          style: TextStyle(
                            // fontSize: 15,
                            color: Colors.white,
                            fontFamily: Font_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      print('ลบมิเตอร์$type , index: ${index}');
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: const Center(
                        child: Text(
                          'ปิด',
                          style: TextStyle(
                            // fontSize: 15,
                            color: Colors.white,
                            fontFamily: Font_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      print('ลบมิเตอร์$type , index: ${index}');
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

///////////////------------------------------------------------------->
  Future<void> Edit_meter_(type, Number, index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Center(
              child: Text(
            'แก้ไขมิเตอร์$type($Number)',
            style: const TextStyle(
              color: CustomerScreen_Color.Colors_Text1_,
              fontWeight: FontWeight.bold,
              fontFamily: FontWeight_.Fonts_T,
            ),
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    // controller:
                    //     Form1_text,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 13) {
                        return 'ใส่ข้อมูลให้ครบถ้วน ';
                      }
                      // if (int.parse(value.toString()) < 13) {
                      //   return '< 13';
                      // }
                      return null;
                    },
                    // maxLength: 13,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.3),
                        filled: true,
                        prefixIcon: Icon(
                            (type.toString() == 'น้ำ')
                                ? Icons.water
                                : Icons.electrical_services,
                            color: (type.toString() == 'น้ำ')
                                ? Colors.blue
                                : Colors.red),
                        // suffixIcon: Icon(Icons.clear, color: Colors.black),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        labelText: 'รหัสเครื่องมิเตอร์$type',
                        labelStyle: const TextStyle(
                          color: ManageScreen_Color.Colors_Text2_,
                          // fontWeight:
                          //     FontWeight.bold,
                          fontFamily: Font_.Fonts_T,
                        )),
                    inputFormatters: <TextInputFormatter>[
                      // for below version 2 use this
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      // for version 2 and greater youcan also use this
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: const Center(
                        child: Text(
                          'บันทึก',
                          style: TextStyle(
                            // fontSize: 15,
                            color: Colors.white,
                            fontFamily: Font_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      print('Editมิเตอร์$type , index: ${index}');
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: const Center(
                        child: Text(
                          'ปิด',
                          style: TextStyle(
                            // fontSize: 15,
                            color: Colors.white,
                            fontFamily: Font_.Fonts_T,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      print('Editมิเตอร์$type , index: ${index}');
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

///////////////------------------------------------------------------->
@override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            }),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Text(
                                'มิเตอร์ไฟฟ่า',
                                style: TextStyle(
                                  // fontSize: 15,
                                  color: (Ser_Body == 0)
                                      ? Colors.white
                                      : Colors.grey[800],
                                  fontFamily: Font_.Fonts_T,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              Ser_Body = 0;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Text(
                                'มิเตอร์น้ำ',
                                style: TextStyle(
                                  // fontSize: 15,
                                  color: (Ser_Body == 1)
                                      ? Colors.white
                                      : Colors.grey[800],
                                  fontFamily: Font_.Fonts_T,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              Ser_Body = 1;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  if (Ser_Body == 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 18,
                                  'มิเตอร์ไฟ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: CustomerScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T
                                      //fontSize: 10.0
                                      //fontSize: 10.0
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: InkWell(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50),
                                          bottomLeft: Radius.circular(50),
                                          bottomRight: Radius.circular(50),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      Addelectric_meter_();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            minFontSize: 8,
                            maxFontSize: 12,
                            'All 20',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T
                                //fontSize: 10.0
                                //fontSize: 10.0
                                ),
                          ),
                        ),
                      ],
                    ),
                  if (Ser_Body == 0)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: (Responsive.isDesktop(context))
                          ? MediaQuery.of(context).size.height * 0.6
                          : 230,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        }),
                        child: ResponsiveGridList(
                            horizontalGridSpacing:
                                16, // Horizontal space between grid items

                            horizontalGridMargin:
                                30, // Horizontal space around the grid
                            verticalGridMargin:
                                30, // Vertical space around the grid
                            minItemWidth:
                                100, // The minimum item width (can be smaller, if the layout constraints are smaller)
                            minItemsPerRow:
                                2, // The minimum items to show in a single row. Takes precedence over minItemWidth
                            maxItemsPerRow:
                                10, // The maximum items to show in a single row. Can be useful on large screens
                            listViewBuilderOptions:
                                ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                            children: List.generate(
                              30,
                              (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppbackgroundColor.TiTile_Colors,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: Colors.grey, width: 2),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            child: Image.asset(
                                                'images/electric_meter.png'),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 50,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 18,
                                                'รหัสเครื่อง: 000${index + 1}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: CustomerScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // width: 100,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: InkWell(
                                                //     child: Container(
                                                //       decoration:
                                                //           const BoxDecoration(
                                                //         color: Colors.white,
                                                //         borderRadius:
                                                //             BorderRadius.only(
                                                //           topLeft:
                                                //               Radius.circular(
                                                //                   0),
                                                //           topRight:
                                                //               Radius.circular(
                                                //                   0),
                                                //           bottomLeft:
                                                //               Radius.circular(
                                                //                   5),
                                                //           bottomRight:
                                                //               Radius.circular(
                                                //                   0),
                                                //         ),
                                                //       ),
                                                //       padding:
                                                //           const EdgeInsets.all(
                                                //               4.0),
                                                //       child: const Icon(
                                                //         Icons.delete,
                                                //         color: Colors.red,
                                                //       ),
                                                //     ),
                                                //     onTap: () {
                                                //       delete_meter_('ไฟ',
                                                //           '123456', index);
                                                //     },
                                                //   ),
                                                // ),
                                                Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: const Text(
                                                        'แก้ไข',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T
                                                            //fontSize: 10.0
                                                            //fontSize: 10.0
                                                            ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Edit_meter_(
                                                          'ไฟ',
                                                          '000${index + 1}',
                                                          index);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: InkWell(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(2.0),
                                          child: const Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                        ),
                                        onTap: () {
                                          delete_meter_(
                                              'ไฟ', '000${index + 1}', index);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  if (Ser_Body == 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 18,
                                  'มิเตอร์น้ำ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: CustomerScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T
                                      //fontSize: 10.0
                                      //fontSize: 10.0
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: InkWell(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50),
                                          bottomLeft: Radius.circular(50),
                                          bottomRight: Radius.circular(50),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      Addwater_meter_();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            minFontSize: 8,
                            maxFontSize: 12,
                            'All 20',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T
                                //fontSize: 10.0
                                //fontSize: 10.0
                                ),
                          ),
                        ),
                      ],
                    ),
                  if (Ser_Body == 01)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: (Responsive.isDesktop(context))
                          ? MediaQuery.of(context).size.height * 0.6
                          : 230,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        }),
                        child: ResponsiveGridList(
                            horizontalGridSpacing:
                                16, // Horizontal space between grid items

                            horizontalGridMargin:
                                30, // Horizontal space around the grid
                            verticalGridMargin:
                                30, // Vertical space around the grid
                            minItemWidth:
                                100, // The minimum item width (can be smaller, if the layout constraints are smaller)
                            minItemsPerRow:
                                2, // The minimum items to show in a single row. Takes precedence over minItemWidth
                            maxItemsPerRow:
                                10, // The maximum items to show in a single row. Can be useful on large screens
                            listViewBuilderOptions:
                                ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                            children: List.generate(
                              30,
                              (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppbackgroundColor.TiTile_Colors,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: Colors.grey, width: 2),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            child: Image.asset(
                                                'images/water_meter.png'),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 50,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 18,
                                                'รหัสเครื่อง: 000${index + 1}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: CustomerScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            // width: 100,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: const Text(
                                                        'แก้ไข',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T
                                                            //fontSize: 10.0
                                                            //fontSize: 10.0
                                                            ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Edit_meter_(
                                                          'น้ำ',
                                                          '000${index + 1}',
                                                          index);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: InkWell(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(2.0),
                                          child: const Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                        ),
                                        onTap: () {
                                          delete_meter_(
                                              'น้ำ', '000${index + 1}', index);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
