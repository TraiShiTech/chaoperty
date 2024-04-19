// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../Style/colors.dart';

class PeopleChaoScreen4 extends StatefulWidget {
//////////////////////----------------------------->ยกเลิกสัญญา
  const PeopleChaoScreen4({
    super.key,
  });

  @override
  State<PeopleChaoScreen4> createState() => _PeopleChaoScreen4State();
}

class _PeopleChaoScreen4State extends State<PeopleChaoScreen4> {
  @override
  void initState() {
    super.initState();
  }

  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();

  ///----------------->
  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 150,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 150,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveUp2() {
    _scrollController2.animateTo(_scrollController2.offset - 150,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown2() {
    _scrollController2.animateTo(_scrollController2.offset + 150,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  final Set<int> _pressedIndices = Set();
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration:  BoxDecoration(
              color: AppbackgroundColor.TiTile_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
              // border: Border.all(color: Colors.white, width: 1),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'ยกเลิกสัญญา',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    //0953873075
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 15,
                                'รหัสพื้นที่ : ',
                                style: TextStyle(
                                  color: TextHome_Color.TextHome_Colors,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 15,
                                  'xxxxxxxxxxxxxx',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      minFontSize: 10,
                                      maxFontSize: 15,
                                      'ชื่อผู้เช่า : ',
                                      style: TextStyle(
                                        color: TextHome_Color.TextHome_Colors,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: const AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 15,
                                        'PET SHOP',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 15,
                                        'เลขที่สัญญา : ',
                                        style: TextStyle(
                                          color: TextHome_Color.TextHome_Colors,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: const AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'KN1001',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            //0953873075
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 450,
                      decoration:  BoxDecoration(
                        color: AppbackgroundColor.TiTile_Colors,
                        // color: AppbackgroundColor.Sub_Abg_Colors,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        // border: Border.all(
                        //     color: Colors.grey, width: 1),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'วันที่เริ่มทำสัญญา',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'DD/MM/YYYY',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(
                                    flex: 1,
                                    child: Text(
                                      'เหตุผล',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 8 * 24.0,
                                    decoration: const BoxDecoration(
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      // border: Border.all(
                                      //     color: Colors.grey, width: 1),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          height: 5 * 24.0,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'daddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddta',
                                              maxLines: 4,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 5),
                                                child: TextField(
                                                  autofocus: false,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  maxLines: 2,
                                                  decoration: InputDecoration(
                                                    hintText: "Send a message",
                                                    fillColor: Colors.grey[300],
                                                    filled: true,
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.white),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(50),
                                                    topRight:
                                                        Radius.circular(50),
                                                    bottomLeft:
                                                        Radius.circular(50),
                                                    bottomRight:
                                                        Radius.circular(50),
                                                  ),
                                                  // border: Border.all(
                                                  //     color: Colors.grey, width: 1),
                                                ),
                                                child: IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(Icons.send,
                                                        color: Colors.blue)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(
                                    flex: 1,
                                    child: Text(
                                      'หมายเหตุ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 7 * 24.0,
                                    decoration: const BoxDecoration(
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      // border: Border.all(
                                      //     color: Colors.grey, width: 1),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          height: 4 * 24.0,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'daddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddta',
                                              maxLines: 4,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 5),
                                                child: TextField(
                                                  maxLines: 2,
                                                  decoration: InputDecoration(
                                                    hintText: "Send a message",
                                                    fillColor: Colors.grey[300],
                                                    filled: true,
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.white),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(50),
                                                    topRight:
                                                        Radius.circular(50),
                                                    bottomLeft:
                                                        Radius.circular(50),
                                                    bottomRight:
                                                        Radius.circular(50),
                                                  ),
                                                  // border: Border.all(
                                                  //     color: Colors.grey, width: 1),
                                                ),
                                                child: IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(Icons.send,
                                                        color: Colors.blue)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Container(
                      height: 450,
                      decoration:  BoxDecoration(
                        color: AppbackgroundColor.TiTile_Colors,
                        // color: AppbackgroundColor.Sub_Abg_Colors,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        // border: Border.all(
                        //     color: Colors.grey, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      // color: AppbackgroundColor.Sub_Abg_Colors,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รายการ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                //fontSize: 10.0
                                              ),
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              'ยอด',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                //fontSize: 10.0
                                              ),
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รายละเอียดบิล',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                //fontSize: 10.0
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Colors.white30,
                                          // color: AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'สรุปยอดค้างชำระ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    //fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                )),
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '-25,000',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    //fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius
                                                            .only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: const Text(
                                                        'ทำรายการ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          //fontWeight: FontWeight.bold,
                                                          //fontSize: 10.0
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Colors.white30,
                                          // color: AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'สรุปเงินประกันที่ต้องคืน',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    //fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                )),
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '+25,000',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    //fontWeight: FontWeight.bold,
                                                    //fontSize: 10.0
                                                  ),
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius
                                                            .only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: const Text(
                                                        'ทำรายการ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          //fontWeight: FontWeight.bold,
                                                          //fontSize: 10.0
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  '**กรุณาเคลียร์รายการค้างชำระให้หมดก่อนจึงดำเนินการได้',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold,
                                    //fontSize: 10.0
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 150,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Center(
                                      child: Text(
                                        'ยกเลิกสัญญา',
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          //fontSize: 10.0
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                )),
          ],
        ),
        // const SizedBox(
        //   height: 50,
        // )
      ],
    );
  }
}
