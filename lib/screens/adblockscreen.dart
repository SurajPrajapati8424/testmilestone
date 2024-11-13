// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:adblock_detector/adblock_detector.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../widgets/text.dart';
import '../widgets/button.dart';

class AdblockScreen extends StatefulWidget {
  const AdblockScreen({super.key});

  @override
  AdblockScreenState createState() => AdblockScreenState();
}

class AdblockScreenState extends State<AdblockScreen> {
  bool? isAdBlockEnabled;

  @override
  void initState() {
    super.initState();
    // _checkAdBlock();
  }

  Future<void> _checkAdBlock() async {
    AdBlockDetector adBlockDetector = AdBlockDetector();
    debugPrint('testing adblock...');
    bool isAdblocking = await adBlockDetector.isInternetConnected();
    debugPrint('Internet is:$isAdblocking');
    // setState(() {
    //   isAdBlockEnabled = isAdblocking;
    // });
  }

  void checkManualInternet() async {
    bool inter = false;
    Uri testHost =
        Uri.parse('https://cdn.vibin.llc/test.txt'); // https://example.com
    Response res = await http.get(testHost);
    if (res.statusCode == 200) {
      inter = true;
    }
    debugPrint('testing Internet...');
    debugPrint('Internet is:$inter');
  }

  void checkInternet() async {
    AdBlockDetector adBlockDetector = AdBlockDetector();
    debugPrint('testing adblock...');
    bool isAdblocking = await adBlockDetector.isInternetConnected();
    debugPrint('Internet is:$isAdblocking');
  }

  void checkAdBlock({AdNetworks adNetworks = AdNetworks.googleAdMob}) async {
    AdBlockDetector adBlockDetector = AdBlockDetector();
    debugPrint('testing adblock...');
    bool isAdblocking = await adBlockDetector
        .isAdBlockEnabled(testAdNetworks: [adNetworks]); // test
    debugPrint('Ad Block is:$isAdblocking');
  }

  @override
  Widget build(BuildContext context) {
    // if (isAdBlockEnabled == null) {
    //   return const Center(child: const CircularProgressIndicator());
    // } else if (isAdBlockEnabled!) {
    // Show alert if ad blocker is enabled
    //   return AlertDialog(
    //     title: const Text("Ad Blocker Detected"),
    //     content: const Text("Please disable your ad blocker to support us."),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(),
    //         child: const Text("OK"),
    //       ),
    //     ],
    //   );
    // } else {
    //   // If no ad blocker, show normal content
    //   return const Center(
    //     child: Text("Welcome! No ad blocker detected."),
    //   );
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Block Test'),
      ),
      body: Column(
        children: [
          const TextWidget(
            text: 'test',
            color: Colors.black,
          ),
          Button(
            text: 'Manual Internet test',
            onTap: checkManualInternet,
          ),
          Button(
            text: 'Internet test',
            onTap: checkInternet,
          ),
          Button(
            text: 'AdBlock test',
            onTap: checkAdBlock,
          ),
        ],
      ),
    );
  }
}
