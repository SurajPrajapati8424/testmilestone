import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:google_fonts/google_fonts.dart';

class ReadOnlyWordDoc extends StatelessWidget {
  const ReadOnlyWordDoc({super.key});

  @override
  Widget build(BuildContext context) {
    String deltaJson =
        '''[{"insert":"Hi there\\n","attributes":{"size": "large"}},
        {"insert":{"image":"https://m.media-amazon.com/images/I/71Tfszeu0DL._SX3000_.jpg"},"attributes":{"width":250}},
        {"insert":"\\n"},
        {"insert":"https://m.media-amazon.com/images/I/71Tfszeu0DL._SX3000_.jpg"},
        {"insert":"\\n"},
        {"insert":{"image":"https://m.media-amazon.com/images/I/71Tfszeu0DL._SX3000_.jpg"}},
        {"insert":"\\n\\n"}]''';

    return Scaffold(
      appBar: AppBar(title: const Text('Quill Read only')),
      body: Quill_text_only(
        deltaJson: deltaJson,
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}

// ignore: camel_case_types
class Quill_text_only extends StatelessWidget {
  final String deltaJson;
  final EdgeInsetsGeometry? padding;
  const Quill_text_only({super.key, required this.deltaJson, this.padding});

  @override
  Widget build(BuildContext context) {
    QuillController controller = QuillController.basic();
    controller.document = Document.fromJson(jsonDecode(deltaJson));
    final FocusNode focusNode = FocusNode();
    return QuillEditor(
      controller: controller,
      focusNode: focusNode,
      scrollController: ScrollController(),
      configurations: QuillEditorConfigurations(
          embedBuilders: FlutterQuillEmbeds.editorBuilders(),
          autoFocus: false,
          expands: false,
          padding: padding ?? EdgeInsets.zero,
          showCursor: false,
          scrollable: true,
          requestKeyboardFocusOnCheckListChanged: false,
          enableInteractiveSelection: false, // Disable interaction
          customStyles: DefaultStyles(
            paragraph: DefaultTextBlockStyle(
                GoogleFonts.nunito(fontSize: 18, color: Colors.black),
                const HorizontalSpacing(0, 0),
                const VerticalSpacing(0, 0),
                const VerticalSpacing(0, 0),
                null),
            sizeLarge: const TextStyle(
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.w700,
            ),
          )),
    );
  }
}
