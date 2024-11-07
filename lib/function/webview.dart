// 2. webview.dart
// inAppWebView Open url in WebView
// inAppWebView Open url in chrome

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Browser {
  final ChromeSafariBrowser _browser = MyChromeSafariBrowser();
  Browser() {
    // Adding a custom menu item if needed
    _browser.addMenuItem(
      ChromeSafariBrowserMenuItem(
        id: 1,
        label: 'Custom Menu Item',
        onClick: (url, title) {
          debugPrint('Custom menu item clicked!');
        },
      ),
    );
  }

  // Method to open the Chrome Custom Tab or Safari View Controller
  Future<void> open({required String url}) async {
    await _browser.open(
      url: WebUri(url),
      settings: ChromeSafariBrowserSettings(
        shareState: CustomTabsShareState.SHARE_STATE_OFF,
        barCollapsingEnabled: true,
      ),
    );
  }
}

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    debugPrint("ChromeSafari browser opened");
  }

  // @override
  // void onCompletedInitialLoad(bool didLoadSuccessfully) {debugPrint("ChromeSafari browser initial load completed");}

  @override
  void onClosed() {
    debugPrint("ChromeSafari browser closed");
  }
}
