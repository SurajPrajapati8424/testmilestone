import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<Map<String, dynamic>> selectMedia({
  required String mediaType, // 'image' or 'video'
  required ImageSource imgSource, // ImageSource.camera or ImageSource.gallery
}) async {
  final ImagePicker picker = ImagePicker();
  XFile? pickedFile;

  try {
    // Pick media based on the type
    pickedFile = mediaType == 'image'
        ? await picker.pickImage(source: imgSource)
        : await picker.pickVideo(source: imgSource);

    // Handle the result
    if (pickedFile != null) {
      final File filePath = File(pickedFile.path); // Convert XFile to File
      return {
        'success': true,
        'filePath': filePath,
        'mediaType': mediaType,
      };
    } else {
      return {
        'success': false,
        'error': 'No media selected',
      };
    }
  } on Exception catch (e) {
    debugPrint('Error picking media: $e');
    return {
      'success': false,
      'error': 'Failed to pick media: ${e.toString()}',
    };
  }
}
