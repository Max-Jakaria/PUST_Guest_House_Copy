import 'package:intl/intl.dart';

class DateTimeFormater {
  static String get(String dateTimeString) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
    print('--__-- $dateTimeString');

    DateTime dateTime = dateFormat.parse(dateTimeString);
    DateTime dateTimeDefault = DateTime.parse(dateTimeString);
    String ampm = 'AM';
    if (dateTimeDefault.hour >= 12) {
      ampm = 'PM';
    }

    return '${DateFormat('yyyy-MM-dd hh:mm').format(dateTime)} $ampm';
  }
}
