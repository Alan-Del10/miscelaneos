import 'package:share_plus/share_plus.dart';

class SharePlugin {
  static void shareLink(String link, String subject) {
    final params = ShareParams(text: link, subject: subject);
    SharePlus.instance.share(params);
  }
}
