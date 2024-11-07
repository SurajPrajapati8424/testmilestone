// 1. downloadFile(url or string, String extension, String mimeType);
// https://wsform.com/wp-content/uploads/2021/04/day.csv
// extension
// text
// link

// 2. webview.dart
// inAppWebView Open url in WebView
// inAppWebView Open url in chrome

// 3. checkInternet.dart:
// checkInternet with connectivity_plus
// alartDialog (color) =warning internet+

import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// const url = 'suraj';
// String fileName = 'tech';
// String ext = 'csv';
// const url = 'https://wsform.com/wp-content/uploads/2021/04/day.csv';

Future<void> downloadFile(
    String urlOrString, String fileName, String extensionName) async {
  if (await requestStoragePermission()) {
    debugPrint('Permission granted');

    final Uri? uri = Uri.tryParse(urlOrString);
    final bool isUrl =
        uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
    debugPrint('url type:$isUrl');

    final directory = Directory('/storage/emulated/0/Download');
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    String filename;
    if (isUrl) {
      // Extract filename from URL if available, else use default
      filename = uri.pathSegments.isNotEmpty
          ? uri.pathSegments.last
          : 'downloaded_file';
    } else {
      if (fileName.isEmpty || extensionName.isEmpty) {
        debugPrint('File name and extension are required for non-URL input.');
        return;
      }
      filename = '$fileName.$extensionName';
    }
    String filePath = '${directory.path}/$filename';

    if (!isUrl) {
      final file = File(filePath);
      await file.create();
      debugPrint('File created at: $filePath');
    } else {
      try {
        final response = await http.get(Uri.parse(urlOrString));
        if (response.statusCode == 200) {
          // Write the response bytes to the file
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);
          debugPrint('File downloaded at: $filePath');
        } else {
          debugPrint('Failed to download file: ${response.statusCode}');
        }
      } catch (e) {
        debugPrint('Error occurred while downloading file: $e');
      }
    }
  } else {
    debugPrint('Permission denied');
    return;
  }
}

// Permission
Future<bool> requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
  }
  debugPrint('permission: $status');
  return status.isGranted;
}

/*
Future<int> getFileSize(String filePath) async {
  try {
    final file = File(filePath);

    // Check if the file exists
    if (await file.exists()) {
      // Get the length of the file in bytes
      int fileSize = await file.length();
      debugPrint('File size: $fileSize bytes');
      return fileSize;
    } else {
      debugPrint('File does not exist at the specified path: $filePath');
      return -1; // Indicate that the file does not exist
    }
  } catch (e) {
    debugPrint('Error occurred while getting file size: $e');
    return -1; // Indicate an error
  }
}
 */