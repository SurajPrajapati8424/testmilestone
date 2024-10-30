import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testmilestone/widgets/text.dart';
import 'package:word_cloud/word_cloud.dart';

class Wordcloud extends StatelessWidget {
  const Wordcloud({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> data = [
      'Apple',
      'Samsung',
      'Flutter',
      'Dart',
      'Provider',
      'Bloc',
      'ITC',
      'Adani',
      'Hindalco',
      'Nalco',
      'Metro',
      'NTPC',
    ];
    List<Color> colorList = [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const TextWidget(text: 'Word Cloud'),
      ),
      body: CustomWordCloud(
        data: data,
        colorlist: colorList,
        onWordTap: (word) {
          debugPrint('->$word');
        },
      ),
    );
  }
}

class CustomWordCloud extends StatefulWidget {
  final List<String> data;
  final List<Color> colorlist;
  final Function(String) onWordTap;
  const CustomWordCloud(
      {super.key,
      required this.data,
      required this.colorlist,
      required this.onWordTap});

  @override
  State<CustomWordCloud> createState() => _CustomWordCloudState();
}

class _CustomWordCloudState extends State<CustomWordCloud> {
  late WordCloudData myData;
  late WordCloudTap wordtaps;

  @override
  void initState() {
    super.initState();
    initWordCloud();
  }

  void initWordCloud() {
    // Ensure the data list is not empty
    if (widget.data.isEmpty) {
      debugPrint("Data list is empty. Word cloud cannot be generated.");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Remove Duplicate + generate Random values [35-45]
    final Set<String> uniqueWords = widget.data.toSet();
    final Random random = Random();
    List<Map<dynamic, dynamic>> dataList = uniqueWords.map((word) {
      return {
        'word': word,
        'value': random.nextInt(45 - 20 + 1) + 20,
      };
    }).toList();
    debugPrint('$dataList');
    // Initialize WordCloudData and WordCloudTap
    myData = WordCloudData(data: dataList);
    wordtaps = WordCloudTap();

    //WordCloudTap functionality
    for (var wordData in dataList) {
      String word = wordData['word'];
      wordtaps.addWordtap(word, () {
        widget.onWordTap(word); // Call the onWordTap callback
      });
    }
    // for (int i = 0; i < dataList.length; i++) {
    //   void tap() {
    //     widget.onWordTap('${dataList[i]['word']} $i');
    //   }

    //   wordtaps.addWordtap(dataList[i]['word'], tap);
    // }

    return WordCloudTapView(
      data: myData,
      wordtap: wordtaps,
      mapwidth: 350.w,
      mapheight: 500.w,
      colorlist:
          widget.colorlist.isNotEmpty ? widget.colorlist : [Colors.black],
      fontWeight: FontWeight.w700,
    );
  }
}
