import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:csv/csv.dart';

class CsvpickerExample extends StatelessWidget {
  const CsvpickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const ElevatedButton(
              onPressed: pickCSV,
              child: Text('CSV'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('IMG'),
            ),
          ],
        ),
      ),
    );
  }
}

var value = ['Sr', 'Address', 'Name', 'Value', 'Type'];
Future<void> pickCSV() async {
  final picker = await mediaPicker();
  print(picker['path']);
}

// media picker //

Future<Map<String, dynamic>> mediaPicker() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      return {
        'path': file.path,
        'name': file.name,
        'size': file.size,
        'extension': file.extension,
      };
    } else {
      // User canceled the picker
      return {'error': 'No file selected'};
    }
  } catch (e) {
    // Handle any errors that occur during file picking
    return {'error': 'Error picking file: $e'};
  }
}

Future<Map<String, dynamic>> selectMedia({required String mediaTypes}) async {
  String mediaType = mediaTypes;
  ImagePicker picker = ImagePicker();
  ImageSource source = ImageSource.gallery;
  XFile? pickedFile;

  try {
    pickedFile = await ((mediaType == 'image')
        ? picker.pickImage(source: source)
        : picker.pickVideo(source: source));
    if (pickedFile != null) {
      // Process the picked media
      File filePath = File(pickedFile.path);
      // String savedPath = await saveFile(filePath);
      return {
        'filePath': filePath,
        // 'savedFilePath': File(savedPath),
        'mediaType': mediaType,
      };
    }
  } on Exception catch (e) {
    debugPrint('Error picking media: $e');
    return {'error': 'Failed to pick media'};
  }
  return {};
}
