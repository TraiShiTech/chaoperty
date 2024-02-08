import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Style/colors.dart';

Widget MansearchBarAC(Status_, viewTab, teNantModels, _teNantModels,
    _TransReBillModels, TransReBillModels_) {
  return TextField(
    autofocus: false,
    keyboardType: TextInputType.text,
    style: const TextStyle(
        color: PeopleChaoScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
    decoration: InputDecoration(
      filled: true,
      // fillColor: Colors.white,
      hintText: ' Search...',
      hintStyle: const TextStyle(
          color: PeopleChaoScreen_Color.Colors_Text2_,
          fontFamily: Font_.Fonts_T),
      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
      // focusedBorder: OutlineInputBorder(
      //   borderSide: const BorderSide(color: Colors.white),
      //   borderRadius: BorderRadius.circular(10),
      // ),
      enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onChanged: (text) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      // print(text);
      text = text.toLowerCase();
      //         Widget BodyHome_Web() {
      //   return (Status_ == 1)
      //       ? viewTab == 0
      //           ? PlayColumn()
      //           : BodyStatus2_Web()
      //       : (Status_ == 2)
      //           ? BodyStatus1_Web()
      //           : (Status_ == 3)
      //               ? BodyStatus3_Web()
      //               : BodyStatus4_Web();
      // }
      if (Status_ == 1) {
        if (viewTab == 0) {
        } else {
          teNantModels = _teNantModels.where((teNantModels) {
            var notTitle = teNantModels.lncode.toString().toLowerCase();
            var notTitle2 = teNantModels.cid.toString().toLowerCase();
            var notTitle3 = teNantModels.docno.toString().toLowerCase();
            var notTitle4 = teNantModels.sname.toString().toLowerCase();
            var notTitle5 = teNantModels.cname.toString().toLowerCase();
            return notTitle.contains(text) ||
                notTitle2.contains(text) ||
                notTitle3.contains(text) ||
                notTitle4.contains(text) ||
                notTitle5.contains(text);
          }).toList();
        }
      } else if (Status_ == 2) {
        teNantModels = _teNantModels.where((teNantModels) {
          var notTitle = teNantModels.cid.toString().toLowerCase();
          var notTitle2 = teNantModels.docno.toString().toLowerCase();
          var notTitle3 = teNantModels.invoice.toString().toLowerCase();
          var notTitle4 = teNantModels.ln_c.toString().toLowerCase();
          var notTitle5 = teNantModels.sname.toString().toLowerCase();
          var notTitle6 = teNantModels.cname.toString().toLowerCase();
          var notTitle7 = teNantModels.expname.toString().toLowerCase();
          var notTitle8 = teNantModels.date.toString().toLowerCase();
          return notTitle.contains(text) ||
              notTitle2.contains(text) ||
              notTitle3.contains(text) ||
              notTitle4.contains(text) ||
              notTitle5.contains(text) ||
              notTitle6.contains(text) ||
              notTitle7.contains(text) ||
              notTitle8.contains(text);
        }).toList();
      } else if (Status_ == 3) {
        _TransReBillModels = TransReBillModels_.where((TransReBillModels) {
          var notTitle = TransReBillModels.cid.toString().toLowerCase();
          var notTitle2 = TransReBillModels.daterec.toString().toLowerCase();
          var notTitle3 = TransReBillModels.pdate.toString().toLowerCase();
          var notTitle4 = TransReBillModels.docno.toString().toLowerCase();
          var notTitle5 = TransReBillModels.doctax.toString().toLowerCase();
          var notTitle6 = TransReBillModels.inv.toString().toLowerCase();
          var notTitle7 =
              TransReBillModels.room_number.toString().toLowerCase();
          var notTitle8 = TransReBillModels.ln.toString().toLowerCase();
          var notTitle9 = TransReBillModels.remark.toString().toLowerCase();
          var notTitle10 = TransReBillModels.sname.toString().toLowerCase();
          var notTitle11 =
              TransReBillModels.total_bill.toString().toLowerCase();
          var notTitle12 = TransReBillModels.doctax.toString().toLowerCase();

          return notTitle.contains(text) ||
              notTitle2.contains(text) ||
              notTitle3.contains(text) ||
              notTitle4.contains(text) ||
              notTitle5.contains(text) ||
              notTitle6.contains(text) ||
              notTitle7.contains(text) ||
              notTitle8.contains(text) ||
              notTitle9.contains(text) ||
              notTitle10.contains(text) ||
              notTitle11.contains(text) ||
              notTitle12.contains(text);
        }).toList();
      } else if (Status_ == 4) {
      } else if (Status_ == 5) {
      } else if (Status_ == 6) {
        // if (text == '' || text == null) {
        //   preferences.remove('SearchBar_ACSreen');
        // } else {
        //   setState(() {
        //     preferences.setString('SearchBar_ACSreen', text.toString());
        //   });
        // }
      }
    },
  );
}
