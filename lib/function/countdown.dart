import 'package:flutter/material.dart';

import 'package:animated_countdown/animated_countdown.dart';

class CountDownPage extends StatefulWidget {
  const CountDownPage({super.key});

  @override
  State<CountDownPage> createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage> {
  bool _displayCountDown = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Countdown')),
      body: Stack(
        children: [
          if (_displayCountDown)
            Positioned.fill(
              child: Center(
                child: CountDownWidget(
                  totalDuration: 3,
                  maxTextSize: 100,
                  onEnd: () {
                    setState(() {
                      _displayCountDown = false;
                    });
                  },
                  textStyle: const TextStyle(color: Colors.black),
                ),
              ),
            )
        ],
      ),
      floatingActionButton: _displayCountDown
          ? null
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  _displayCountDown = true;
                });
              },
              tooltip: 'Start',
              child: const Icon(Icons.play_arrow_rounded),
            ),
    );
  }
}
