import 'dart:developer';

import 'package:flutter/foundation.dart';

void logger(message) {
  if (kDebugMode) {
    // log(StackTrace.current.toString());
    // log('\x1B[33m$message');

    if (message is Exception ||
        "$message".toLowerCase().contains("Error".toLowerCase()) ||
        "$message".toLowerCase().contains("Exception".toLowerCase())) {
      log("\u001b[1;31m $message");
    } else {
      log("$message");
      // log("\u001b[1;32m  $message");
    }
  }
}
