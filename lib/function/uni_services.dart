/*
adb shell 'am start -a android.intent.action.VIEW \
    -c android.intent.category.BROWSABLE \
    -d "http://<web-domain>/details"' \
    <package name>

> 'C:\Users\suraj\AppData\Local\Android\Sdk\platform-tools\adb.exe' 
> shell
> am start -a android.intent.action.VIEW \-d "http://aqquiz-link.edu" com.example.testmilestone
> am start -a android.intent.action.VIEW \-d "https://aqquiz-link.edu/#/personal_info" com.example.testmilestone
> am start -a android.intent.action.VIEW \-d "https://aqquiz-link.edu/#/personal_info?name=JohnDoe&email=johndoe@example.com&contact=1234567890&age=30" com.example.testmilestone
> am start -a android.intent.action.VIEW \-d "https://aqquiz-link.edu/#/setting" com.example.testmilestone
> am start -a android.intent.action.VIEW \-d "aqquizapp://aqquiz" com.example.testmilestone

> GOTO app settings allow open from Link "aqquiz-link.edu" should be listed
*/

import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

import '../screens/settingscreen.dart';

class UniLinkListener extends StatefulWidget {
  final Widget child;
  const UniLinkListener({super.key, required this.child});

  @override
  State<UniLinkListener> createState() => _UniLinkListenerState();
}

class _UniLinkListenerState extends State<UniLinkListener> {
  late AppLinks appLinks;
  late StreamSubscription<Uri> linkSubscription;
  @override
  void initState() {
    super.initState();
    appLinks = AppLinks(); // AppLinks is singleton
    // Subscribe to all events (initial link and further)
    linkSubscription = appLinks.uriLinkStream.listen((uri) {
      debugPrint('URI: ${uri.toString()}');
      debugPrint('Fragment: ${uri.fragment}');
      debugPrint('Path: ${uri.path}');
      debugPrint('Path Segments: ${uri.pathSegments}');
      debugPrint('Query Parameters: ${uri.queryParameters}');

      // Handle Query Parameters
      debugPrint('${uri.queryParameters['name']}');
      debugPrint('${uri.queryParameters['email']}');
      debugPrint('${uri.queryParameters['contact']}');
      debugPrint('${uri.queryParameters['age']}');

      if (uri.pathSegments.first == 'setting') {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SettingScreen()));
      }

      // Handle the link here
      debugPrint('Handle Fragment');
      if (uri.fragment.isNotEmpty) {
        // Handle fragment part of the URL
        final fragmentParts = uri.fragment.split('/');
        debugPrint('Fragment Parts: $fragmentParts');
        // Example: Handle specific fragment paths
      }
    });
  }

  @override
  void dispose() {
    linkSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
