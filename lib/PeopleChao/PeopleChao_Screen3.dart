import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../Style/colors.dart';

class PeopleChaoScreen3 extends StatefulWidget {
//////////------------------------------------->คุมเงินประกัน
  const PeopleChaoScreen3({
    super.key,
  });

  @override
  State<PeopleChaoScreen3> createState() => _PeopleChaoScreen3State();
}

class _PeopleChaoScreen3State extends State<PeopleChaoScreen3> {
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
                  'คุมเงินประกัน',
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
                                child: const AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 15,
                                  'xxxxxxxxxxx',
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.brown[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              // border: Border.all(
                              //     color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'ประเภทบิล',
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.brown[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              // border: Border.all(
                              //     color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.brown[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              // border: Border.all(
                              //     color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'ทั้งหมด',
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.brown[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              // border: Border.all(
                              //     color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                '',
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
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                '....',
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'ประเภท',
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'วันที่ชำระ',
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'เลขที่ออกบิล',
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
                      ],
                    ),
                    Container(
                      height: 250,
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
                      child: ListView.builder(
                        controller: _scrollController1,
                        // itemExtent: 50,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {},
                            child: ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: _pressedIndices.contains(index)
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (_pressedIndices
                                                      .contains(index))
                                                    _pressedIndices
                                                        .remove(index);
                                                  else
                                                    _pressedIndices.add(index);
                                                });
                                                print(_pressedIndices);
                                              },
                                              icon: const Icon(
                                                Icons.check_box,
                                                color: Colors.blue,
                                              ))
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (_pressedIndices
                                                      .contains(index))
                                                    _pressedIndices
                                                        .remove(index);
                                                  else
                                                    _pressedIndices.add(index);
                                                });
                                                print(_pressedIndices);
                                              },
                                              icon: const Icon(
                                                Icons.data_array_rounded,
                                                color: Colors.grey,
                                              ))),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'ประกันความเสียหาย${index + 1}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: TextHome_Color.TextHome_Colors,
                                        //fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: Text(
                                      '28/1/2023',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: TextHome_Color.TextHome_Colors,
                                        //fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: Text(
                                      'DE00001',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: TextHome_Color.TextHome_Colors,
                                        //fontWeight: FontWeight.bold,
                                        //fontSize: 10.0
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: AppbackgroundColor.Sub_Abg_Colors,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                // color: Colors.grey,
                                height: 110,
                                width: 300,
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                width: 100,
                                                decoration: const BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.only(
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
                                                  // border: Border.all(color: Colors.white, width: 1),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: const Center(
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    'เพิ่มใหม่',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      //fontWeight: FontWeight.bold,
                                                      //0953873075
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              width: 100,
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                // border: Border.all(color: Colors.white, width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Center(
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 15,
                                                  'แก้ไข',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    //fontWeight: FontWeight.bold,
                                                    //0953873075
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            _scrollController1.animateTo(
                                              0,
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.easeOut,
                                            );
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                // color: AppbackgroundColor
                                                //     .TiTile_Colors,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(8)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: const Text(
                                                'Top',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10.0),
                                              )),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (_scrollController1.hasClients) {
                                            final position = _scrollController1
                                                .position.maxScrollExtent;
                                            _scrollController1.animateTo(
                                              position,
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.easeOut,
                                            );
                                          }
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              // color: AppbackgroundColor
                                              //     .TiTile_Colors,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(6)),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(3.0),
                                            child: const Text(
                                              'Down',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: _moveUp1,
                                        child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Icon(
                                                Icons.arrow_upward,
                                                color: Colors.grey,
                                              ),
                                            )),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                            // color: AppbackgroundColor
                                            //     .TiTile_Colors,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    topRight:
                                                        Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(6)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(3.0),
                                          child: const Text(
                                            'Scroll',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.0),
                                          )),
                                      InkWell(
                                        onTap: _moveDown1,
                                        child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                Icons.arrow_downward,
                                                color: Colors.grey,
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ))
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.brown[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              // border: Border.all(
                              //     color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'รายละเอียดบิล',
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.brown[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              // border: Border.all(
                              //     color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.brown[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              // border: Border.all(
                              //     color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'เลขที่ใบแจ้งหนี้ INV01002',
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.brown[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              // border: Border.all(
                              //     color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                '',
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
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'ลำดับ',
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'กำหนดชำระ',
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'รายการ',
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'จำนวน',
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'หน่วย',
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'ราคาต่อหน่วย',
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: Colors.brown[200],
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'ราคารวม',
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
                      ],
                    ),
                    Container(
                      height: 250,
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
                      child: ListView.builder(
                        controller: _scrollController2,
                        // itemExtent: 50,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'XXX${index + 1}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: TextHome_Color.TextHome_Colors,
                                      //fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    '-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: TextHome_Color.TextHome_Colors,
                                      //fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    '-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: TextHome_Color.TextHome_Colors,
                                      //fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    '-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: TextHome_Color.TextHome_Colors,
                                      //fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    '-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: TextHome_Color.TextHome_Colors,
                                      //fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    '-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: TextHome_Color.TextHome_Colors,
                                      //fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    '-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: TextHome_Color.TextHome_Colors,
                                      //fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: AppbackgroundColor.Sub_Abg_Colors,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                color: Colors.grey,
                                // height: 100,
                                width: 300,
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Row(
                                    children: const [
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'รวม(บาท)',
                                          style: TextStyle(
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            //0953873075
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'xxxxxxxxxx',
                                          style: TextStyle(
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            //0953873075
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'ภาษีมูลค่าเพิ่ม(vat)',
                                          style: TextStyle(
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            //0953873075
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'xxxxx.xxxxx',
                                          style: TextStyle(
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            //0953873075
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'หัก ณ ที่จ่าย',
                                          style: TextStyle(
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            //0953873075
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'xxxxxxxxxx',
                                          style: TextStyle(
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            //0953873075
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'เพิ่ม/ลด',
                                          style: TextStyle(
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            //0953873075
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'xxxxxxxxxx',
                                          style: TextStyle(
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            //0953873075
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'ยอดชำระ',
                                          style: TextStyle(
                                            color: Colors.red[800],
                                            fontWeight: FontWeight.bold,
                                            //0953873075
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 10,
                                          maxFontSize: 15,
                                          'xxxxxxxxxx',
                                          style: TextStyle(
                                            color: Colors.red[800],
                                            fontWeight: FontWeight.bold,
                                            //0953873075
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            _scrollController2.animateTo(
                                              0,
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.easeOut,
                                            );
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                // color: AppbackgroundColor
                                                //     .TiTile_Colors,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(8)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: const Text(
                                                'Top',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10.0),
                                              )),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (_scrollController2.hasClients) {
                                            final position = _scrollController2
                                                .position.maxScrollExtent;
                                            _scrollController2.animateTo(
                                              position,
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.easeOut,
                                            );
                                          }
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              // color: AppbackgroundColor
                                              //     .TiTile_Colors,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(6)),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(3.0),
                                            child: const Text(
                                              'Down',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: _moveUp2,
                                        child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Icon(
                                                Icons.arrow_upward,
                                                color: Colors.grey,
                                              ),
                                            )),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                            // color: AppbackgroundColor
                                            //     .TiTile_Colors,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    topRight:
                                                        Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(6)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(3.0),
                                          child: const Text(
                                            'Scroll',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.0),
                                          )),
                                      InkWell(
                                        onTap: _moveDown2,
                                        child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                Icons.arrow_downward,
                                                color: Colors.grey,
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ))
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              // border: Border.all(
                              //     color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'เลขที่ใบเสร็จ RE11002',
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
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'ยอดชำระรวม',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: TextHome_Color.TextHome_Colors,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'xxx',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: TextHome_Color.TextHome_Colors,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'รูปแบบการชำระ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: TextHome_Color.TextHome_Colors,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'xxx',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: TextHome_Color.TextHome_Colors,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'วันเวลาชำระ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: TextHome_Color.TextHome_Colors,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'xxx',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: TextHome_Color.TextHome_Colors,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: Text(
                                'หลักฐาน',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: TextHome_Color.TextHome_Colors,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 10.0
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    // border: Border.all(
                                    //     color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'เรียกดูไฟล์',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                title: const Center(
                                  child: Text(
                                    'วันที่คืนเงินประกัน ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      //fontSize: 10.0
                                    ),
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0)),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Text(
                                                    'ยอดชำระคืน',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ))),
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[350],
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0)),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Text('25,000')))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.grey,
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
                                                                    0)),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Text(
                                                    'รูปแบบการชำระ',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ))),
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[350],
                                                    borderRadius:
                                                        const BorderRadius.only(
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
                                                                    0)),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Text(
                                                      'โอนเข้าบัญชี xx')))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.grey,
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
                                                                    0)),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Text(
                                                    'วัน เวลา ชำระ',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ))),
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[350],
                                                    borderRadius:
                                                        const BorderRadius.only(
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
                                                                    0)),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      const Text('DD/MM/YYYY')))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.grey,
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
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0)),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Text(
                                                    'หลักฐาน',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ))),
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[350],
                                                    borderRadius:
                                                        const BorderRadius.only(
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
                                                                    10)),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Center(
                                                      child: InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: const Text(
                                                          'UPLOAD FILE',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )),
                                                  ))))
                                        ],
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
                                        child: TextButton(
                                          child: Container(
                                            width: 100,
                                            decoration: const BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'คืนเงินประกัน',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextButton(
                                          child: Container(
                                            width: 100,
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'ยกเลิก',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
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
                        },
                        child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              // border: Border.all(color: Colors.white, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                                child: Text(
                              'คืนเงินประกัน',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
