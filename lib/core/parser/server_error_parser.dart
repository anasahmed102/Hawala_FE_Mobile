import 'dart:convert';

import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/service/validator_service.dart';



String parseServerError(String res, String def, int statusCode) {
  try {
    if (statusCode == 405) {
      return Trans.youHaveNotPermissonToDoThat.trans();
    }
    if (statusCode == 425) {
      return Trans.yourAccountLicenseIsFinished.trans();
    }
    var body = jsonDecode(res);
    dynamic error = body['message'];
    if (error is String || ValidatorService.checkIsNullOrEmpty(error)) {
      return error ?? def;
    } else {
      AddOrderError addOrderError = AddOrderError.fromMap(body);

      String s = "";
      for (var series in addOrderError.message.items) {
        s = s + ("\n${series.itemName ?? series.series}");
      }
      return "${getErrroByCode(addOrderError.message.status)}$s";
    }
  } catch (e) {
    try {
      String error = res;
      return error;
    } catch (e) {
      return def;
    }
  }
}

class AddOrderError {
  final int status;
  final Message message;

  AddOrderError({
    required this.status,
    required this.message,
  });

  AddOrderError copyWith({
    int? status,
    Message? message,
  }) =>
      AddOrderError(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory AddOrderError.fromJson(String str) =>
      AddOrderError.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddOrderError.fromMap(Map<String, dynamic> json) => AddOrderError(
        status: json["status"],
        message: Message.fromMap(json["message"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message.toMap(),
      };
}

class Message {
  final List<Item> items;
  final int status;

  Message({
    required this.items,
    required this.status,
  });

  Message copyWith({
    List<Item>? items,
    int? status,
  }) =>
      Message(
        items: items ?? this.items,
        status: status ?? this.status,
      );

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        items: List<Item>.from(json["Items"].map((x) => Item.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "Items": List<dynamic>.from(items.map((x) => x.toMap())),
        "status": status,
      };
}

class Item {
  final String series;
  final String? itemName;

  Item({
    required this.series,
    required this.itemName,
  });

  factory Item.fromMap(Map<String, dynamic> json) {
    return Item(series: json["Series"], itemName: json["ItemName"]);
  }

  Map<String, dynamic> toMap() => {
        "Series": series,
        "ItemName": itemName,
      };
}

String getErrroByCode(int? code) {
  if (code == 500002) {
    return Trans.insufficientQuantityInWarehouse.trans();
  } else {
    return Trans.operationFailedUnKnownError.trans();
  }
}
