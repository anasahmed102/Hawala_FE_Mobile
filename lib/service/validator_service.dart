import 'package:injectable/injectable.dart';


@Named.from(ValidatorService)
@LazySingleton()
class ValidatorService {
  static bool checkIsNullOrEmpty(Object? str) {
    return [null, "null", ""].contains(str);
  }

  static bool checkBool(var str, {bool defaultV = false}) {
    if (checkIsNullOrEmpty(str)) {
      return defaultV;
    }
    return ["true", true, "1", 1].contains(str);
  }

  static double checkDouble(var str, {double defaultV = 0.0}) {
    try {
      if (checkIsNullOrEmpty(str)) {
        return defaultV;
      } else {
        return double.tryParse("$str".replaceAll(",", "")) ?? defaultV;
      }
    } catch (e, c) {
      // recordError(e, c);
      return defaultV;
    }
  }

  static int checkInt(var str, {int defaultV = 0}) {
    try {
      if (checkIsNullOrEmpty(str)) {
        return defaultV;
      } else {
        return int.tryParse("$str") ?? defaultV;
      }
    } catch (e, c) {
      // recordError(e, c);
      return defaultV;
    }
  }

  static String checkString(var str, {String defaultV = ''}) {
    if (checkIsNullOrEmpty(str)) {
      return defaultV;
    }
    return str;
  }

  static DateTime checkDate(String str, {DateTime? defaultV}) {
    defaultV ??= DateTime.now();
    try {
      if (checkIsNullOrEmpty(str)) {
        return defaultV;
      } else {
        return DateTime.tryParse(str) ?? defaultV;
      }
    } catch (e, c) {
      // recordError(e, c);
      return defaultV;
    }
  }

  static bool checkIsKeyExists(Map<String, dynamic> json, String key) {
    return json.containsKey(key);
  }

  static dynamic validate(
      {required Map<String, dynamic> json,
      required String key,
      required VST type,
      var defaultValue}) {
    //? check is type for default value
    switch (type) {
      case VST.string:
        {
          defaultValue = '';
        }
      case VST.int:
        {
          defaultValue = 0;
        }
      case VST.double:
        {
          defaultValue = 0.0;
        }
      case VST.bool:
        {
          defaultValue = false;
        }
      case VST.dateTime:
        {
          defaultValue = DateTime.now();
        }
    }

    //? check if the key is exists
    if (!checkIsKeyExists(json, key)) {
      return defaultValue;
    }

    //? return the final result
    switch (type) {
      case VST.string:
        {
          return checkString(json[key], defaultV: defaultValue);
        }
      case VST.int:
        {
          return checkInt(json[key], defaultV: defaultValue);
        }
      case VST.double:
        {
          return checkDouble(json[key], defaultV: defaultValue);
        }
      case VST.bool:
        {
          return checkBool(json[key], defaultV: defaultValue);
        }
      case VST.dateTime:
        {
          return checkDate(json[key], defaultV: defaultValue);
        }
    }
  }

  static bool isSuccess(int? code) {
    return (code ?? 400) ~/ 100 == 2;
  }

  static String formatDistance(num distance) {
    if (distance > 100000) {
      return "+99";
    } else {
      return (distance / 1000).toStringAsFixed(2);
    }
  }

  static String? validateText(String? value) {
    if (value == null || value.trim().isEmpty || value.isEmpty) {
      return "Required";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty || value.isEmpty) {
      return "Required";
    } else if (value.trim().length < 3) {
      return "Too Short";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty || value.isEmpty) {
      return "Required";
    } else if (value.trim().length < 4) {
      return "Too Short";
    }
    return null;
  }

  static String? validatePasswordMatch(String? value, String? pass2) {
    if (validatePassword(value) != null) {
      return "Required";
    } else if (pass2 != value) {
      return "Password is not matching";
    }
    return null;
  }

  static String? validatePhoneNullAble(String? value) {
    String pattern = '^7[3-9][0-9][0-9]{7}\$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (!regex.hasMatch(value)) {
      return "7XX XXX XXXX";
    } else {
      return null;
    }
  }

  static String? validatePhone(String? value) {
    String pattern = '^7[0-9][0-9][0-9]{7}\$';
    RegExp regex = RegExp(pattern);
    if (value == null || value.trim().isEmpty) {
      return "Required";
    }
    if (!regex.hasMatch(value)) {
      return "7XX XXX XXXX";
    } else {
      return null;
    }
  }
}

enum VST { string, int, double, bool, dateTime }
