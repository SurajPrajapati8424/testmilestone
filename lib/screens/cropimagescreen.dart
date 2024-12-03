import 'dart:io';
import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';

import '../function/selectmedia.dart';

class CropImageExample extends StatefulWidget {
  const CropImageExample({super.key});
  @override
  CropImageExampleState createState() => CropImageExampleState();
}

class CropImageExampleState extends State<CropImageExample> {
  // static const _images = [
  //   'assets/img/sun.png',
  //   'assets/img/img5.png',
  //   'assets/img/background.webp',
  //   'assets/img/cloud3.png',
  // ];

  final _cropController = CropController();
  final _imageDataList = <Uint8List>[];

  var _loadingImage = false;
  var _currentImage = 0;
  set currentImage(int value) {
    setState(() {
      _currentImage = value;
    });
    _cropController.image = _imageDataList[_currentImage];
  }

  var _isSumbnail = false;
  var _isCropping = false;
  var _isCircleUi = false;
  Uint8List? _croppedData;
  var _statusText = '';

  @override
  void initState() {
    pickImage();
    super.initState();
  }

  Future<void> pickImage() async {
    setState(() {
      _loadingImage = true;
    });
    // for (final assetName in _images) {
    //   _imageDataList.add(await _load(assetName));
    // }

    // select image
    final pickedImage =
        await selectMedia(mediaType: "image", imgSource: ImageSource.gallery);
    if (pickedImage['success'] == true) {
      File file = await pickedImage['filePath'];
      final Uint8List imageData = await file.readAsBytes();
      setState(() {
        _imageDataList.add(imageData);
        _loadingImage = false;
      });
    }
  }

  Future<Uint8List> load(String assetName) async {
    final assetData = await rootBundle.load(assetName);
    return assetData.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Visibility(
              visible: !_loadingImage && !_isCropping,
              replacement: const CircularProgressIndicator(),
              child: Column(
                children: [
                  if (_imageDataList.length >= 4)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          _buildSumbnail(_imageDataList[0]),
                          const SizedBox(width: 16),
                          _buildSumbnail(_imageDataList[1]),
                          const SizedBox(width: 16),
                          _buildSumbnail(_imageDataList[2]),
                          const SizedBox(width: 16),
                          _buildSumbnail(_imageDataList[3]),
                        ],
                      ),
                    ),
                  Expanded(
                    child: Visibility(
                      visible: _croppedData == null,
                      replacement: Center(
                        child: _croppedData == null
                            ? const SizedBox.shrink()
                            : Image.memory(_croppedData!),
                      ),
                      child: Stack(
                        children: [
                          if (_imageDataList.isNotEmpty) ...[
                            Crop(
                              willUpdateScale: (newScale) => newScale < 5,
                              controller: _cropController,
                              image: _imageDataList[_currentImage],
                              onCropped: (croppedData) {
                                setState(() {
                                  _croppedData = croppedData;
                                  _isCropping = false;
                                });
                              },
                              withCircleUi: _isCircleUi,
                              onStatusChanged: (status) => setState(() {
                                _statusText = <CropStatus, String>{
                                      CropStatus.nothing:
                                          'Crop has no image data',
                                      CropStatus.loading:
                                          'Crop is now loading given image',
                                      CropStatus.ready: 'Crop is now ready!',
                                      CropStatus.cropping:
                                          'Crop is now cropping image',
                                    }[status] ??
                                    '';
                              }),
                              initialSize: 0.5,
                              maskColor: _isSumbnail ? Colors.white : null,
                              cornerDotBuilder: (size, edgeAlignment) =>
                                  const SizedBox.shrink(),
                              interactive: true,
                              fixCropRect: true,
                              radius: 20,
                              initialRectBuilder: (viewportRect, imageRect) {
                                return Rect.fromLTRB(
                                  viewportRect.left + 24,
                                  viewportRect.top + 24,
                                  viewportRect.right - 24,
                                  viewportRect.bottom - 24,
                                );
                              },
                            ),
                            IgnorePointer(
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4, color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: GestureDetector(
                              onTapDown: (_) =>
                                  setState(() => _isSumbnail = true),
                              onTapUp: (_) =>
                                  setState(() => _isSumbnail = false),
                              child: CircleAvatar(
                                backgroundColor: _isSumbnail
                                    ? Colors.blue.shade50
                                    : Colors.blue,
                                child: const Center(
                                  child: Icon(Icons.crop_free_rounded),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_croppedData == null)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // IconButton(
                              //   icon: const Icon(Icons.crop_7_5),
                              //   onPressed: () {
                              //     _isCircleUi = false;
                              //     _cropController.aspectRatio = 16 / 4;
                              //   },
                              // ),
                              // IconButton(
                              //   icon: const Icon(Icons.crop_16_9),
                              //   onPressed: () {
                              //     _isCircleUi = false;
                              //     _cropController.aspectRatio = 16 / 9;
                              //   },
                              // ),
                              // IconButton(
                              //   icon: const Icon(Icons.crop_5_4),
                              //   onPressed: () {
                              //     _isCircleUi = false;
                              //     _cropController.aspectRatio = 4 / 3;
                              //   },
                              // ),
                              // IconButton(
                              //   icon: const Icon(Icons.crop_square),
                              //   onPressed: () {
                              //     _isCircleUi = false;
                              //     _cropController
                              //       ..withCircleUi = false
                              //       ..aspectRatio = 1;
                              //   },
                              // ),
                              IconButton(
                                  icon: const Icon(Icons.circle),
                                  onPressed: () {
                                    _isCircleUi = true;
                                    _cropController.withCircleUi = true;
                                  }),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isCropping = true;
                                });
                                _isCircleUi
                                    ? _cropController.cropCircle()
                                    : _cropController.crop();
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text('CROP IT!'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(_statusText),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildSumbnail(Uint8List data) {
    final index = _imageDataList.indexOf(data);
    return Expanded(
      child: InkWell(
        onTap: () {
          _croppedData = null;
          currentImage = index;
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            border: index == _currentImage
                ? Border.all(
                    width: 8,
                    color: Colors.blue,
                  )
                : null,
          ),
          child: Image.memory(
            data,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
