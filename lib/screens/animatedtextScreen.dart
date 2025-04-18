import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedTextScreen extends StatefulWidget {
  const AnimatedTextScreen({super.key});

  @override
  AnimatedTextScreenState createState() => AnimatedTextScreenState();
}

class AnimatedTextScreenState extends State<AnimatedTextScreen> {
  late List<AnimatedTextExample> _examples;
  int _index = 0;
  int _tapCount = 0;

  @override
  void initState() {
    super.initState();
    _examples = animatedTextExamples(onTap: () {
      print('Tap Event');
      setState(() {
        _tapCount++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final animatedTextExample = _examples[_index];
    // test
    void onTap() {}
    TextStyle customTextStyle =
        GoogleFonts.nunito(fontSize: 50.0, color: Colors.black);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          animatedTextExample.label,
          style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          // 1
          Container(
            decoration: const BoxDecoration(color: Colors.grey),
            height: 300.0,
            width: 300.0,
            child: Center(
              child: AnimatedTextKit(
                // onTap: onTap,
                animatedTexts: [
                  WavyAnimatedText('On Your Marks', textStyle: customTextStyle),
                  FadeAnimatedText('Get Set', textStyle: customTextStyle),
                  ScaleAnimatedText('Ready', textStyle: customTextStyle),
                  RotateAnimatedText(
                    'Go!',
                    textStyle: customTextStyle,
                    rotateOut: false,
                    duration: const Duration(milliseconds: 400),
                  )
                ],
              ),
            ),
          ),
          // 1
          // 2
          Container(
            decoration: const BoxDecoration(color: Colors.lightGreen),
            height: 300.0,
            width: 300.0,
            child: Center(
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      blurRadius: 7.0,
                      color: Colors.black,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FlickerAnimatedText('Flicker Frenzy'),
                    FlickerAnimatedText('Night Vibes On'),
                    FlickerAnimatedText("C'est La Vie !"),
                  ],
                  // onTap: onTap,
                ),
              ),
            ),
          ),
          // 2
          // 3
          Container(
            decoration: const BoxDecoration(color: Colors.grey),
            height: 300.0,
            width: 300.0,
            child: Center(
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      'Hello World',
                      textStyle: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    WavyAnimatedText(
                      'Look at the waves',
                      textStyle: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    WavyAnimatedText(
                      'They look so Amazing',
                      textStyle: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                  ],
                  onTap: onTap,
                ),
              ),
            ),
          ),
          // 3
          // 4
          Container(
            decoration: const BoxDecoration(color: Colors.greenAccent),
            height: 300.0,
            width: 300.0,
            child: TextLiquidFill(
              text: 'LIQUIDY',
              waveColor: Colors.blueAccent,
              boxBackgroundColor: Colors.redAccent,
              textStyle: const TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
              boxHeight: 300,
            ),
          ),
          // 4
          // 5
          Container(
            decoration: const BoxDecoration(color: Colors.grey),
            height: 300.0,
            width: 300.0,
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Larry Page',
                  textStyle: _colorizeTextStyle,
                  colors: _colorizeColors,
                ),
                ColorizeAnimatedText(
                  'Bill Gates',
                  textStyle: _colorizeTextStyle,
                  colors: _colorizeColors,
                ),
                ColorizeAnimatedText(
                  'Steve Jobs',
                  textStyle: _colorizeTextStyle,
                  colors: _colorizeColors,
                ),
              ],
              onTap: onTap,
            ),
          ),
          // 5
          // 6
          Container(
            decoration: const BoxDecoration(color: Colors.greenAccent),
            height: 300.0,
            width: 300.0,
            child: Center(
              child: DefaultTextStyle(
                style: customTextStyle,
                child: AnimatedTextKit(
                  animatedTexts: [
                    ScaleAnimatedText('Think', textStyle: customTextStyle),
                    ScaleAnimatedText('Build', textStyle: customTextStyle),
                    ScaleAnimatedText('Ship', textStyle: customTextStyle),
                  ],
                  onTap: onTap,
                ),
              ),
            ),
          ),
          // 6
          // 7
          Container(
            decoration: const BoxDecoration(color: Colors.grey),
            height: 300.0,
            width: 300.0,
            child: Center(
              child: SizedBox(
                width: 250.0,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Agne',
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Discipline is the best tool'),
                      TypewriterAnimatedText('Design first, then code',
                          cursor: '|'),
                      TypewriterAnimatedText(
                          'Do not patch bugs out, rewrite them',
                          cursor: '<|>'),
                      TypewriterAnimatedText(
                          'Do not test bugs out, design them out',
                          cursor: '💡'),
                    ],
                    onTap: onTap,
                  ),
                ),
              ),
            ),
          ),
          // 7
          // 8
          Container(
            decoration: const BoxDecoration(color: Colors.greenAccent),
            height: 300.0,
            width: 300.0,
            child: Center(
              child: SizedBox(
                width: 250.0,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Bobbers',
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('It is not enough to do your best,'),
                      TyperAnimatedText('you must know what to do,'),
                      TyperAnimatedText('and then do your best'),
                      TyperAnimatedText('- W.Edwards Deming'),
                    ],
                    onTap: onTap,
                  ),
                ),
              ),
            ),
          ),
          // 8
          // 9
          Container(
            decoration: const BoxDecoration(color: Colors.grey),
            height: 300.0,
            width: 300.0,
            child: Center(
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText('do IT!'),
                    FadeAnimatedText('do it RIGHT!!'),
                    FadeAnimatedText('do it RIGHT NOW!!!'),
                  ],
                  onTap: onTap,
                ),
              ),
            ),
          ),
          // 9
          // 10
          // Container(
          //   decoration: const BoxDecoration(color: Colors.greenAccent),
          //   // height: 300.0,
          //   // width: 300.0,
          //   child: Center(
          //     child: ListView(
          //       scrollDirection: Axis.horizontal,
          //       children: <Widget>[
          //         Row(
          //           mainAxisSize: MainAxisSize.min,
          //           children: <Widget>[
          //             const SizedBox(
          //               width: 20.0,
          //               height: 100.0,
          //             ),
          //             const Text(
          //               'Be',
          //               style: TextStyle(fontSize: 43.0),
          //             ),
          //             const SizedBox(
          //               width: 20.0,
          //               height: 100.0,
          //             ),
          //             DefaultTextStyle(
          //               style: const TextStyle(
          //                 fontSize: 40.0,
          //                 fontFamily: 'Horizon',
          //               ),
          //               child: AnimatedTextKit(
          //                 animatedTexts: [
          //                   RotateAnimatedText('AWESOME'),
          //                   RotateAnimatedText('OPTIMISTIC'),
          //                   RotateAnimatedText(
          //                     'DIFFERENT',
          //                     textStyle: const TextStyle(
          //                       decoration: TextDecoration.underline,
          //                     ),
          //                   ),
          //                 ],
          //                 onTap: onTap,
          //                 isRepeatingAnimation: true,
          //                 totalRepeatCount: 10,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // 10

          // Expanded(
          //   child: Container(),
          // ),
          // Container(
          //   decoration: BoxDecoration(color: animatedTextExample.color),
          //   height: 300.0,
          //   width: 300.0,
          //   child: Center(
          //     key: ValueKey(animatedTextExample.label),
          //     child: animatedTextExample.child,
          //   ),
          // ),
          // Expanded(
          //   child: Container(
          //     alignment: Alignment.center,
          //     child: Text('Taps: $_tapCount'),
          //   ),
          // ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _index = ++_index % _examples.length;
            _tapCount = 0;
          });
        },
        tooltip: 'Next',
        child: const Icon(
          Icons.play_circle_filled,
          size: 50.0,
        ),
      ),
    );
  }
}

