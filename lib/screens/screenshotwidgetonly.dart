// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:testmilestone/function/download.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';

class ScreenshotWidgetOnly extends StatefulWidget {
  const ScreenshotWidgetOnly({super.key});

  @override
  ScreenshotWidgetOnlyState createState() => ScreenshotWidgetOnlyState();
}

class ScreenshotWidgetOnlyState extends State<ScreenshotWidgetOnly> {
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    requestStoragePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Screenshot(
                  controller: screenshotController,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/SachinGanesh/screenshot/refs/heads/master/example/assets/images/flutter.png',
                            ),
                            const Text(
                                "This widget will be captured as an image"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/SachinGanesh/screenshot/refs/heads/master/example/assets/images/flutter.png',
                            ),
                            const Text(
                                "This widget will be captured as an image"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/SachinGanesh/screenshot/refs/heads/master/example/assets/images/flutter.png',
                            ),
                            const Text(
                                "This widget will be captured as an image"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/SachinGanesh/screenshot/refs/heads/master/example/assets/images/flutter.png',
                            ),
                            const Text(
                                "This widget will be captured as an image"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/SachinGanesh/screenshot/refs/heads/master/example/assets/images/flutter.png',
                            ),
                            const Text(
                                "This widget will be captured as an image"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/SachinGanesh/screenshot/refs/heads/master/example/assets/images/flutter.png',
                            ),
                            const Text(
                                "This widget will be captured as an image"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/SachinGanesh/screenshot/refs/heads/master/example/assets/images/flutter.png',
                            ),
                            const Text(
                                "This widget will be captured as an image"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/SachinGanesh/screenshot/refs/heads/master/example/assets/images/flutter.png',
                            ),
                            const Text(
                                "This widget will be captured as an image"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/SachinGanesh/screenshot/refs/heads/master/example/assets/images/flutter.png',
                            ),
                            const Text(
                                "This widget will be captured as an image"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/SachinGanesh/screenshot/refs/heads/master/example/assets/images/flutter.png',
                            ),
                            const Text(
                                "This widget will be captured as an image"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/SachinGanesh/screenshot/refs/heads/master/example/assets/images/flutter.png',
                            ),
                            const Text(
                                "This widget will be captured as an image"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/SachinGanesh/screenshot/refs/heads/master/example/assets/images/flutter.png',
                            ),
                            const Text(
                                "This widget will be captured as an image"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/SachinGanesh/screenshot/refs/heads/master/example/assets/images/flutter.png',
                            ),
                            const Text(
                                "This widget will be captured as an image"),
                          ],
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await saved(screenshotController);
          // show
          screenshotController
              .capture(delay: const Duration(milliseconds: 10))
              .then((capturedImage) async {
            showCapturedWidget(context, capturedImage!);
          }).catchError((onError) {
            debugPrint(onError);
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Future<dynamic> showCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Captured widget screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }
}

Future<void> saved(ScreenshotController screenshotController) async {
  // final result = await ImageGallerySaver.save(image.readAsBytesSync());
  final directory = Directory('/storage/emulated/0/Download');
  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }
  String filename = 'aqScreenshot${DateTime.now().millisecondsSinceEpoch}.png';
  try {
    await screenshotController.captureAndSave(
      directory.path,
      fileName: filename,
    );
    debugPrint("Saved");
  } catch (e) {
    debugPrint("Filed to save Screenshot $e");
  }
}
