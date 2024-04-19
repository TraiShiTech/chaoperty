import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:side_sheet/side_sheet.dart';

import '../Constant/Myconstant.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/Get_Chat_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';

class ChatScreen extends StatefulWidget {
  final ser_user;
  final userModels_chat_;
  final userModels_;
  const ChatScreen(
      {super.key, this.ser_user, this.userModels_chat_, this.userModels_});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int Chat_no_read = 0;
  bool no_read = true;
  String? base64_Imgmap, foder, img_logo, renTal_name;
  ScrollController _scrollController_chat = ScrollController();
  List<ChatModel> chatModel = [];
  List<ChatModel> chatModel_new = [];
  List<UserModel> userModels_chat = [];
  List<UserModel> userModels = [];
  // List<ChatModel> _chatModel = <ChatModel>[];
  late StreamController<int> _streamController;
  late int _counter;
  late Timer _timer;
  String? ser_user;
///////////------------------------------------------->

  @override
  void initState() {
    super.initState();
    read_GC_rental();
    red_Chat();
    startTimer();
  }

  @override
  void dispose() {
    _streamController.close();
    _timer!.cancel();
    super.dispose();
  }


///////////------------------------------------------->
  // void startUpdates() {
  //   // Start periodic updates if not already started
  //   if (!_timer.isActive) {
  //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //       _streamController.add(_counter);
  //       _counter++;
  //     });
  //   }
  //   print('${!_timer.isActive}');
  // }

