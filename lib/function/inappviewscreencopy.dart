import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:testmilestone/screens/mytheme.dart';

class InAppWebViewScreenCopy extends StatefulWidget {
  final String url;
  const InAppWebViewScreenCopy({super.key, required this.url});

  @override
  State<InAppWebViewScreenCopy> createState() => _InAppWebViewScreenCopyState();
}

class _InAppWebViewScreenCopyState extends State<InAppWebViewScreenCopy> {
  late InAppWebViewController webViewController;
  late PullToRefreshController? pullToRefreshController;
  double progress = 0;

  Widget indicator() {
    return progress < 0.0
        ? Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white.withAlpha(70),
              ),
              child: CircularProgressIndicator(
                value: progress,
                color: const Color(0xFF00C85C),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: ConstTheme_().Color.primary,
        backgroundColor: ConstTheme_().Color.background.withAlpha(70),
      ),
      onRefresh: () async {
        await webViewController.reload();
      },
    );
  }

  @override
  void dispose() {
    webViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        //
        // Scaffold(
        //     appBar: AppBar(
        //       title: const Text('Enhanced Web View'),
        //       automaticallyImplyLeading: false,
        //     ),
        //     body:
        //
        SafeArea(
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
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) async {
                  // To properly use late InAppWebViewController webViewController
                  // and initialized it when webCreated pass the contoller or working with "InAppWebView" same.
                  webViewController = controller;
                },
                onProgressChanged: (controller, progress) {
                  setState(() => this.progress = progress / 100);
                  if (progress == 100) {
                    pullToRefreshController?.endRefreshing();
                  }
                },
                onLoadStart: (controller, url) {},
                // onPermissionRequest: (controller, request) {
                // },
                onLoadStop: (controller, url) {
                  pullToRefreshController?.endRefreshing();
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  return NavigationActionPolicy.ALLOW;
                },
                onReceivedError: (controller, request, error) {
                  pullToRefreshController?.endRefreshing();
                },
                onUpdateVisitedHistory: (controller, url, isReload) {},
                onConsoleMessage: (controller, consoleMessage) {},
              ),
              indicator(),
            ],
          ),
        ),
      ],
    ));
    //);
  }
}

void showWebViewPopup(BuildContext context, String url) {
  showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.8),
    context: context,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            color: Colors.black.withOpacity(0.8),
            child:
                InAppWebView(initialUrlRequest: URLRequest(url: WebUri(url))),
          ),
          //
          Positioned(
              top: -5,
              right: -5,
              child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                      backgroundColor: Colors.red.withOpacity(0.2),
                      radius: 18,
                      child: const Icon(Icons.close,
                          size: 15, color: Colors.white))))
        ],
      ),
    ),
  );
}
