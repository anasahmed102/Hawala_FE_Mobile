import 'package:flutter/material.dart';
import 'package:hawala/shared/responsive.dart';
import 'package:overlay_support/overlay_support.dart';

Future<void> showFailedFlashBar(String message) async {
  showSimpleNotification(
      Text(message,
          style: TextStyle(fontSize: 16.sp, height: 1.5, color: Colors.white)),
      autoDismiss: true,
      elevation: 0,
      duration: const Duration(seconds: 5),
      slideDismissDirection: DismissDirection.vertical,
      leading: const Icon(Icons.error, size: 28.0, color: Colors.red),
      background: const Color(0xFF303030));
}