  // void stopUpdates() {
  //   // Cancel the timer to stop periodic updates
  //   _timer.cancel();
  //   print('${!_timer.isActive}');
  // }
  void startUpdates() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
        await red_Chat2();
        _streamController.add(_counter);
        _counter++;
        //   print('objectTimer ${chatModel_new.length}// ${chatModel.length}');
      });
    }
    //   print('Timer isActive: ${_timer!.isActive}');
  }

  void stopUpdates() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    //   print('Timer canceled');
  }

  ///////////------------------------------------------->
  List colorList = [
    Colors.orangeAccent[100],
    Colors.white60,
    Colors.yellowAccent[100],
    Colors.white60
  ];
  Future<Null> read_GC_rental() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      //  print('GC_rental_setring>> $result');
      if (result != null) {
        for (var map in result) {
          RenTalModel renTalModel = RenTalModel.fromJson(map);
          var rtnamex = renTalModel.rtname;
          var typexs = renTalModel.type;
          var typexx = renTalModel.typex;
          var name = renTalModel.pn!.trim();
          var pkqtyx = int.parse(renTalModel.pkqty!);
          var pkuserx = int.parse(renTalModel.pkuser!);
          var pkx = renTalModel.pk!.trim();
          var foderx = renTalModel.dbn;
          var img = renTalModel.img;
          var imglogo = renTalModel.imglogo;
          var pksdatex = renTalModel.pksdate;
          var pkldatex = renTalModel.pkldate;
          var data_updatex = renTalModel.data_update;
          setState(() {
            userModels_chat = widget.userModels_chat_;
            userModels = widget.userModels_;
            ser_user = widget.ser_user.toString();
            renTal_name = preferences.getString('renTalName');
            foder = foderx;
            img_logo = imglogo;
          });
        }
      } else {}
    } catch (e) {}
    // if (renTalModels.isNotEmpty) {
    //   dynamic colorsren = renTalModels[0].colors_ren;

    //   if (colorsren is String) {
    //     setState(() => pickerColor = Color(int.parse(colorsren)));
    //     setState(() => AppBarColors.hexColor = Color(int.parse(colorsren)));
    //     // print('Color(int.parse(colorsren))');
    //     // print(Color(int.parse(colorsren)));
    //     // print(pickerColor);
    //   } else {
    //     // Handle the case where colorsren is not a String
    //   }
    // }
  }

  Future<Null> red_Chat() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (chatModel.isNotEmpty) {
      chatModel.clear();
    }

    var ren = preferences.getString('renTalSer');
    var email_ = preferences.getString('email');
    String url = '${MyConstant().domain}/GC_chat.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          ChatModel chatModels = ChatModel.fromJson(map); //chatModel_new

          setState(() {
            // chatModel_new.add(chatModels);
            chatModel.add(chatModels);
          });
        }
      } else {}
      Future.delayed(Duration(milliseconds: 500), () {
        if (_scrollController_chat.hasClients) {
          final position = _scrollController_chat.position.maxScrollExtent;
          _scrollController_chat.animateTo(
            position,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (e) {}
  }

  Future<Null> red_Chat2() async {
    // stopUpdates();
    //         startUpdates();      stopUpdates();
    if (chatModel_new.isNotEmpty) {
      chatModel_new.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var email_ = preferences.getString('email');
    String url = '${MyConstant().domain}/GC_chat.php?isAdd=true&ren=$ren';

    try {
      int index = 0;
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          ChatModel chatModels = ChatModel.fromJson(map);
          setState(() {
            index++;
            chatModel_new.add(chatModels);
          });
        }
      } else {}
      if (chatModel.length != index && index != 0) {
        setState(() {
          chatModel = chatModel_new;
        });
        int randomIndex = Random().nextInt(colorList.length);
        Future.delayed(Duration(milliseconds: 500), () {
          if (_scrollController_chat.hasClients) {
            final position = _scrollController_chat.position.maxScrollExtent;
            _scrollController_chat.animateTo(
              position,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          }
        });
      }
    } catch (e) {}
    // startUpdates();
  }

  Future<void> startTimer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    void checkAndRedChat() {
      setState(() {
        Chat_no_read = preferences.getInt('Chatno_read')!;
      });

      if (no_read == true) {
        if (Chat_no_read != 0) {
        } else {
          red_Chat3();
        }
      } else {}

      // Schedule the next check
      Future.delayed(Duration(seconds: 5), checkAndRedChat);
    }

    // Start the initial check
    checkAndRedChat();
  }

  // Future<Null> startTimer() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   Timer.periodic(Duration(seconds: 5), (timer) {
  //     setState(() {
  //       Chat_no_read = preferences.getInt('Chatno_read')!;
  //     });
  //     if (no_read == true) {
  //       if (Chat_no_read != 0) {
  //       } else {
  //         red_Chat3();
  //       }
  //     } else {}
  //   });
  // }

  Future<Null> red_Chat3() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var email_ = preferences.getString('email');
    String url = '${MyConstant().domain}/GC_chat.php?isAdd=true&ren=$ren';
    // setState(() {
    //   Chat_no_read = 0;
    // });
    try {
      int index = 0;
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          ChatModel chatModels = ChatModel.fromJson(map);
          setState(() {
            index++;
          });
        }
      } else {}
      if (index < chatModel.length) {
        setState(() {
          red_Chat();
          // Chat_no_read = 0;
        });
      } else {
        setState(() {
          Chat_no_read = (index - chatModel.length);
        });
      }

      //    print('object//$Chat_no_read  //$index  ///${chatModel.length}');
    } catch (e) {}
    setState(() {
      preferences.setInt('Chatno_read', Chat_no_read);
    });

    // startUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 4)),
        builder: (context, snapshot) {
          int randomIndex = Random().nextInt(colorList.length);

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: (renTal_name == null || Chat_no_read == 0)
                        ? Colors.white60
                        : colorList[randomIndex],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: InkWell(
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await red_Chat();

                      setState(() {
                        no_read = false;
                        _streamController = StreamController<int>();
                        _counter = 0;
                        preferences.setInt('Chatno_read', 0);
                      });

                      Future.delayed(Duration(milliseconds: 500), () {
                        if (_scrollController_chat.hasClients) {
                          final position =
                              _scrollController_chat.position.maxScrollExtent;
                          _scrollController_chat.animateTo(
                            position,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                        }
                      });

                      _timer = Timer.periodic(Duration(seconds: 2), (timer) {
                        Future.microtask(() async {
                          await red_Chat2();
                          _streamController.add(_counter);
                          _counter++;
                          // print(
                          //     'objectTimer ${chatModel_new.length}// ${chatModel.length}');
                        });
                      });

                      // _timer = Timer.periodic(Duration(seconds: 2), (timer) {
                      //   // red_Chat2();
                      //   _streamController.add(_counter);
                      //   _counter++;
                      //   print(
                      //       'objectTimer ${chatModel_new.length}// ${chatModel.length}');
                      // });
                      //     print('object');

                      SideSheet.right(
                        barrierDismissible: false,
                        context: context,
                        width: (Responsive.isDesktop(context))
                            ? MediaQuery.of(context).size.width / 4
                            : MediaQuery.of(context).size.width / 1.3,
                        body: Container(
                          color: Colors.green[50]!.withOpacity(0.5),
                          child: Column(
                            children: [
                              StreamBuilder(
                                  stream: Stream.periodic(
                                      const Duration(seconds: 0)),
                                  builder: (context, snapshot) {
                                    return Container(
                                        color: Colors.green[300],
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(children: <Widget>[
                                          IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                no_read = true;
                                              });
                                              stopUpdates();
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          // ElevatedButton(
                                          //   onPressed: startUpdates,
                                          //   child: Text('Start Updates'),
                                          // ),
                                          // ElevatedButton(
                                          //   onPressed: stopUpdates,
                                          //   child: Text('Stop Updates'),
                                          // ),
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${MyConstant().domain}/files/$foder/logo/$img_logo'),
                                            maxRadius: 20,
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "$renTal_name",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                // _streamRunning
                                                //     ? Icon(Icons.pause)
                                                //     : Icon(Icons.play_arrow),
                                                Text(
                                                  "Online ${userModels.length} ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),
                                                )
                                              ],
                                            ),
                                          ),
                                          // InkWell(
                                          //   onTap: () {
                                          //     if (_scrollController_chat
                                          //         .hasClients) {
                                          //       final position =
                                          //           _scrollController_chat
                                          //               .position
                                          //               .maxScrollExtent;
                                          //       _scrollController_chat
                                          //           .animateTo(
                                          //         position,
                                          //         duration: const Duration(
                                          //             seconds: 1),
                                          //         curve: Curves.easeOut,
                                          //       );
                                          //     }
                                          //   },
                                          //   child: Icon(
                                          //     Icons.settings,
                                          //     color: Colors.black54,
                                          //   ),
                                          // ),
                                        ]));
                                  }),
                              Expanded(
                                child: StreamBuilder<void>(
                                    stream: _streamController.stream,
                                    // stream: Stream<void>.periodic(
                                    //     const Duration(seconds: 1), (i) {
                                    //   print(i);
                                    // }).takeWhile((element) => stream_int),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        controller: _scrollController_chat,
                                        scrollDirection: Axis.vertical,
                                        dragStartBehavior:
                                            DragStartBehavior.down,
                                        itemCount: chatModel.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        // physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return (chatModel[index]
                                                      .user
                                                      .toString() ==
                                                  ser_user.toString())
                                              ? SizedBox(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      if (chatModel[index]
                                                                  .content ==
                                                              '' ||
                                                          chatModel[index]
                                                                  .content ==
                                                              null)
                                                        BubbleNormalImage(
                                                          id: '',
                                                          //  color: Colors.grey,
                                                          image: Container(
                                                            constraints:
                                                                BoxConstraints(
                                                              minHeight: 150.0,
                                                              minWidth: 220.0,
                                                            ),
                                                            child: Stack(
                                                              children: [
                                                                CachedNetworkImage(
                                                                  width: 220,
                                                                  height: 150,
                                                                  imageUrl:
                                                                      '${MyConstant().domain}/files/$foder/chat/${chatModel[index].img}',
                                                                  // "${chatModel[index].img}",
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(5)),
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      CircularProgressIndicator(),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                Positioned(
                                                                    top: 5,
                                                                    right: 10,
                                                                    child:
                                                                        PopupMenuButton<
                                                                            int>(
                                                                      tooltip:
                                                                          '',
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .white
                                                                              .withOpacity(0.9),
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(20)),
                                                                        ),
                                                                        padding:
                                                                            const EdgeInsets.all(2.0),
                                                                        child: Icon(
                                                                            Icons.more_vert),
                                                                      ),
                                                                      itemBuilder:
                                                                          (context) {
                                                                        return [
                                                                          PopupMenuItem<int>(
                                                                              value: 1,
                                                                              child: Text("ยกเลิกการส่ง")),
                                                                          // PopupMenuItem<
                                                                          //         int>(
                                                                          //     value: 2,
                                                                          //     child: Text(
                                                                          //         "Share")),
                                                                        ];
                                                                      },
                                                                      onOpened:
                                                                          () {
                                                                        stopUpdates();

                                                                        // print('onOpened');
                                                                      },
                                                                      onCanceled:
                                                                          () {
                                                                        startUpdates();
                                                                        // print(
                                                                        //     'onCanceled');
                                                                      },
                                                                      onSelected:
                                                                          (value) async {
                                                                        // print(
                                                                        //     'DismissDirection');
                                                                        SharedPreferences
                                                                            preferences =
                                                                            await SharedPreferences.getInstance();
                                                                        var ren =
                                                                            preferences.getString('renTalSer');
                                                                        try {
                                                                          final url =
                                                                              '${MyConstant().domain}/In_c_chat.php';

                                                                          final response = await http.post(
                                                                              Uri.parse(url),
                                                                              body: {
                                                                                'isAdd': 'true',
                                                                                'user': '$ser_user',
                                                                                'ren': '$ren',
                                                                                'content': '',
                                                                                'img': '',
                                                                                'audio': '',
                                                                                'Dismissible': "2",
                                                                                'Serchat': '${chatModel[index].ser}'
                                                                              });
                                                                        } catch (e) {}
                                                                        setState(
                                                                            () {
                                                                          red_Chat();
                                                                          startUpdates();
                                                                        });
                                                                      },
                                                                    ))
                                                              ],
                                                            ),
                                                          ),
                                                          // color: Colors.purpleAccent,
                                                          tail: false,
                                                          isSender: true,
                                                          delivered: false,
                                                          seen: false,
                                                          onTap: () {},
                                                        ),
                                                      if (chatModel[index]
                                                                  .img ==
                                                              '' ||
                                                          chatModel[index]
                                                                  .img ==
                                                              null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 8, 0),
                                                          child: ChatBubble(
                                                            clipper: ChatBubbleClipper6(
                                                                type: BubbleType
                                                                    .sendBubble),
                                                            alignment: Alignment
                                                                .topRight,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 4),
                                                            backGroundColor:
                                                                Colors
                                                                    .blue[300],
                                                            child: Container(
                                                                constraints:
                                                                    BoxConstraints(
                                                                  maxWidth:
                                                                      (MediaQuery.of(context).size.width /
                                                                              4) /
                                                                          2,
                                                                ),
                                                                child:
                                                                    PopupMenuButton<
                                                                        int>(
                                                                  tooltip: '',
                                                                  child: Text(
                                                                    "${chatModel[index].content}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  itemBuilder:
                                                                      (context) {
                                                                    return [
                                                                      PopupMenuItem<
                                                                              int>(
                                                                          value:
                                                                              1,
                                                                          child:
                                                                              Text("ยกเลิกการส่ง")),
                                                                      // PopupMenuItem<
                                                                      //         int>(
                                                                      //     value: 2,
                                                                      //     child: Text(
                                                                      //         "Share")),
                                                                    ];
                                                                  },
                                                                  onOpened:
                                                                      stopUpdates,
                                                                  onCanceled:
                                                                      startUpdates,
                                                                  onSelected:
                                                                      (value) async {
                                                                    // print(
                                                                    //     'DismissDirection');
                                                                    SharedPreferences
                                                                        preferences =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    var ren = preferences
                                                                        .getString(
                                                                            'renTalSer');
                                                                    try {
                                                                      final url =
                                                                          '${MyConstant().domain}/In_c_chat.php';

                                                                      final response = await http.post(
                                                                          Uri.parse(
                                                                              url),
                                                                          body: {
                                                                            'isAdd':
                                                                                'true',
                                                                            'user':
                                                                                '$ser_user',
                                                                            'ren':
                                                                                '$ren',
                                                                            'content':
                                                                                '',
                                                                            'img':
                                                                                '',
                                                                            'audio':
                                                                                '',
                                                                            'Dismissible':
                                                                                "2",
                                                                            'Serchat':
                                                                                '${chatModel[index].ser}'
                                                                          });
                                                                    } catch (e) {}
                                                                    setState(
                                                                        () {
                                                                      red_Chat();
                                                                      startUpdates();
                                                                    });
                                                                  },
                                                                )),
                                                          ),

                                                          // Dismissible(
                                                          //   background: Container(
                                                          //     color: Colors.red,
                                                          //     child: Align(
                                                          //       alignment: Alignment
                                                          //           .centerRight,
                                                          //       child: Padding(
                                                          //         padding: EdgeInsets
                                                          //             .symmetric(
                                                          //                 horizontal:
                                                          //                     10.0),
                                                          //         child: Icon(
                                                          //             Icons
                                                          //                 .delete,
                                                          //             color: Colors
                                                          //                 .white),
                                                          //       ),
                                                          //     ),
                                                          //   ),
                                                          //   key: UniqueKey(),
                                                          //   direction:
                                                          //       DismissDirection
                                                          //           .endToStart,
                                                          //   confirmDismiss:
                                                          //       (DismissDirection
                                                          //           direction) async {
                                                          //     print(
                                                          //         'confirmDismiss');
                                                          //     // Your confirmation logic goes here
                                                          //     // Return true to allow dismissal, false to prevent it
                                                          //     return true;
                                                          //   },
                                                          //   onDismissed:
                                                          //       (DismissDirection
                                                          //           direction) async {
                                                          //     // print(
                                                          //     //     'DismissDirection');
                                                          //     // SharedPreferences
                                                          //     //     preferences =
                                                          //     //     await SharedPreferences
                                                          //     //         .getInstance();
                                                          //     // var ren = preferences
                                                          //     //     .getString(
                                                          //     //         'renTalSer');
                                                          //     // try {
                                                          //     //   final url =
                                                          //     //       '${MyConstant().domain}/In_c_chat.php';

                                                          //     //   final response =
                                                          //     //       await http.post(
                                                          //     //           Uri.parse(
                                                          //     //               url),
                                                          //     //           body: {
                                                          //     //         'isAdd':
                                                          //     //             'true',
                                                          //     //         'user':
                                                          //     //             '$ser_user',
                                                          //     //         'ren':
                                                          //     //             '$ren',
                                                          //     //         'content':
                                                          //     //             '',
                                                          //     //         'img': '',
                                                          //     //         'audio': '',
                                                          //     //         'Dismissible':
                                                          //     //             "2",
                                                          //     //         'Serchat':
                                                          //     //             '${chatModel[index].ser}'
                                                          //     //       });
                                                          //     //   setState(() {
                                                          //     //     red_Chat();
                                                          //     //   });
                                                          //     // } catch (e) {
                                                          //     //   setState(() {
                                                          //     //     red_Chat();
                                                          //     //   });
                                                          //     // }
                                                          //   },
                                                          //   child:
                                                          // ChatBubble(
                                                          //     clipper: ChatBubbleClipper6(
                                                          //         type: BubbleType
                                                          //             .sendBubble),
                                                          //     alignment: Alignment
                                                          //         .topRight,
                                                          //     margin:
                                                          //         EdgeInsets.only(
                                                          //             top: 4),
                                                          //     backGroundColor:
                                                          //         Colors.blue,
                                                          //     child: Container(
                                                          //       constraints:
                                                          //           BoxConstraints(
                                                          //         maxWidth: (MediaQuery.of(context)
                                                          //                     .size
                                                          //                     .width /
                                                          //                 4) /
                                                          //             2,
                                                          //       ),
                                                          //       child: Text(
                                                          //         "${chatModel[index].content}",
                                                          //         style: TextStyle(
                                                          //             color: Colors
                                                          //                 .white),
                                                          //       ),
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                        ),
                                                      SizedBox(
                                                          height: 20,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        8,
                                                                        0),
                                                                child: Text(
                                                                  "${DateFormat('d MMM', 'th_TH').format(DateTime.parse(chatModel[index].datex.toString()))} ${DateTime.parse('${chatModel[index].datex}').year + 543}  ${chatModel[index].timex} ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .grey,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                      SizedBox(
                                                        height: 50,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                4) /
                                                            2,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                          height: 25,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.brown
                                                                        .shade800,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2.0),
                                                                  child: Text(
                                                                      userModels_chat
                                                                              .where((model) => model.ser == '${chatModel[index].user}')
                                                                              .map((userModel) => userModel.email)
                                                                              .isEmpty
                                                                          ? '??'
                                                                          : userModels_chat.firstWhere((model) => model.ser == '${chatModel[index].user}').email.toString().substring(0, 3) + '..',
                                                                      style: TextStyle(
                                                                          fontSize: 10,
                                                                          // color: Colors
                                                                          //     .grey,
                                                                          fontFamily: Font_.Fonts_T)),
                                                                ),
                                                              ),
                                                              PopupMenuButton(
                                                                tooltip: '',
                                                                child: Text(
                                                                  '${userModels_chat.where((model) => model.ser == '${chatModel[index].user}').map((userModel) => userModel.email).isEmpty ? '??' : '${userModels_chat.firstWhere((model) => model.ser == '${chatModel[index].user}').fname} ${userModels_chat.firstWhere((model) => model.ser == '${chatModel[index].user}').lname}'}',

                                                                  // '${chatModel[index].user}'
                                                                ),
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context) =>
                                                                        [
                                                                  PopupMenuItem(
                                                                    child: InkWell(
                                                                        // onTap: () {

                                                                        // },
                                                                        child: Container(
                                                                            padding: const EdgeInsets.all(10),
                                                                            width: MediaQuery.of(context).size.width,
                                                                            child: Row(
                                                                              children: [
                                                                                Expanded(
                                                                                    child: Text(
                                                                                  '${userModels_chat.where((model) => model.ser == '${chatModel[index].user}').map((userModel) => userModel.email).isEmpty ? '??' : '${userModels_chat.firstWhere((model) => model.ser == '${chatModel[index].user}').email}'}',
                                                                                ))
                                                                              ],
                                                                            ))),
                                                                  ),
                                                                ],
                                                              ),
                                                              // Text(
                                                              //   '${userModels_chat.where((model) => model.ser == '${chatModel[index].user}').map((userModel) => userModel.email).isEmpty ? '??' : '${userModels_chat.firstWhere((model) => model.ser == '${chatModel[index].user}').fname} ${userModels_chat.firstWhere((model) => model.ser == '${chatModel[index].user}').lname}'}',

                                                              //   // '${chatModel[index].user}'
                                                              // )
                                                            ],
                                                          )),
                                                      if (chatModel[index]
                                                                  .content ==
                                                              '' ||
                                                          chatModel[index]
                                                                  .content ==
                                                              null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 0, 0, 0),
                                                          child:
                                                              BubbleNormalImage(
                                                            id: '',
                                                            //  color: Colors.grey,
                                                            image: Container(
                                                              constraints:
                                                                  BoxConstraints(
                                                                minHeight:
                                                                    150.0,
                                                                minWidth: 220.0,
                                                              ),
                                                              child:
                                                                  CachedNetworkImage(
                                                                width: 220,
                                                                height: 150,
                                                                imageUrl:
                                                                    '${MyConstant().domain}/files/$foder/chat/${chatModel[index].img}',
                                                                // "${chatModel[index].img}",
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(5)),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    CircularProgressIndicator(),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                            // color: Colors.purpleAccent,
                                                            tail: false,
                                                            isSender: false,
                                                            delivered: false,
                                                            seen: false,
                                                            onTap: () {},
                                                          ),
                                                        ),
                                                      if (chatModel[index]
                                                                  .img ==
                                                              '' ||
                                                          chatModel[index]
                                                                  .img ==
                                                              null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 0, 0, 0),
                                                          child: ChatBubble(
                                                            clipper: ChatBubbleClipper8(
                                                                type: BubbleType
                                                                    .receiverBubble),
                                                            backGroundColor:
                                                                Color(
                                                                    0xffE7E7ED),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 4,
                                                                    bottom: 4),
                                                            child: Container(
                                                              constraints:
                                                                  BoxConstraints(
                                                                maxWidth: (MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        4) /
                                                                    2,
                                                              ),
                                                              child: Text(
                                                                "${chatModel[index].content}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 0, 0, 0),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            " ${DateFormat('d MMM', 'th_TH').format(DateTime.parse(chatModel[index].datex.toString()))} ${DateTime.parse('${chatModel[index].datex}').year + 543}  ${chatModel[index].timex}",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color:
                                                                    Colors.grey,
                                                                fontFamily: Font_
                                                                    .Fonts_T),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 50,
                                                      )
                                                    ],
                                                  ),
                                                );
                                        },
                                      );
                                    }),
                              ),
                              Container(
                                // height: 60,
                                color: Colors.green[200],
                                padding: const EdgeInsets.all(0.0),
                                child: MessageBar(
                                  onTapCloseReply: () {},
                                  onSend: (value) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    var ren =
                                        preferences.getString('renTalSer');
                                    try {
                                      final url =
                                          '${MyConstant().domain}/In_c_chat.php';

                                      final response = await http
                                          .post(Uri.parse(url), body: {
                                        'isAdd': 'true',
                                        'user': '$ser_user',
                                        'ren': '$ren',
                                        'content': '$value',
                                        'img': '',
                                        'audio': '',
                                        'Dismissible': "1",
                                        'Serchat': ''
                                      });
                                      setState(() {
                                        red_Chat();
                                      });
                                    } catch (e) {
                                      setState(() {
                                        red_Chat();
                                      });
                                    }
                                  },
                                  messageBarHintStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                  messageBarHitText: 'Aa',
                                  messageBarColor:
                                      const Color.fromARGB(255, 167, 216, 168),
                                  actions: [
                                    InkWell(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      onTap: () async {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        var ren =
                                            preferences.getString('renTalSer');
                                        String dateTimeNow =
                                            DateTime.now().toString();
                                        String date = DateFormat('ddMMyyyy')
                                            .format(DateTime.parse(
                                                '${dateTimeNow}'))
                                            .toString();
                                        final dateTimeNow2 = DateTime.now()
                                            .toUtc()
                                            .add(const Duration(hours: 7));
                                        final formatter =
                                            DateFormat('HH:mm:ss');
                                        final formatter2 = DateFormat('HHmmss');
                                        final formattedTime2 =
                                            formatter2.format(dateTimeNow2);
                                        String Time_ =
                                            formattedTime2.toString();
                                        var fileName =
                                            'chat_${ren}_${date}_$Time_.png';
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['jpg', 'png'],
                                        );

                                        if (result != null) {
                                          List<int> imageBytes =
                                              await result.files.first.bytes ??
                                                  [];
                                          String base64Image =
                                              await base64Encode(imageBytes);
                                          try {
                                            final url =
                                                '${MyConstant().domain}/File_upload_imgChat.php';

                                            final response = await http
                                                .post(Uri.parse(url), body: {
                                              'image':
                                                  base64Image, // Fix the variable name here
                                              'Foder': foder,
                                              'name': fileName,
                                              'ex': 'png',
                                              'Path': 'chat',
                                              'user': '$ser_user',
                                              'ren': '$ren',
                                              'content': '',
                                              'img': '$fileName',
                                              'audio': ''
                                            });

                                            if (response.statusCode == 200) {
                                              print(
                                                  'Image uploaded successfully');
                                            } else {
                                              print('Image upload failed');
                                            }
                                            setState(() {
                                              red_Chat();
                                            });
                                          } catch (e) {
                                            setState(() {
                                              red_Chat();
                                            });
                                            print(
                                                'Error during image processing: $e');
                                          }
                                        } else {
                                          // Handle the case where the user didn't pick any file.
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: InkWell(
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.pink[900],
                                          size: 20,
                                        ),
                                        onTap: () async {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          var ren = preferences
                                              .getString('renTalSer');
                                          String dateTimeNow =
                                              DateTime.now().toString();
                                          String date = DateFormat('ddMMyyyy')
                                              .format(DateTime.parse(
                                                  '${dateTimeNow}'))
                                              .toString();
                                          final dateTimeNow2 = DateTime.now()
                                              .toUtc()
                                              .add(const Duration(hours: 7));
                                          final formatter =
                                              DateFormat('HH:mm:ss');
                                          final formatter2 =
                                              DateFormat('HHmmss');
                                          final formattedTime2 =
                                              formatter2.format(dateTimeNow2);
                                          String Time_ =
                                              formattedTime2.toString();
                                          var fileName =
                                              'chat_${ren}_${date}_$Time_.png';
                                          late XFile? _imageFile;
                                          XFile? pickedFile =
                                              await ImagePicker().pickImage(
                                            source: ImageSource.camera,
                                          );

                                          if (pickedFile != null) {
                                            setState(() {
                                              _imageFile = pickedFile;
                                            });

                                            List<int> imageBytes =
                                                await pickedFile.readAsBytes();
                                            String base64Image =
                                                base64Encode(imageBytes);
                                            try {
                                              final url =
                                                  '${MyConstant().domain}/File_upload_imgChat.php';

                                              final response = await http
                                                  .post(Uri.parse(url), body: {
                                                'image':
                                                    base64Image, // Fix the variable name here
                                                'Foder': foder,
                                                'name': fileName,
                                                'ex': 'png',
                                                'Path': 'chat',
                                                'user': '$ser_user',
                                                'ren': '$ren',
                                                'content': '',
                                                'img': '$fileName',
                                                'audio': ''
                                              });

                                              if (response.statusCode == 200) {
                                                print(
                                                    'Image uploaded successfully');
                                                setState(() {});
                                              } else {
                                                print('Image upload failed');
                                              }
                                              setState(() {
                                                red_Chat();
                                              });
                                            } catch (e) {
                                              setState(() {
                                                red_Chat();
                                              });
                                              print(
                                                  'Error during image processing: $e');
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      child: PopupMenuButton<int>(
                                        color: Colors.green[50],
                                        tooltip: '',
                                        child: Icon(
                                          Icons.emoji_emotions,
                                          color: Colors.orange[900],
                                          size: 20,
                                        ),
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem<int>(
                                                value: 0,
                                                child: SizedBox(
                                                    width: 15,
                                                    child: Text("❤️"))),
                                            PopupMenuItem<int>(
                                                value: 1,
                                                child: SizedBox(
                                                    width: 15,
                                                    child: Text("☹"))),
                                            PopupMenuItem<int>(
                                                value: 2,
                                                child: SizedBox(
                                                    width: 15,
                                                    child: Text("☻"))),
                                            PopupMenuItem<int>(
                                                value: 3,
                                                child: SizedBox(
                                                    width: 15,
                                                    child: Text("✔️"))),
                                            PopupMenuItem<int>(
                                                value: 4,
                                                child: SizedBox(
                                                    width: 15,
                                                    child: Text("❌"))),
                                            PopupMenuItem<int>(
                                                value: 5,
                                                child: SizedBox(
                                                    width: 15,
                                                    child: Text("✌"))),
                                            PopupMenuItem<int>(
                                                value: 6,
                                                child: SizedBox(
                                                    width: 15,
                                                    child: Text("✍"))),
                                            PopupMenuItem<int>(
                                                value: 7,
                                                child: SizedBox(
                                                    width: 15,
                                                    child: Text("☝"))),
                                            PopupMenuItem<int>(
                                                value: 8,
                                                child: SizedBox(
                                                    width: 15,
                                                    child: Text("★"))),
                                            PopupMenuItem<int>(
                                                value: 9,
                                                child: SizedBox(
                                                    width: 15,
                                                    child: Text("☎"))),
                                          ];
                                        },
                                        onOpened: () {},
                                        onCanceled: () {},
                                        onSelected: (value) async {
                                          List value_ = [
                                            "❤️",
                                            "☹",
                                            "☻",
                                            "✔️",
                                            "❌",
                                            "✌",
                                            "✍",
                                            "☝",
                                            "★",
                                            "☎"
                                          ];
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          var ren = preferences
                                              .getString('renTalSer');
                                          try {
                                            final url =
                                                '${MyConstant().domain}/In_c_chat.php';

                                            final response = await http
                                                .post(Uri.parse(url), body: {
                                              'isAdd': 'true',
                                              'user': '$ser_user',
                                              'ren': '$ren',
                                              'content': '${value_[value]}',
                                              'img': '',
                                              'audio': '',
                                              'Dismissible': "1",
                                              'Serchat': ''
                                            });
                                            setState(() {
                                              red_Chat();
                                            });
                                          } catch (e) {
                                            setState(() {
                                              red_Chat();
                                            });
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),

                                //  Row(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.center,
                                //     children: <Widget>[
                                //       Expanded(
                                //         child: Container(
                                //           decoration: BoxDecoration(
                                //             color: AppbackgroundColor
                                //                 .Sub_Abg_Colors,
                                //             borderRadius: const BorderRadius
                                //                     .only(
                                //                 topLeft: Radius.circular(10),
                                //                 topRight: Radius.circular(10),
                                //                 bottomLeft: Radius.circular(10),
                                //                 bottomRight:
                                //                     Radius.circular(10)),
                                //             border: Border.all(
                                //                 color: Colors.grey, width: 1),
                                //           ),
                                //           child: TextFormField(
                                //             autofocus: false,
                                //             cursorHeight: 14,
                                //             keyboardType: TextInputType.text,
                                //             style: const TextStyle(
                                //                 color: PeopleChaoScreen_Color
                                //                     .Colors_Text2_,
                                //                 fontFamily: Font_.Fonts_T),
                                //             decoration: InputDecoration(
                                //               filled: true,
                                //               // fillColor: Colors.white,
                                //               hintText: '',
                                //               hintStyle: const TextStyle(
                                //                   color: PeopleChaoScreen_Color
                                //                       .Colors_Text2_,
                                //                   fontFamily: Font_.Fonts_T),
                                //               contentPadding:
                                //                   const EdgeInsets.only(
                                //                       left: 14.0,
                                //                       bottom: 8.0,
                                //                       top: 8.0),
                                //               // focusedBorder: OutlineInputBorder(
                                //               //   borderSide: const BorderSide(color: Colors.white),
                                //               //   borderRadius: BorderRadius.circular(10),
                                //               // ),
                                //               enabledBorder:
                                //                   UnderlineInputBorder(
                                //                 borderSide: const BorderSide(
                                //                     color: Colors.white),
                                //                 borderRadius:
                                //                     BorderRadius.circular(10),
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //       Center(
                                //         child: Padding(
                                //           padding: const EdgeInsets.fromLTRB(
                                //               10, 4, 4, 4),
                                //           child: InkWell(
                                //             onTap: () {},
                                //             child: Icon(
                                //               Icons.send,
                                //               color: Colors.blue,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ])
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.question_answer_outlined,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 0,
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
                        (renTal_name == null || Chat_no_read == 0)
                            ? ''
                            : '${Chat_no_read}',
                        // '${userModels.length}***/$connected_Minutes/$ser_user/$email_user',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontFamily: FontWeight_.Fonts_T),
                      )))
            ],
          );
        });
  }
}
