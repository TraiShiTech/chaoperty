import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:scroll_to_index/scroll_to_index.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../Style/colors.dart';

class TestScoll extends StatefulWidget {
  const TestScoll({super.key});

  @override
  State<TestScoll> createState() => _TestScollState();
}

class _TestScollState extends State<TestScoll> {
  // final ItemScrollController itemScrollController = ItemScrollController();
  // // final ScrollOffsetController scrollOffsetController =
  // //     ScrollOffsetController();
  // final ItemPositionsListener itemPositionsListener =
  //     ItemPositionsListener.create();
  // // final ScrollOffsetListener scrollOffsetListener =
  // //     ScrollOffsetListener.create();
  // final ItemScrollController _scrollController1 = ItemScrollController();
  int tappedIndex_ = 0;
  List item = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "39",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
    "49",
    "50",
  ];

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // itemScrollController.jumpTo(index: 35);
    // WidgetsBinding.instance
    //     .addPersistentFrameCallback((_) => scrollToIndex(35));
  }

  // void scrollToIndex(index) => itemScrollController.jumpTo(index: index);

  // void _animateToIndex(int index) {
  //   double contentHeight = MediaQuery.of(context).size.height > 700
  //       ? MediaQuery.of(context).size.height * 0.89
  //       : MediaQuery.of(context).size.height * 0.85;
  //   _controller.jumpTo(index * contentHeight);
  //   // .animateTo(
  //   //   index * _height,
  //   //   duration: Duration(seconds: 2),
  //   //   curve: Curves.fastOutSlowIn,
  //   // );
  // }
  Future _scrollToIndex(int index) async {
    _controller.jumpTo(
        _controller.position.maxScrollExtent / (item.length - 1) * index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _scrollToIndex(30);
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          // ScrollablePositionedList.builder(
          // itemScrollController: _scrollController1,
          // scrollOffsetController: scrollOffsetController,
          // itemPositionsListener: itemPositionsListener,
          // scrollOffsetListener: scrollOffsetListener,
          scrollDirection: Axis.vertical,
          controller: _controller,
          itemCount: item.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                color: tappedIndex_ == index
                    ? tappedIndex_Color.tappedIndex_Colors.withOpacity(0.5)
                    : null,
                child: ListTile(
                    onTap: () {
                      // _animateToIndex(index);
                      setState(() {
                        _scrollToIndex(index);
                        // itemScrollController.jumpTo(index: 35);
                        // itemPositionsListener.itemPositions.addListener(() {
                        //   final ibdices =
                        //       itemPositionsListener.itemPositions.value
                        //           .where((element) {
                        //             final isTopvisbible =
                        //                 element.itemLeadingEdge >= 0;
                        //             final isBottomvisbible =
                        //                 element.itemLeadingEdge <= 1;
                        //             return isTopvisbible && isBottomvisbible;
                        //           })
                        //           .map(
                        //             (e) => item,
                        //           )
                        //           .toList();

                        // print(ibdices);
                        // });
                        // itemScrollController.jumpTo(index: 25);
                        tappedIndex_ = index;
                      });
                    },
                    title: Row(
                      children: [Text('${item[index]}')],
                    )));
          }),
    );
  }
}
