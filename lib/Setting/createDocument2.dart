import 'dart:html';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';

// import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';

import '../PeopleChao/Pays_.dart';

createDocument2(context, pdf) async {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewPdfgen_Billsplay(
            doc: pdf, title: 'ใบเสร็จรับเงิน/ใบกำกับภาษี'),
      ));
}