class AnimatedTextExample {
  final String label;
  final Color? color;
  final Widget child;

  const AnimatedTextExample({
    required this.label,
    required this.color,
    required this.child,
  });
}

// Colorize Text Style
const _colorizeTextStyle = TextStyle(
  fontSize: 50.0,
  fontFamily: 'Horizon',
);

// Colorize Colors
const _colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

List<AnimatedTextExample> animatedTextExamples({VoidCallback? onTap}) =>
    <AnimatedTextExample>[
      // 10
      AnimatedTextExample(
        label: 'Rotate',
        color: Colors.orange[800],
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  width: 20.0,
                  height: 100.0,
                ),
                const Text(
                  'Be',
                  style: TextStyle(fontSize: 43.0),
                ),
                const SizedBox(
                  width: 20.0,
                  height: 100.0,
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Horizon',
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('AWESOME'),
                      RotateAnimatedText('OPTIMISTIC'),
                      RotateAnimatedText(
                        'DIFFERENT',
                        textStyle: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                    onTap: onTap,
                    isRepeatingAnimation: true,
                    totalRepeatCount: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // 10
      // 9
      AnimatedTextExample(
        label: 'Fade',
        color: Colors.brown[600],
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText('do IT!'),
              FadeAnimatedText('do it RIGHT!!'),
              FadeAnimatedText('do it RIGHT NOW!!!'),
            ],
            onTap: onTap,
          ),
        ),
      ),
      // 9
      // 8
      AnimatedTextExample(
        label: 'Typer',
        color: Colors.lightGreen[800],
        child: SizedBox(
          width: 250.0,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 30.0,
              fontFamily: 'Bobbers',
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText('It is not enough to do your best,'),
                TyperAnimatedText('you must know what to do,'),
                TyperAnimatedText('and then do your best'),
                TyperAnimatedText('- W.Edwards Deming'),
              ],
              onTap: onTap,
            ),
          ),
        ),
      ),
      // 8
      // 7
      AnimatedTextExample(
        label: 'Typewriter',
        color: Colors.teal[700],
        child: SizedBox(
          width: 250.0,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 30.0,
              fontFamily: 'Agne',
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('Discipline is the best tool'),
                TypewriterAnimatedText('Design first, then code', cursor: '|'),
                TypewriterAnimatedText('Do not patch bugs out, rewrite them',
                    cursor: '<|>'),
                TypewriterAnimatedText('Do not test bugs out, design them out',
                    cursor: '💡'),
              ],
              onTap: onTap,
            ),
          ),
        ),
      ),
      // 7
      // 6
      AnimatedTextExample(
        label: 'Scale',
        color: Colors.blue[700],
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 70.0,
            fontFamily: 'Canterbury',
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              ScaleAnimatedText('Think'),
              ScaleAnimatedText('Build'),
              ScaleAnimatedText('Ship'),
            ],
            onTap: onTap,
          ),
        ),
      ),
      // 6
      // 5
      AnimatedTextExample(
        label: 'Colorize',
        color: Colors.blueGrey[50],
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'Larry Page',
              textStyle: _colorizeTextStyle,
              colors: _colorizeColors,
            ),
            ColorizeAnimatedText(
              'Bill Gates',
              textStyle: _colorizeTextStyle,
              colors: _colorizeColors,
            ),
            ColorizeAnimatedText(
              'Steve Jobs',
              textStyle: _colorizeTextStyle,
              colors: _colorizeColors,
            ),
          ],
          onTap: onTap,
        ),
      ),
      // 5
      // 4
      AnimatedTextExample(
        label: 'TextLiquidFill',
        color: Colors.white,
        child: TextLiquidFill(
          text: 'LIQUIDY',
          waveColor: Colors.blueAccent,
          boxBackgroundColor: Colors.redAccent,
          textStyle: const TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.bold,
          ),
          boxHeight: 300,
        ),
      ),
      // 4
      // 3
      AnimatedTextExample(
        label: 'Wavy Text',
        color: Colors.purple,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 20.0,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(
                'Hello World',
                textStyle: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              WavyAnimatedText('Look at the waves'),
              WavyAnimatedText('They look so Amazing'),
            ],
            onTap: onTap,
          ),
        ),
      ),
      // 3
      // 2
      AnimatedTextExample(
        label: 'Flicker',
        color: Colors.pink[300],
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 35,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 7.0,
                color: Colors.white,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText('Flicker Frenzy'),
              FlickerAnimatedText('Night Vibes On'),
              FlickerAnimatedText("C'est La Vie !"),
            ],
            onTap: onTap,
          ),
        ),
      ),
      // 2
      // 1
      AnimatedTextExample(
        label: 'Combination',
        color: Colors.pink,
        child: AnimatedTextKit(
          onTap: onTap,
          animatedTexts: [
            WavyAnimatedText(
              'On Your Marks',
              textStyle: const TextStyle(
                fontSize: 24.0,
              ),
            ),
            FadeAnimatedText(
              'Get Set',
              textStyle: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ScaleAnimatedText(
              'Ready',
              textStyle: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            RotateAnimatedText(
              'Go!',
              textStyle: const TextStyle(
                fontSize: 64.0,
              ),
              rotateOut: false,
              duration: const Duration(milliseconds: 400),
            )
          ],
        ),
      ),
      // 1
    ];
