import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// blurHash code generator
import 'package:blurhash_dart/blurhash_dart.dart' as blurhashcode;
// blurHash display
import 'package:flutter_blurhash/flutter_blurhash.dart' as blurhashdisplay;

Future<bool> requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
  }
  debugPrint('permission: $status');
  return status.isGranted;
}

Future<Map<String, dynamic>> selectMedia({required String mediaTypes}) async {
  ImagePicker picker = ImagePicker();
  XFile? pickedFile;

  if (await requestStoragePermission()) {
    try {
      pickedFile = await ((mediaTypes == 'image')
          ? picker.pickImage(source: ImageSource.gallery)
          : picker.pickVideo(source: ImageSource.gallery));

      if (pickedFile != null) {
        File filePath = File(pickedFile.path);

        // Generate BlurHash if the media is an image
        String? blurHash = mediaTypes == 'image'
            ? await generateBlurHashFromImagePath(filePath.path)
            : null;
        debugPrint('blurHash code:$blurHash');

        return {
          'filePath': filePath,
          'mediaType': mediaTypes,
          'blurHash': blurHash,
        };
      }
    } on Exception catch (e) {
      debugPrint('Error picking media: $e');
      return {'error': 'Failed to pick media'};
    }
  } else {
    debugPrint('Permission denied');
  }
  return {};
}

// Function to generate a BlurHash from an image path
Future<String?> generateBlurHashFromImagePath(String imagePath) async {
  try {
    final File imageFile = File(imagePath);
    final Uint8List imageBytes = await imageFile.readAsBytes();
    final img.Image? decodedImage = img.decodeImage(imageBytes);

    if (decodedImage == null) return null;

    // Convert image to raw RGBA bytes
    // Uint8List pixels = decodedImage.getBytes(format: img.Format.rgba);

    // Generate the BlurHash string
    blurhashcode.BlurHash code = blurhashcode.BlurHash.encode(
      decodedImage,
      numCompX: 4,
      numCompY: 3,
    );
    return code.hash;
  } catch (e) {
    debugPrint("Error generating BlurHash: $e");
    return null;
  }
}

//////////////// blurhash.dart

class BlurHashApp extends StatefulWidget {
  const BlurHashApp({super.key});
  @override
  State<BlurHashApp> createState() => _BlurHashAppState();
}

class _BlurHashAppState extends State<BlurHashApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blur Hash Screnn'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              Map<String, dynamic> filePath =
                  await selectMedia(mediaTypes: "image");
              debugPrint('filePath->${filePath['filePath']}');
              debugPrint('code->${filePath['blurHash']}');
            },
            child: const Text('select image'),
          ),
          const Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: blurhashdisplay.BlurHash(
                hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I",
                image:
                    'https://plus.unsplash.com/premium_photo-1664302231006-26363a21318b?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                duration: Duration(milliseconds: 500),
              ), // flutter_blurhash
            ),
          ),
        ],
      ),
    );
  }
}
