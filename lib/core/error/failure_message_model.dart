import 'package:hawala/service/validator_service.dart';

class FailureMessage {
  ///Error cause text
  String reason;
  //
  String message;
  String elementLoaded;

  FailureMessage(
      {required this.reason,
      required this.message,
      required this.elementLoaded});

  @override

  /// combine message with reason that causing the error
  String toString() {
    return [message, reason, elementLoaded]
        .where((element) => !ValidatorService.checkIsNullOrEmpty(element))
        .toList()
        .join("\n");
  }
}
