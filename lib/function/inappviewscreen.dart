import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../widgets/button.dart';
import '../widgets/text.dart';

class InAppWebViewScreen extends StatefulWidget {
  final String url;
  const InAppWebViewScreen({super.key, required this.url});

  @override
  State<InAppWebViewScreen> createState() => _InAppWebViewScreenState();
}

class _InAppWebViewScreenState extends State<InAppWebViewScreen> {
  late InAppWebViewController webViewController;
  double progress = 0;
  String loadingType = "circle"; // linear or "circle"
  // 3. Navigation Controls back/forward
  bool canGoBack = false;
  bool canGoForward = false;

  // 1. Progress Indicator
  Widget buildProgressIndicator(type) {
    switch (type) {
      case "circle":
        return progress < 1.0
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
            : const SizedBox();
      case "linear":
      default:
        return progress < 1.0
            ? LinearProgressIndicator(
                value: progress,
                color: const Color(0xFF00C85C),
              )
            : const SizedBox();
    }
  }

  // 2. Handling URL Navigation Decisions - to block URL
  Future<NavigationActionPolicy> handleNavigation(
      NavigationAction request) async {
    // Block example.com
    const String blockUrl = "pub.dev/packages/firebase_auth";
    if (request.request.url.toString().contains(blockUrl)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(blockUrl),
          content: const Text('This domain is not allowed.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        ),
      );
      return NavigationActionPolicy.CANCEL;
    }
    return NavigationActionPolicy.ALLOW;
  }

  // 4. Cookie Manager
  Future<void> manageCookies() async {
    final WebUri url = WebUri(widget.url);
    debugPrint("WebUri: $url");
    // Get the CookieManager instance
    final CookieManager cookieManager = CookieManager.instance();

    // Set the expiration date for the cookie in milliseconds
    final int expiresDate =
        DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch;
    // Set the cookie
    await cookieManager.setCookie(
      url: url,
      name: 'testMilestoneCookie',
      value: 'testMilestoneCookieValue',
      expiresDate: expiresDate,
      isSecure: true, // Ensure this matches the URL scheme (true for HTTPS)
    );
    debugPrint("Cookie set successfully");

    // Get cookies
    // List<Cookie> cookies = await cookieManager.getCookies(url: url);

    // Get a cookie
    Cookie? cookie = await cookieManager.getCookie(
      url: url,
      name: "testMilestoneCookie",
    );
    debugPrint("Retrieved Cookie: ${cookie?.toString() ?? 'null'}");

    // Delete cookies
    // await cookieManager.deleteCookies(url: url, domain: ".pub.dev");

    // Delete a cookie
    await cookieManager.deleteCookie(url: url, name: "testMilestoneCookie");
    debugPrint("Cookie deleted successfully");

    // Verify deletion
    Cookie? deletedCookie = await cookieManager.getCookie(
      url: url,
      name: "testMilestoneCookie",
    );
    debugPrint("Cookie after deletion: ${deletedCookie?.toString() ?? 'null'}");

    /**
     I/flutter (30803): WebUri: https://pub.dev/
      I/flutter (30803): Cookie set successfully
      I/flutter (30803): Retrieved Cookie: 
                        Cookie{
                          domain: pub.dev, 
                          expiresDate: 1740016506000, 
                          isHttpOnly: true, 
                          isSecure: true, 
                          isSessionOnly: null, 
                          name: testMilestoneCookie, 
                          path: /, 
                          sameSite: null, 
                          value: testMilestoneCookieValue
                          }
      I/flutter (30803): Cookie deleted successfully
      I/flutter (30803): Cookie after deletion: null
     */
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool?> showBackDialog(BuildContext contexts) {
    return showDialog<bool>(
        context: contexts,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Are you sure you want to leave this page?'),
            actions: [
              Button(
                text: 'Nevermind',
                onTap: () {
                  Navigator.of(contexts).pop(false);
                },
              ),
              Button(
                text: 'Leave',
                onTap: () {
                  Navigator.of(contexts).pop(true);
                },
              ),
            ],
          );
        }).then((onValue) => onValue ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        // Show confirmation dialog before popping
        if (didPop) {
          debugPrint("POP BACK");
        } else {
          debugPrint("FALSE");
          final bool shouldPop = await showBackDialog(context) ?? false;
          if (context.mounted && shouldPop) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
          appBar: AppBar(
            // 5. Custom App Bar with Navigation Controls
            title: const Text('Enhanced Web View'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () async {
                  await webViewController.reload();
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: canGoBack ? () => webViewController.goBack() : null,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed:
                    canGoForward ? () => webViewController.goForward() : null,
              ),
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () async {
                    final bool shouldPop =
                        await showBackDialog(context) ?? false;
                    if (context.mounted && shouldPop) {
                      Navigator.of(context).pop();
                    }
                  }),
              PopupMenuButton(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: const TextWidget(text: "linear"),
                          onTap: () {
                            setState(() {
                              loadingType = "linear";
                            });
                          },
                        ),
                        PopupMenuItem(
                          child: const TextWidget(text: "circle"),
                          onTap: () {
                            setState(() {
                              loadingType = "circle";
                            });
                          },
                        ),
                      ])
            ],
          ),
          body: Column(
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
                      initialUserScripts: UnmodifiableListView<UserScript>([]),
                      onWebViewCreated: (controller) async {
                        // To properly use late InAppWebViewController webViewController
                        // and initialized it when webCreated pass the contoller or working with "InAppWebView" same.
                        webViewController = controller;
                        manageCookies();
                      },
                      onProgressChanged: (controller, progress) {
                        setState(() {
                          this.progress = progress / 100;
                        });
                      },
                      onLoadStart: (controller, url) {},
                      // onPermissionRequest: (controller, request) {
                      // },
                      onLoadStop: (controller, url) {
                        // 3. back/forward
                        controller
                            .canGoBack()
                            .then((value) => setState(() => canGoBack = value));
                        controller.canGoForward().then(
                            (value) => setState(() => canGoForward = value));
                      },
                      shouldOverrideUrlLoading:
                          (controller, navigationAction) async {
                        return handleNavigation(navigationAction);
                        // return NavigationActionPolicy.ALLOW;
                      },
                      onReceivedError: (controller, request, error) {},
                      onUpdateVisitedHistory: (controller, url, isReload) {},
                      onConsoleMessage: (controller, consoleMessage) {
                        // debugPrint('$consoleMessage');
                      },
                    ),
                    buildProgressIndicator(loadingType), // linear || circle
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
