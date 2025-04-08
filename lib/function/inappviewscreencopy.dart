import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
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

class FileDownloadWebView extends StatefulWidget {
  final String url;
  const FileDownloadWebView({super.key, required this.url});

  @override
  State<FileDownloadWebView> createState() => _FileDownloadWebViewState();
}

class _FileDownloadWebViewState extends State<FileDownloadWebView> {
  late InAppWebViewController webViewController;
  late PullToRefreshController? pullToRefreshController;
  double progress = 0;
  double downloadProgress = 0;
  bool isDownloading = false;

  Widget indicator() {
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
        : const SizedBox.shrink();
  }

  Widget downloadIndicator() {
    return isDownloading
        ? LinearProgressIndicator(
            value: downloadProgress,
            color: ConstTheme_().Color.warning,
            minHeight: 5,
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
    return Scaffold(
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
                  pullToRefreshController: pullToRefreshController,
                  onWebViewCreated: (controller) async {
                    webViewController = controller;
                  },
                  onProgressChanged: (controller, progress) {
                    setState(() => this.progress = progress / 100);
                    if (progress == 100) {
                      pullToRefreshController?.endRefreshing();
                    }
                  },
                  onDownloadStartRequest:
                      (controller, downloadStartRequest) async {
                    await downloadWebViewFile(
                      downloadStartRequest: downloadStartRequest,
                      onDownloadProgress: (receivedBytes, totalBytes) {
                        setState(() {
                          isDownloading = true;
                          // downloadProgress = receivedBytes / totalBytes;
                          downloadProgress =
                              totalBytes > 0 ? receivedBytes / totalBytes : 0;
                        });
                      },
                      onDownloadComplete: () {
                        setState(() {
                          isDownloading = false;
                          downloadProgress = 0;
                        });
                      },
                      onDownloadError: (error) {
                        setState(() {
                          isDownloading = false;
                          downloadProgress = 0;
                        });
                      },
                    );
                  },
                  onLoadStart: (controller, url) {},
                  // onPermissionRequest: (controller, request) {
                  // },
                  onLoadStop: (controller, url) {
                    pullToRefreshController?.endRefreshing();
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    return NavigationActionPolicy.ALLOW;
                  },
                  onReceivedError: (controller, request, error) {
                    pullToRefreshController?.endRefreshing();
                  },
                  onUpdateVisitedHistory: (controller, url, isReload) {},
                  onConsoleMessage: (controller, consoleMessage) {},
                ),
                indicator(),
                if (isDownloading)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 70, horizontal: 20),
                    child: downloadIndicator(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// For Storage Permission
Future<bool> requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
    await Future.delayed(
        const Duration(milliseconds: 100)); // Small delay for stability
  }
  debugPrint('permission: $status');
  return status.isGranted;
}

Future<void> downloadWebViewFile(
    {required DownloadStartRequest downloadStartRequest,
    required Null Function(dynamic receivedBytes, dynamic totalBytes)
        onDownloadProgress,
    required Null Function() onDownloadComplete,
    Function(String error)? onDownloadError,
    required}) async {
  final String url = downloadStartRequest.url.toString();
  String fileName = downloadStartRequest.url.pathSegments.last;
  final String? mimeType = downloadStartRequest.mimeType;
  if (mimeType != null) {
    final extension = mimeType.split('/').last;
    if (!fileName.contains('.')) {
      fileName = '$fileName.$extension';
    }
  }
  // Implement your file download logic here
  try {
    // 1. Request storage permission (Android)
    if (Platform.isAndroid) {
      requestStoragePermission();
    }
    /**
      url: https://images.unsplash.com/photo-1743076851851-0762b336b56d?ixlib=rb-4.0.3&q=85&fm=jpg&crop=entropy&cs=srgb&dl=maria-budanova-pristavskaya-KYh5dRFjZJ0-unsplash.jpg
      fileName: photo-1743076851851-0762b336b56d
      mimeType: image/jpeg
     */
    // 2. Create download directory
    final Directory dir = Directory('/storage/emulated/0/Download');
    final String filePath = '${dir.path}/$fileName';

    debugPrint('Starting download from: $url');
    debugPrint('Saving to: $filePath');
    // 3. Start HTTP request
    // final response = await http.get(Uri.parse(url));
    final response =
        await http.Client().send(http.Request('GET', Uri.parse(url)));
    debugPrint('${response.statusCode}');
    // 4. Check for valid response
    if (response.statusCode != 200) {
      throw Exception('Failed to download file (HTTP ${response.statusCode})');
    }
    // 5. Get total file size
    final int totalBytes = response.contentLength ?? 0;
    int receivedBytes = 0;
    // final List<int> bytes = [];

    debugPrint('totalBytes: $totalBytes');
    debugPrint('receivedBytes: $receivedBytes');

    // 6. Open file for writing (Write the response bytes to the file)
    final File file = File(filePath);
    final IOSink sink = file.openWrite();

    // 7. Process stream with progress updates
    await response.stream.listen(
      (List<int> chunk) {
        receivedBytes += chunk.length;
        onDownloadProgress(receivedBytes, totalBytes);
        sink.add(chunk);
      },
      onDone: () async {
        await sink.close();
        onDownloadComplete();
      },
      onError: (error) {
        sink.close();
        file.delete(); // Remove incomplete file
        if (onDownloadError != null) {
          onDownloadError(error.toString());
        }
      },
      cancelOnError: true,
    ).asFuture();
  } catch (e) {
    if (onDownloadError != null) {
      onDownloadError(e.toString());
    } else {
      rethrow;
    }
  }
}
