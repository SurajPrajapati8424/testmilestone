import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../widgets/divider.dart';
import '../widgets/inputfield.dart';

class MarkdownScreen extends StatefulWidget {
  const MarkdownScreen({super.key});

  @override
  MarkdownScreenState createState() => MarkdownScreenState();
}

class MarkdownScreenState extends State<MarkdownScreen> {
  // Controller for the Markdown input
  final TextEditingController _controller = TextEditingController();

  // Default Markdown content
  String _markdownText = '''
Normal Text
# Heading 1
## Heading 2
### Heading 3
*bold*
italic
~this is mistake~ XY<sup>2</sup>
dart
class Test extends Stateless widget{
void trickMe(){}
}

* wassup
* cap or no cap
- using:[GitHub Pages] (https://pages.github.com/). 
## My great Heading {#heading-id}
1. Hello
    - Hola Amigo
      - *Previat*
2. Wassup

@cocoxy :1: 

- [x] Option 1
- [x] Option 2
- [ ] Option 3
- https://www.example.com
- my code 
{my code block}
- image
[![cat image alt](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXJA32WU4rBpx7maglqeEtt3ot1tPIRWptxA&s)]
''';

  @override
  void initState() {
    super.initState();
    _controller.text = _markdownText;
    _controller.addListener(_updateMarkdown);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateMarkdown);
    _controller.dispose();
    super.dispose();
  }

  // Update the Markdown text when the input changes
  void _updateMarkdown() {
    setState(() {
      _markdownText = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Markdown Editor'),
      ),
      body: Column(
        children: [
          // Markdown input field
          Container(
            height: 150,
            color: Colors.grey.shade300,
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: AnswerInputWidget(
                controller: _controller,
                maxLines: null, // Allow multiple lines
                isCenter: false,
                hintText: 'Enter Markdown',
                textColor: Colors.black,
                keyboardType: TextInputType.multiline,
                hasDivider: false,
                onChanged: (val) {
                  debugPrint(val);
                },
              ),
            ),
          ),
          // Divider
          const DividerWidget(thickness: 2, color: Color(0xFF00C85C)),
          // Rendered Markdown preview
          Expanded(
            child: Markdown(
              data: _markdownText,
              padding: const EdgeInsets.all(8.0),
              // extensionSet: ExtensionSet(),
              selectable: true,
              onTapLink: (text, href, title) {
                debugPrint('Link tapped: $href');
              },
            ),
          ),
        ],
      ),
    );
  }
}
