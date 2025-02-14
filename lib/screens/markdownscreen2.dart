import 'package:flutter/material.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart' as mdeditor;

class MarkdownScreenTwo extends StatefulWidget {
  const MarkdownScreenTwo({super.key});

  @override
  State<MarkdownScreenTwo> createState() => MarkdownScreenTwoState();
}

class MarkdownScreenTwoState extends State<MarkdownScreenTwo>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  TextEditingController? textController;
  String? markdownText;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    textController = TextEditingController();
    markdownText = "";
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
    textController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
          bottom: TabBar(
            controller: tabController,
            tabs: const [
              Tab(
                text: "Editor",
              ),
              Tab(
                text: "Previw",
              ),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(controller: tabController, children: [
          //editor tab
          mdeditor.MarkdownAutoPreview(
            controller: textController,
            hintText: 'Start Editing Here',
            enableToolBar: true,
            emojiConvert: true,
            autoCloseAfterSelectEmoji: false,
            toolbarBackground: const Color(0xFF00C85C).withOpacity(0.1),
            onChanged: (String text) {
              setState(() {
                markdownText = text;
              });
            },
          ),
          // preview tab
          mdeditor.MarkdownParse(
            data: markdownText ?? "#Your Heading",
            selectable: true,
          )
        ]));
  }
}
