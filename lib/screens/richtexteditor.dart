import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

enum QuillOutputType { json, text }

class QuillOutput {
  final QuillOutputType type;
  final String data;
  QuillOutput.fromJson(List<Map<String, dynamic>> json)
      : type = QuillOutputType.json,
        data = jsonEncode(json);
  QuillOutput.fromText(String text)
      : type = QuillOutputType.text,
        data = text;
  List<Map<String, dynamic>> get jsonData => jsonDecode(data);
  String get textData => data;
}

class WordDoc extends StatefulWidget {
  const WordDoc({super.key});
  @override
  State<WordDoc> createState() => _WordDocState();
}

class _WordDocState extends State<WordDoc> {
  late QuillController _controller;
  final FocusNode _focusNode = FocusNode();

  String? textData;
  String? jsonData;

  @override
  void initState() {
    _controller = QuillController.basic();
//     List<dynamic> preview = jsonDecode('''
// [{"insert":"Hi there\\n","attributes":{"bold":true}},{"insert":{"image":"https://m.media-amazon.com/images/I/71Tfszeu0DL._SX3000_.jpg"}},{"insert":"\\n","attributes":{"bold":true}},{"insert":"https://m.media-amazon.com/images/I/71Tfszeu0DL._SX3000_.jpg\\n"},{"insert":{"image":"https://m.media-amazon.com/images/I/71Tfszeu0DL._SX3000_.jpg"}},{"insert":"\\n\\n"}]
// '''
//         .trim());
//     _controller.document = Document.fromJson(preview);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('WordDoc')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('on text $textData');
          debugPrint('on json $jsonData');
          debugPrint('on decode ${jsonDecode(jsonData!)}');
        },
        child: const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            QuillToolbarWidget(
              controller: _controller,
              initialData:
                  '[{"insert":"Hi there\\n","attributes":{"bold":true}},{"insert":{"image":"https://m.media-amazon.com/images/I/71Tfszeu0DL._SX3000_.jpg"}},{"insert":"\\n","attributes":{"bold":true}},{"insert":"https://m.media-amazon.com/images/I/71Tfszeu0DL._SX3000_.jpg\\n"},{"insert":{"image":"https://m.media-amazon.com/images/I/71Tfszeu0DL._SX3000_.jpg"}},{"insert":"\\n\\n"}]',
            ),
            QuillEditorWidget(
              controller: _controller,
              focusNode: _focusNode,
              onChange: (plainText, delta) {
                setState(() {
                  textData = plainText;
                  jsonData = delta;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

class QuillToolbarWidget extends StatefulWidget {
  final QuillController controller;
  final String? initialData;
  const QuillToolbarWidget(
      {super.key, required this.controller, this.initialData});
  @override
  State<QuillToolbarWidget> createState() => _QuillToolbarWidgetState();
}

class _QuillToolbarWidgetState extends State<QuillToolbarWidget> {
  @override
  initState() {
    List<dynamic> preview = jsonDecode(widget.initialData!.trim());
    widget.controller.document = Document.fromJson(preview);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return QuillToolbar.simple(
      controller: widget.controller,
      configurations: QuillSimpleToolbarConfigurations(
        embedButtons: FlutterQuillEmbeds.toolbarButtons(),
        color: Colors.grey.shade300,
        dialogTheme: const QuillDialogTheme(),
        showLink: true,
        multiRowsDisplay: true,
        showFontFamily: false,
        showFontSize: false,
        showSmallButton: false,
        showStrikeThrough: false,
        showInlineCode: false,
        showColorButton: false,
        showBackgroundColorButton: false,
        showClearFormat: false,
        showAlignmentButtons: false,
        showLeftAlignment: false,
        showCenterAlignment: false,
        showRightAlignment: false,
        showJustifyAlignment: false,
        showHeaderStyle: false,
        showListNumbers: false,
        showListBullets: false,
        showListCheck: false,
        showCodeBlock: false,
        showQuote: false,
        showIndent: false,
        showUnderLineButton: true,
        showDividers: false,
        showDirection: false,
        showSuperscript: false,
        showSubscript: false,
        showLineHeightButton: false,
        showSearchButton: false,
      ),
    );
  }
}

class QuillEditorWidget extends StatelessWidget {
  final QuillController controller;
  final FocusNode focusNode;
  final Function(String, String) onChange;

  const QuillEditorWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      final String plainText = controller.document.toPlainText();
      final String delta = jsonEncode(controller.document.toDelta().toJson());
      onChange(plainText, delta);
    });
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: QuillEditor(
        controller: controller,
        focusNode: focusNode,
        scrollController: ScrollController(),
        configurations: QuillEditorConfigurations(
          embedBuilders: FlutterQuillEmbeds.editorBuilders(),
          placeholder: 'Type here...',
        ),
      ),
    );
  }
}

/*
floatingActionButton: FloatingActionButton(
  onPressed: () {
    debugPrint('_controller.document.toDelta().toJson()');
    debugPrint(jsonEncode(_controller.document.toDelta().toJson()));
    debugPrint('_controller.document.toDelta().toJson()');
    debugPrint("'SAVE index ->plainText'");
    String plainText = '';
    plainText = _controller.document.toPlainText();
    debugPrint(plainText);
    debugPrint("'SAVE index ->plainText'");
  },
  child: const Icon(Icons.save),
),
*/