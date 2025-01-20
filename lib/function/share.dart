import 'package:share_plus/share_plus.dart';

class ShareOption {
  static void shareTextOrUrl(String? url, String text) async {
    if (url != null) {
      await Share.share(url, subject: text);
    } else {
      await Share.share(text);
    }
  }
}
