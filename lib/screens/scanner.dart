// import 'package:flutter/material.dart'; // flutter_document_scanner
// import 'package:flutter_document_scanner/flutter_document_scanner.dart';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:image_picker/image_picker.dart';

// class ScannerScreen extends StatelessWidget {
//   const ScannerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (context) {
//         return Scaffold(
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // * Basic example page
//                 ElevatedButton(
//                   onPressed: () => Navigator.push<void>(
//                     context,
//                     MaterialPageRoute(
//                       builder: (BuildContext context) => const BasicPage(),
//                     ),
//                   ),
//                   child: const Text(
//                     'Basic example',
//                   ),
//                 ),

//                 // * Custom example page
//                 ElevatedButton(
//                   onPressed: () => Navigator.push<void>(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const CustomPage(),
//                     ),
//                   ),
//                   child: const Text(
//                     'Custom example',
//                   ),
//                 ),

//                 // * From gallery example page
//                 ElevatedButton(
//                   onPressed: () => Navigator.push<void>(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const FromGalleryPage(),
//                     ),
//                   ),
//                   child: const Text(
//                     'From gallery example',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class BasicPage extends StatefulWidget {
//   const BasicPage({super.key});

//   @override
//   State<BasicPage> createState() => _BasicPageState();
// }

// class _BasicPageState extends State<BasicPage> {
//   final _controller = DocumentScannerController();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DocumentScanner(
//         controller: _controller,
//         cropPhotoDocumentStyle: CropPhotoDocumentStyle(
//           top: MediaQuery.of(context).padding.top,
//         ),
//         onSave: (Uint8List imageBytes) {
//           // ? Bytes of the document/image already processed
//         },
//       ),
//     );
//   }
// }

// class CustomPage extends StatefulWidget {
//   const CustomPage({super.key});

//   @override
//   State<CustomPage> createState() => _CustomPageState();
// }

// class _CustomPageState extends State<CustomPage> {
//   final _controller = DocumentScannerController();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DocumentScanner(
//         controller: _controller,
//         generalStyles: const GeneralStyles(
//           hideDefaultBottomNavigation: true,
//           messageTakingPicture: 'Taking picture of document',
//           messageCroppingPicture: 'Cropping picture of document',
//           messageEditingPicture: 'Editing picture of document',
//           messageSavingPicture: 'Saving picture of document',
//           baseColor: Colors.teal,
//         ),
//         takePhotoDocumentStyle: TakePhotoDocumentStyle(
//           top: MediaQuery.of(context).padding.top + 25,
//           hideDefaultButtonTakePicture: true,
//           onLoading: const CircularProgressIndicator(
//             color: Colors.white,
//           ),
//           children: [
//             // * AppBar
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 color: Colors.teal,
//                 padding: EdgeInsets.only(
//                   top: MediaQuery.of(context).padding.top + 10,
//                   bottom: 15,
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'Take a picture of the document',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             // * Button to take picture
//             Positioned(
//               bottom: MediaQuery.of(context).padding.bottom + 10,
//               left: 0,
//               right: 0,
//               child: Center(
//                 child: ElevatedButton(
//                   onPressed: _controller.takePhoto,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                   ),
//                   child: const Text(
//                     'Take picture',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         cropPhotoDocumentStyle: CropPhotoDocumentStyle(
//           top: MediaQuery.of(context).padding.top,
//           maskColor: Colors.teal.withOpacity(0.2),
//         ),
//         editPhotoDocumentStyle: EditPhotoDocumentStyle(
//           top: MediaQuery.of(context).padding.top,
//         ),
//         resolutionCamera: ResolutionPreset.ultraHigh,
//         pageTransitionBuilder: (child, animation) {
//           final tween = Tween<double>(begin: 0, end: 1);

//           final curvedAnimation = CurvedAnimation(
//             parent: animation,
//             curve: Curves.easeOutCubic,
//           );

//           return ScaleTransition(
//             scale: tween.animate(curvedAnimation),
//             child: child,
//           );
//         },
//         onSave: (Uint8List imageBytes) {
//           // ? Bytes of the document/image already processed
//           // USE- saved(Uint8List capturedImage,String fileName = 'aqScreenshot') from screenshotwidget
//         },
//       ),
//     );
//   }
// }

// class FromGalleryPage extends StatefulWidget {
//   const FromGalleryPage({super.key});

//   @override
//   State<FromGalleryPage> createState() => _FromGalleryPageState();
// }

// class _FromGalleryPageState extends State<FromGalleryPage> {
//   final controller = DocumentScannerController();
//   bool imageIsSelected = false;

//   @override
//   void initState() {
//     super.initState();

//     controller.currentPage.listen((AppPages page) {
//       if (page == AppPages.takePhoto) {
//         setState(() => imageIsSelected = false);
//       }

//       if (page == AppPages.cropPhoto) {
//         setState(() => imageIsSelected = true);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DocumentScanner(
//         controller: controller,
//         generalStyles: GeneralStyles(
//           showCameraPreview: false,
//           widgetInsteadOfCameraPreview: Center(
//             child: ElevatedButton(
//               onPressed: _selectImage,
//               child: const Text('Select image'),
//             ),
//           ),
//         ),
//         onSave: (Uint8List imageBytes) {
//           // ? Bytes of the document/image already processed
//         },
//       ),
//     );
//   }

//   Future<void> _selectImage() async {
//     final picker = ImagePicker();
//     final image = await picker.pickImage(source: ImageSource.gallery);

//     if (image == null) return;

//     await controller.findContoursFromExternalImage(
//       image: File(image.path),
//     );
//   }
// }
