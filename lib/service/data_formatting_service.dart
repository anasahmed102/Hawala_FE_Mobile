
import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/shared/logger.dart';
import 'package:injectable/injectable.dart';



@Named.from(DateFormatterService)
@LazySingleton()
class DateFormatterService {
  List<String> monthsName = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  static String formatDateToYYYYMMDD(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  static String formatDate(DateTime date, {bool showYear = true}) {
    try {
      String year = date.year.toString();
      String day = date.day.toString();
      String month = date.month.toString();
      String hour = (date.hour > 12 ? date.hour - 12 : date.hour).toString();
      if (hour.length == 1) {
        hour = "0$hour";
      }
      return "$hour:${date.minute} ${date.hour > 12 ? Trans.pm.trans() : Trans.am.trans()} $day-$month${showYear ? "-$year" : ""}";
    } catch (e) {
      logger("formatDate error $e");
      return "";
    }
  }

  static String getOnlyTime(DateTime date) {
    try {
      String hour = (date.hour > 12 ? date.hour - 12 : date.hour).toString();
      if (hour.length == 1) {
        hour = "0$hour";
      }
      return "$hour:${date.minute} ${date.hour > 12 ? Trans.pm.trans() : Trans.am.trans()}";
    } catch (e) {
      logger("formatDate error $e");
      return "";
    }
  }

  static String getOnlyDate(DateTime? date) {
    if (date == null) {
      return "";
    }
    try {
      return "${date.year}-${date.month > 9 ? date.month : "0${date.month}"}-${date.day > 9 ? date.day : "0${date.day}"}";
    } catch (e) {
      logger("formatDate error $e");
      return "";
    }
  }

  static bool isToday(DateTime? date) {
    if (date == null) {
      return false;
    }
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static String convertDateToTimeZone(DateTime date) {
    return "${date.toIso8601String().split(".").first}.000Z";
  }

  static String formatStock(num date) {
    return date.toStringAsFixed(1);
  }

  static String formatTimeToAMPM(int seconds) {
    // Ensure the hour is between 0 and 23
    // Calculate hours, minutes, and remaining seconds
    int hours = seconds ~/ 3600;
    int remainingSeconds = seconds % 3600;
    int minutes = remainingSeconds ~/ 60;

    // Determine AM/PM and format the hour, minutes, and seconds
    String amPm = hours < 12 ? 'AM' : 'PM';
    int formattedHour = hours == 0
        ? 12
        : hours <= 12
            ? hours
            : hours - 12;

    return '${formattedHour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $amPm';
  }

  static Duration convertDateTimeToDuration(DateTime date) {
    Duration duration = Duration(
        hours: date.hour,
        minutes: date.minute,
        seconds: date.second,
        milliseconds: date.millisecond,
        microseconds: date.microsecond);
    return duration;
  }

  static int calculateAge(DateTime birthDate, DateTime currentDate) {
    // Calculate the difference in years
    int age = currentDate.year - birthDate.year;

    // Adjust the age if the birth date hasn't occurred yet this year
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  static int getTodayIndex() {
    //     [0, 1, 2, 3, 4, 5, 6]
    return [6, 7, 1, 2, 3, 4, 5].indexOf(DateTime.now().weekday);
  }
}
