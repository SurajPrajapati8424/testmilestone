import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewScreenCopy extends StatefulWidget {
  final String url;
  const InAppWebViewScreenCopy({super.key, required this.url});

  @override
  State<InAppWebViewScreenCopy> createState() => _InAppWebViewScreenCopyState();
}

class _InAppWebViewScreenCopyState extends State<InAppWebViewScreenCopy> {
  late InAppWebViewController webViewController;
  double progress_ = 0;

  Widget indicator() {
    return progress_ < 0.0
        ? Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white.withAlpha(70),
              ),
              child: CircularProgressIndicator(
                value: progress_,
                color: const Color(0xFF00C85C),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Enhanced Web View'),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                      initialSettings: InAppWebViewSettings(
                        javaScriptEnabled: true,
                        useShouldOverrideUrlLoading: true,
                        mediaPlaybackRequiresUserGesture: false,
                        supportZoom: false,
                        transparentBackground: true,
                      ),
                      onWebViewCreated: (controller) async {
                        // To properly use late InAppWebViewController webViewController
                        // and initialized it when webCreated pass the contoller or working with "InAppWebView" same.
                        webViewController = controller;
                      },
                      onProgressChanged: (controller, progress) {
                        setState(() {
                          progress_ = progress / 100;
                        });
                      },
                      onLoadStart: (controller, url) {},
                      // onPermissionRequest: (controller, request) {
                      // },
                      onLoadStop: (controller, url) {},
                      shouldOverrideUrlLoading:
                          (controller, navigationAction) async {
                        return NavigationActionPolicy.ALLOW;
                      },
                      onReceivedError: (controller, request, error) {},
                      onUpdateVisitedHistory: (controller, url, isReload) {},
                      onConsoleMessage: (controller, consoleMessage) {},
                    ),
                    indicator(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
