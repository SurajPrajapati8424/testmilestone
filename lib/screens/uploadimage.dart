import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testmilestone/widgets/button.dart';
import 'package:http/http.dart' as http;

import '../function/selectmedia.dart';

class UploadImageExample extends StatelessWidget {
  const UploadImageExample({super.key});

  @override
  Widget build(BuildContext context) {
    // String img =
    //     "/9j/4QEuRXhpZgAATU0AKgAAAAgABQEAAAMAAAABBDgAAAEBAAMAAAABCWAAAAExAAIAAAAYAAAASodpAAQAAAABAAAAYgESAAQAAAABAAAAAAAAAABBbmRyb2lkIFJNWDIxNTFfMTFfRi4xMgAABZADAAIAAAAUAAAApJKRAAIAAAAEMDM5AKQgAAIAAAAlAAAAuJARAAIAAAAHAAAA3ZIIAAQAAAABAAAAAAAAAAAyMDI0OjEyOjAzIDEwOjI4OjI3ADBjMmM3ZjQ0LWE1NDUtNDMyYi04ODMxLTFhNjhlYzNjMzM5ZgArMDU6MzAAAAMBAAADAAAAAQQ4AAABMQACAAAAGAAAAQ4BAQADAAAAAQlgAAAAAAAAQW5kcm9pZCBSTVgyMTUxXzExX0YuMTIA/+AAEEpGSUYAAQEAAAEAAQAA/+ICBElDQ19QUk9GSUxFAAEBAAAB9GFwcGwEAAAAbW50clJHQiBYWVogB+IABgAYAA0AFgAgYWNzcEFQUEwAAAAAT1BQTwAAAAAAAAAAAAAAAAAAAAAAAPbWAAEAAAAA0y1hcHBsAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJZGVzYwAAAPAAAABoY3BydAAAAVgAAAAkd3RwdAAAAXwAAAAUclhZWgAAAZAAAAAUZ1hZWgAAAaQAAAAUYlhZWgAAAbgAAAAUclRSQwAAAcwAAAAoZ1RSQwAAAcwAAAAoYlRSQwAAAcwAAAAoZGVzYwAAAAAAAAAEc1JHQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB0ZXh0AAAAAENvcHlyaWdodCBBcHBsZSBJbmMuLCAyMDE3AABYWVogAAAAAAAA9tYAAQAAAADTLVhZWiAAAAAAAABvogAAOPUAA";
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Button(
            text: 'Upload Img',
            onTap: () async {
              // Upload image
              try {
                final Map<String, dynamic> selectedImg = await selectMedia(
                  mediaType: 'image',
                  imgSource: ImageSource.gallery,
                );
                if (selectedImg['success'] == true) {
                  File imgFile = selectedImg['filePath'];
                  debugPrint('Image Path: ${imgFile.path}');
                  // Upload image to API
                  await uploadImage(imgFile);
                } else {
                  debugPrint('Error: ${selectedImg['error']}');
                }
              } catch (e) {
                debugPrint('An unexpected error occurred: $e');
              }
            },
          ),
          // sssssss
          // imgData(apiImg: img),
        ],
      ),
    );
  }
}

Future<void> uploadImage(File imgFile) async {
  const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  try {
    // Convert the image to a Base64 string
    Uint8List imageBytes = await imgFile.readAsBytes();
    // String base64Image = base64Encode(imageBytes);

    // Prepare the payload
    final Map<String, dynamic> payload = {
      "imgTitle": "Image",
      "img": imageBytes,
      "userId": 1,
    };
    // Make the POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    // If uploaded
    if (response.statusCode == 201) {
      debugPrint('Image uploaded successfully: ${response.body}');
    } else {
      debugPrint('Failed to upload image. Status code: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error uploading image: $e');
  }
}

Widget imgData({required String apiImg}) {
  Uint8List imageBytes = base64Decode(apiImg);
  return Image.memory(imageBytes);
}

/*
Future<String> saveFile(File filePath) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final String fileName = paths.basename(filePath.path);
    final String savedPath = paths.join(directory.path, fileName);
    await filePath.copy(savedPath);
    return savedPath;
  } on Exception catch (e) {
    debugPrint('Error saving file: $e');
    return '';
  }
}
*/