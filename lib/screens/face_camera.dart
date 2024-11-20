import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:face_camera/face_camera.dart';

class Face_Camera extends StatefulWidget {
  const Face_Camera({Key? key}) : super(key: key);
  @override
  State<Face_Camera> createState() => _Face_CameraState();
}

class _Face_CameraState extends State<Face_Camera> {
  File? _capturedImage;
  late FaceCameraController controller;

  @override
  void initState() {
    controller = FaceCameraController(
      autoCapture: true,
      defaultCameraLens: CameraLens.front,
      performanceMode: FaceDetectorMode.fast,
      onCapture: (File? image) async {
        print("Image captured");
        await _capturedImage!.delete();
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const NewPage()),
        // );
      },
      onFaceDetected: (Face? face) {
        if (face != null) {
          if (kDebugMode) {
            print("::----------------------");
            print('face.headEulerAngleX: ${face.headEulerAngleX}');
            print('face.headEulerAngleY: ${face.headEulerAngleY}');
            print('face.headEulerAngleZ: ${face.headEulerAngleZ}');
            print('face.trackingId: ${face.trackingId}');
            print(
                'face.rightEyeOpenProbability ${face.rightEyeOpenProbability}');
            print('face.leftEyeOpenProbability ${face.leftEyeOpenProbability}');
            print('face.smilingProbability ${face.smilingProbability}');
            print("::----------------------");
          }

          if (face.rightEyeOpenProbability != null &&
              face.leftEyeOpenProbability != null) {
            if (face.rightEyeOpenProbability! < 0.5 ||
                face.leftEyeOpenProbability! < 0.5) {
              print("Face detected: ${face.boundingBox}");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const NewPage()),
              );
            }
          }
        } else {
          print("Face not detected");
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('FaceCamera example app'),
          ),
          body: Builder(builder: (context) {
            if (_capturedImage != null) {
              return Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.file(
                      _capturedImage!,
                      width: double.maxFinite,
                      fit: BoxFit.fitWidth,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await controller.startImageStream();
                        setState(() => _capturedImage = null);
                      },
                      child: const Text(
                        'Capture Again',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              );
            }
            return SmartFaceCamera(
                controller: controller,
                messageBuilder: (context, face) {
                  if (face == null) {
                    return _message('Place your face in the camera');
                  }
                  if (!face.wellPositioned) {
                    return _message('Center your face in the square');
                  }
                  return const SizedBox.shrink();
                });
          })),
    );
  }

  Widget _message(String msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class NewPage extends StatelessWidget {
  const NewPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FaceCamera example app')),
      body: const Center(child: Text('New Page')),
    );
  }
}
