import 'dart:math';


import 'package:flutter/material.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/context_extension.dart';
import 'package:hawala/shared/logger.dart';

import 'package:intl/intl.dart' as intl;

import 'package:uuid/uuid.dart';

import '../service/validator_service.dart';

String formatPrice(num price, {String? format}) {
  //! formating when the format is not specified  (dollarFormat)
  try {
    String defaultCurrenyForamt = '#,###.##';
    format ??= defaultCurrenyForamt;

    if (ValidatorService.checkIsNullOrEmpty(format)) {
      format = "#,###.##";
    }
    final dollarFormat = intl.NumberFormat(format);

    return dollarFormat.format(price);
  } catch (e) {
    logger("e $e");
    return "$price";
  }
}

// List<MyWorkoutData> getDaysWorkoutS(
//     int dayNum, List<AssignedWorkOutsModel> items) {
//   logger("daydayday $dayNum");
//   return mapWorkOutToMyWorkoutData(items).where((element) {
//     logger('testingDay(${element.day})');
//     return element.day == dayNum;
//   }).toList();
// }

TextDirection getTextDirection(String text) {
  return intl.Bidi.detectRtlDirectionality(text)
      ? TextDirection.rtl
      : TextDirection.ltr;
}

double getGridWidgetHeight() {
  //Helper.i.context.width
  return (getItClient<AppConfigurationService>().context.width / 2) * 1.2;
}

//

// String checkOnNullReturnEmpty(String? str, {String def = ""}) {
//   if (["", null, "null"].contains(str)) {
//     return def;
//   }
//   return str ?? "";
// }

String? formatAttachment(String? val) {
  return ValidatorService.checkIsNullOrEmpty(val) == true ||
          val.toString().toLowerCase().contains("error")
      ? null
      : val.toString().contains("http")
          ? val
          : "https://media3.giphy.com/media/j5VrvBfbV332AOow1B/giphy.gif";
}

// https://accounting-bucket-jazary.s3.eu-north-1.amazonaws.com/${val.toString().replaceAll("\\", "/")}
String getPhone(String? t) {
  if (ValidatorService.checkIsNullOrEmpty(t)) {
    return "";
  } else if (t!.toString().startsWith("+964")) {
    return t.replaceAll("+964", "");
  } else if (t.toString().startsWith("964")) {
    return t.replaceAll("964", "");
  }
  return t;
}

bool isLandScape(double width) {
  return width > 500;
}

TextDirection isRTL(String text) {
  return intl.Bidi.detectRtlDirectionality(text)
      ? TextDirection.rtl
      : TextDirection.ltr;
}

/// generate uid for party and sell order
String generateUId() => const Uuid().v4();

///for payment series
String generateId() => DateTime.now().hashCode.toString();

///for payment series
String generateRandom() => Random().nextInt(100000).toString();


// double getPrinting(EachTargetModel eachTargetDetalis) {
//   final pre = eachTargetDetalis.acheivedPercentage;
//   //     (eachTargetDetalis.targetAmount / (eachTargetDetalis.acheived)) / 100;
//   if (pre < 0 || pre.isNaN) {
//     return 0;
//   } else if (pre > 100) {
//     return 1;
//   } else {
//     return pre / 100;
//   }
// }







// String? get accountLogo =>
//     ProfileNotifier.instance.accountInfo?.rows.accountLogo;
// String get accountPhone =>
//     checkOnNullReturnEmpty(ProfileNotifier.instance.accountInfo?.rows.phone);
// String get accountAddress =>
//     checkOnNullReturnEmpty(ProfileNotifier.instance.accountInfo?.rows.address);
// String get companyName => checkOnNullReturnEmpty(
//         ProfileNotifier.instance.accountInfo?.rows.accountName)
//     .replaceAll("[", "")
//     .replaceAll("]", "");

// String get defaultCurrenySembol =>
//     sl<DefaultCurrencyCubit>().item?.symbol ?? "";
// String get defaultCurrenyForamt =>
//     sl<DefaultCurrencyCubit>().item?.currencyFormat ?? "#.##";
// String get defaultCurrenySeries =>
//     sl<DefaultCurrencyCubit>().item?.currencySeries ?? "__";
// String get defaultCurrenySembol => '';
// String get defaultCurrenyForamt =>
//     ProfileNotifier.instance.accountInfo?.rows.defaultCurrencyFormat ?? "#.##";
// String get defaultCurrenySeries =>
//     ProfileNotifier.instance.accountInfo?.rows.defaultCurrency ?? "__";

// String getItemCurrenySembol(Price? price) {
//   CurrencyModel? currency = sl<CurrencyCubit>()
//       .items
//       .firstWhereOrNull((element) => element.series == price?.currencySeries);
//   return currency?.symbol ?? "";
// }

// double getTotalPaymentPrice(
//     // List<CreatePaymentModel> paymentOrders
//     List<CreatePaymentModelAccounting> paymentOrders) {
//   double price = 0;
//   for (var element in paymentOrders) {
//     // if (element.currencyModel.series != element.exchangeModel.toCurrency) {
//     //   price = price + element.amount * (element.exchangeModel.exchangeRate);
//     // } else {
//     //   price = price + element.amount;
//     // }
//     price = price + element.amount;
//   }
//   return price;
// }
