
import 'package:hawala/alerts/toast.dart';
import 'package:hawala/service/validator_service.dart';
import 'package:injectable/injectable.dart';

import 'package:url_launcher/url_launcher.dart';

@Named.from(LauncherService)
@LazySingleton()
class LauncherService {
  Future<void> openPhoneCall(String? phone) async {
    try {
      if (ValidatorService.checkIsNullOrEmpty(phone)) {
        return;
      }
      Uri uri = Uri.parse('tel:$phone');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        showToast("Failed");
      }
    } catch (e, c) {
      showToast("Failed");
    }
  }

  Future<void> openUrl(String url) async {
    try {
      if (ValidatorService.checkIsNullOrEmpty(url)) {
        return;
      }
      Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        showToast("Failed");
      }
    } catch (e, c) {
      showToast("Failed");
    }
  }
}
