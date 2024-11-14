import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:feedback/feedback.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => submitFeedback(context),
              child: const Text('Feedback'),
            )
          ],
        ),
      ),
    );
  }
}

void submitFeedback(BuildContext context) async {
  BetterFeedback.of(context).show((UserFeedback feedback) async {
    final screenshotFilePath = await writeImageToStorage(feedback.screenshot);
    final Email email = Email(
      body: feedback.text,
      subject: 'App Feedback',
      recipients: ['support@dsvdsvdsvdsv.com'],
      attachmentPaths: [screenshotFilePath],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  });
}

Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
  final Directory output = await getTemporaryDirectory();
  final String screenshotFilePath = '${output.path}/feedback.png';
  final File screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
}
