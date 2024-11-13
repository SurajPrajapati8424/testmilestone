import 'package:flutter/material.dart';
import 'package:safe_text/safe_text.dart';
import 'package:testmilestone/widgets/inputfield.dart';

import '../widgets/button.dart';
import '../widgets/text.dart';

class SafetextScreen extends StatefulWidget {
  const SafetextScreen({super.key});

  @override
  State<SafetextScreen> createState() => _SafetextScreenState();
}

class _SafetextScreenState extends State<SafetextScreen> {
  String textInput = '';
  TextEditingController controller = TextEditingController();

// Method to filter out bad words from the user input
  void filterText() {
    setState(() {
      // Call the filterText method from the SafeText class
      textInput = SafeText.filterText(
        text: textInput,
        extraWords: ["extra", "bad", "words"],
        excludedWords: ["exclude", "these"],
        useDefaultWords: true,
        fullMode: true,
        obscureSymbol: '*',
      );
      controller.text = textInput;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safe Text'),
      ),
      body: Column(
        children: [
          AnswerInputWidget(
            controller: controller,
            hintText: 'Your Text Here',
            textColor: Colors.black,
            onChanged: (val) {
              setState(() {
                textInput = val;
              });
            },
            hasDivider: true,
          ),
          Button(
            text: 'filterText',
            onTap: filterText,
          ),
          const TextWidget(
            text: 'Filtered Text:',
            color: Colors.red,
          ),
          TextWidget(
            text: textInput,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
