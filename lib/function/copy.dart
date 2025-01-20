import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testmilestone/screens/slidetoastscreen.dart';

class CopyText {
  final String text;
  final BuildContext contexts;
  CopyText({required this.text, required this.contexts}) {
    Clipboard.setData(ClipboardData(text: text));
    slideToast(
        context: contexts,
        text: 'Copied to clipboard!\n$text',
        onTapped: () {},
        onDisposed: () {});
    // ToastWidget(context: contexts, message: );
  }
}
