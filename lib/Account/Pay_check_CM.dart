import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Style/colors.dart';

class Pay_Check_CM extends StatefulWidget {
  const Pay_Check_CM({super.key});

  @override
  State<Pay_Check_CM> createState() => _Pay_Check_CMState();
}

class _Pay_Check_CMState extends State<Pay_Check_CM> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: AppbackgroundColor.Sub_Abg_Colors,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                // border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Column(children: []))
        ]));
  }
}
