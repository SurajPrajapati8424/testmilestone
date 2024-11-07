// 2. webview.dart
// inAppWebView Open url in WebView
// inAppWebView Open url in chrome

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// for in-app-web-view
import 'package:webview_flutter/webview_flutter.dart';

// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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

// for in-app-web-view

void openInAppWebView(BuildContext context, String url) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => WebViewPage(url: url),
    ),
  );
}

class WebViewPage extends StatelessWidget {
  final String url;
  const WebViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    WebViewController controllers;
    controllers = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {},
          onPageStarted: (url) {},
          onPageFinished: (url) {},
          onWebResourceError: (error) {
            debugPrint('WebView Error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    return
        // WebViewWidget(controller: controllers);
        Scaffold(
      appBar: AppBar(
        title: const Text('inApp'),
      ),
      body: WebViewWidget(controller: controllers),
    );
  }
}
