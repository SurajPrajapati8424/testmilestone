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

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

// const url = 'suraj';
String fileName = 'tech';
String ext = 'csv';
const url = 'https://wsform.com/wp-content/uploads/2021/04/day.csv';
// final response = await http.head(Uri.parse(url));
// String? mime = response.headers['content-type'];
// debugPrint('mime :$mime');
// final file = File(filePath);
// await file.create(); // Create an empty file
// debugPrint('File created at: $filePath');
Future<void> download() async {
  // final response = await http.get(Uri.parse(url));
  // Map<String, String> mime = response.headers;
  // debugPrint('$mime');
  final Uri? uri = Uri.tryParse(url);
  final bool isUrl =
      uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  debugPrint('url type:$isUrl');
  // Get the application documents directory
  final directory = await getExternalStorageDirectory();
  if (!isUrl) {
    // If it's not a URL
    String filename = '$fileName.$ext'; // Append extension
    String filePath = '${directory!.path}/$filename';
    // Create an empty file with the given name and extension
    final file = File(filePath);
    await file.create(); // Create the file
    debugPrint('File created at: $filePath');
  } else {
    // It's URL
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String filename = '$fileName.$ext'; // Append extension
        String filePath = '${directory!.path}/$filename';
        // Write the response bytes to the file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        debugPrint('File downloaded at:$filePath');
        // Get and print the file size
      } else {
        debugPrint('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error occurred while downloading file: $e');
    }
  }

  // if (url.isEmpty || url.trim() == '') {
  //   debugPrint('url is empty');
  //   try {
  //     final Directory? appDirectory = await getExternalStorageDirectory();
  //     final filePath = '${appDirectory!.path}/$fileName.$ext';
  //     final file = File(filePath);
  //     await file.create(); // Create an empty file
  //   } catch (e) {
  //     debugPrint('Failed to save blank file:$e');
  //   }
  // }
  // try {
  //   // Get the application documents directory
  //   // Make the HTTP GET request to download the file content
  //   final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     // Write the response bytes to the file
  //     final file = File(filePath);
  //     await file.writeAsBytes(response.bodyBytes);
  //     debugPrint('File downloaded at:$filePath');
  //     // Get and print the file size
  //   } else {
  //     debugPrint('Failed to download file: ${response.statusCode}');
  //   }
  // } catch (e) {
  //   debugPrint('failed to save :$e');
  // }
}


// // Permission
// Future<bool> requestStoragePermission() async {
//   var status = await Permission.storage.status;
//   if (!status.isGranted) {
//     status = await Permission.storage.request();
//   }
//   debugPrint('permission: $status');
//   return status.isGranted;
// }

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