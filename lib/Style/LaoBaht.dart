import 'package:intl/intl.dart';

// final units = [
//   'ສູນ',
//   'ໜຶ່ງ',
//   'ສອງ',
//   'ສາມ',
//   'ສີ່',
//   'ຫ້າ',
//   'ຫົກ',
//   'ເຈັດ',
//   'ແປດ',
//   'ເກົ້າ'
// ];
// final tens = [
//   '',
//   'ສິບ',
//   'ຊາວ',
//   'ສາມສິບ',
//   'ສີ່ສິບ',
//   'ຫ້າສິບ',
//   'ຫົກສິບ',
//   'ເຈັດສິບ',
//   'ແປດສິບ',
//   'ເກົ້າສິບ'
// ];
import 'package:intl/intl.dart';

String convertToLaoBaht(double amount) {
  final List<String> digitLao = [
    'ສູນ',
    'ໜຶ່ງ',
    'ສອງ',
    'ສາມ',
    'ສີ່',
    'ຫ້າ',
    'ຫົກ',
    'ເຈັດ',
    'ແປດ',
    'ເກົ້າ'
  ];

  final List<String> positionLao = [
    '',
    'ສິບ',
    'ຮ້ອຍ',
    'ພັນ',
    'ຫມື່ນ',
    'ແສນ',
    'ລ້ານ'
  ];

  String convertNumberToLao(int number) {
    if (number == 0) {
      return digitLao[0];
    }

    String result = '';
    int position = 0;

    while (number > 0) {
      int digit = number % 10;

      if (position == 1 && digit == 1) {
        result = 'ສິບ' + result;
      } else if (position == 1 && digit == 2) {
        result = 'ຍີ່ສິບ' + result;
      } else {
        result = digitLao[digit] + positionLao[position] + result;
      }

      number = number ~/ 10;
      position++;
    }

    return result;
  }

  final nFormat2 = NumberFormat("###0.00", "en_US");

  var number_ = nFormat2.format(amount);
  var parts = number_.split('.');
  var front = int.parse(parts[0]);
  var back = int.parse(parts[1]);

  String integerPartLao = convertNumberToLao(front);
  String decimalPartLao = convertNumberToLao(back);

  String formattedNumber = (back == 0)
      ? '$integerPartLao ກີບ'
      : '$integerPartLao ກີບ $decimalPartLao ສົດ';

  // Handle special cases
  formattedNumber = formattedNumber.replaceAll('ສອງສິບ', 'ຍີ່ສິບ');
  formattedNumber = formattedNumber.replaceAll('ສິບໜຶ່ງ', 'ສິບເອັດ');

  return (amount == 0.00) ? 'ສູນກີບຈຸດສູນສູນສົດ' : formattedNumber;
  
}
