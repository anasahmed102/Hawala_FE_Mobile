import 'package:hawala/service/validator_service.dart';

class ShowCaseModel {
  bool cartWidget;
  bool printSetting;
  bool sellesPerformance;
  bool paymentPerformance;

  ShowCaseModel({
    required this.cartWidget,
    required this.printSetting,
    required this.sellesPerformance,
    required this.paymentPerformance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartWidget': cartWidget,
      'printSetting': printSetting,
      'sellesPerformance': sellesPerformance,
      'paymentPerformance': paymentPerformance,
    };
  }

  factory ShowCaseModel.fromMap(Map<String, dynamic> map) {
    return ShowCaseModel(
      cartWidget: ValidatorService.checkBool(map['cartWidget'], defaultV: true),
      printSetting:
          ValidatorService.checkBool(map['printSetting'], defaultV: true),
      sellesPerformance:
          ValidatorService.checkBool(map['sellesPerformance'], defaultV: true),
      paymentPerformance:
          ValidatorService.checkBool(map['paymentPerformance'], defaultV: true),
    );
  }

  @override
  String toString() {
    return 'ShowCaseModel(cartWidget: $cartWidget,printSetting:$printSetting )';
  }
}
