// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, prefer_const_constructors, unnecessary_import, implementation_imports, prefer_const_constructors_in_immutables, non_constant_identifier_names, avoid_init_to_null, prefer_void_to_null, unnecessary_brace_in_string_interps, avoid_print, empty_catches, sized_box_for_whitespace, use_build_context_synchronously, file_names, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_string_interpolations, prefer_collection_literals, sort_child_properties_last, avoid_unnecessary_containers, prefer_is_empty, prefer_final_fields, camel_case_types, avoid_web_libraries_in_flutter, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, deprecated_member_use
import 'package:intl/intl.dart';

String convertToThaiBaht(double amount) {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("###0.00", "en_US");
  final List<String> _digitThai = [
    'ศูนย์',
    'หนึ่ง',
    'สอง',
    'สาม',
    'สี่',
    'ห้า',
    'หก',
    'เจ็ด',
    'แปด',
    'เก้า'
  ];

  final List<String> _positionThai = [
    '',
    'สิบ',
    'ร้อย',
    'พัน',
    'หมื่น',
    'แสน',
    'ล้าน'
  ];
/////////////////////////////------------------------>(จำนวนเต็ม)
  String convertNumberToText(int number) {
    String result = '';
    int numberIntPart = number.toInt();
    int numberDecimalPart = ((number - numberIntPart) * 100).toInt();
    final List<String> digits = numberIntPart.toString().split('');
    int position = digits.length - 1;
    for (int i = 0; i < digits.length; i++) {
      final int digit = int.parse(digits[i]);
      if (digit != 0) {
        if (position == 6) {
          result = '$result${_positionThai[6]}';
        }
        if (position != 6 && position != 8) {
          if (digit == 1 && position == 1) {
            // result = '$resultเอ็ด';
            result = '$resultสิบ';
          } else {
            result =
                '$result${_digitThai[digit]}${_positionThai[position % 6]}';
          }
        } else if (position == 8) {
          result = '$result${_digitThai[digit]}${_positionThai[6]}';
        }
      }
      position--;
    }
    // final String decimalText =
    //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
    return result;
  }

/////////////////////////////------------------------>(จำนวนทศนิยม สตางค์)
  String convertNumberToText2(int number2) {
    String result = '';
    int numberIntPart = number2.toInt();
    int numberDecimalPart = ((number2 - numberIntPart) * 100).toInt();
    final List<String> digits = numberIntPart.toString().split('');
    int position = digits.length - 1;
    for (int i = 0; i < digits.length; i++) {
      final int digit = int.parse(digits[i]);
      if (digit != 0) {
        if (position == 6) {
          result = '$result${_positionThai[6]}';
        }
        if (position != 6 && position != 8) {
          if (digit == 1 && position == 1) {
            // result = '$resultเอ็ด';
            result = '$resultสิบ';
          } else {
            result =
                '$result${_digitThai[digit]}${_positionThai[position % 6]}';
          }
        } else if (position == 8) {
          result = '$result${_digitThai[digit]}${_positionThai[6]}';
        }
      }
      position--;
    }
    // final String decimalText =
    //     convertNumberToText(numberDecimalPart).replaceAll(_digitThai[0], "");
    return result;
  }

////////////////----------------------------->(ตัด หน้าจุดกับหลังจุดออกจากกัน)
  var number_ = "${nFormat2.format(double.parse(amount.toString()))}";
  var parts = number_.split('.');
  var front = parts[0];
  var back = parts[1];

////////////////--------------------------------->(บาท)
  double number = double.parse(front);
  final int numberIntPart = number.toInt();
  final double numberDecimalPart = (number - numberIntPart) * 100;
  final String numberText = convertNumberToText(numberIntPart);
  final String decimalText = convertNumberToText(numberDecimalPart.toInt());
////////////////---------------------------------->(สตางค์)
  double number2 = double.parse(number_);
  final int numberIntPart2 = number.toInt();
  final int numberDecimalPart2 = ((number2 - numberIntPart2) * 100).round();
  final String numberText2 = convertNumberToText2(numberIntPart2);
  final String decimalText2 = convertNumberToText2(numberDecimalPart2.toInt());
////////////////------------------------------->(เช็คและเพิ่มตัวอักษร)
  final String formattedNumber = (decimalText2.replaceAll(_digitThai[0], "") ==
          '')
      ? '$numberTextบาทถ้วน'
      : (back[0].toString() == '0')
          ? '$numberTextบาทจุดศูนย์${decimalText2.replaceAll(_digitThai[0], "")}สตางค์'
          : '$numberTextบาทจุด${decimalText2.replaceAll(_digitThai[0], "")}สตางค์';

  String text_Number1 = formattedNumber;
  RegExp exp1 = RegExp(r"สองสิบ");
  if (exp1.hasMatch(text_Number1)) {
    text_Number1 = text_Number1.replaceAll(exp1, 'ยี่สิบ');
  }
  String text_Number2 = text_Number1;
  RegExp exp2 = RegExp(r"สิบหนึ่ง");
  if (exp2.hasMatch(text_Number2)) {
    text_Number2 = text_Number2.replaceAll(exp2, 'สิบเอ็ด');
  }

  return (amount == 0.00) ? 'ศูนย์บาทจุดศูนย์ศูนย์สตางค์ถ้วน' : text_Number2;
}
