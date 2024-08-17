import 'package:hawala/shared/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';


@Named.from(ShareService)
@LazySingleton()
class ShareService {
  Future<bool?> shareText({required String text, String? subject}) async {
    try {
      final result = await Share.share(text, subject: subject);

      return result.status == ShareResultStatus.success;
    } catch (e, c) {
      logger('Failed to share a text: ${e}');
      return null;
    }
  }

  Future<bool?> shareFile(
      {required XFile file, String? caption, String? subject}) async {
    try {
      final result =
          await Share.shareXFiles([file], text: caption, subject: subject);
      return result.status == ShareResultStatus.success;
    } catch (e, c) {
      logger('Failed to share a file: ${e}');
      return null;
    }
  }

  Future<bool?> shareFiles(
      {required List<XFile> files, String? caption, String? subject}) async {
    try {
      final result =
          await Share.shareXFiles(files, text: caption, subject: subject);
      return result.status == ShareResultStatus.success;
    } catch (e, c) {
      logger('Failed to share a files: ${e}');
      return null;
    }
  }
}
