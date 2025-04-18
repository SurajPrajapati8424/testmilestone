import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:focus_on_it/focus_on_it.dart';
import 'package:logger/logger.dart';

class Focus_Widget_Example extends StatelessWidget {
  const Focus_Widget_Example({super.key});

  @override
  Widget build(BuildContext context) => FocusOnIt(
        onFocus: () {
          /// Equivalent to `onResume()` on Android and `viewDidAppear()` on iOS.
          /// Triggered when the widget is focused after route transition or the widget resumed from a paused state.
          logger.i('Focus Gained.');
        },
        onUnfocus: () {
          /// Equivalent to `onPause()` on Android and `viewDidDisappear()` on iOS.
          /// Triggered when the widget is unfocused after route transition or the widget paused from a focused state.
          logger.i('Focus Lost.');
        },
        onForegroundGained: () {
          /// Triggered when the app is resumed from a paused state.
          logger.i('Foreground Gained.');
        },
        onForegroundLost: () {
          /// Triggered when the app is paused from a resumed state.
          logger.i('Foreground Lost.');
        },
        onVisibilityGained: () {
          /// Triggered when the widget is visible after route transition.
          logger.i('Visibility Gained.');
        },
        onVisibilityLost: () {
          /// Triggered when the widget is no longer visible after route transition.
          logger.i('Visibility Lost.');
        },
        onDetach: () {
          /// Triggered when the widget is detached from the widget tree.
          logger.i('Detach.');
        },
        onExitRequested: () async {
          /// Triggered when the app is requested to exit.
          logger.i('Exit Requested.');
          return AppExitResponse.exit;
        },
        onHide: () {
          /// Triggered when the app is hidden.
          logger.i('Hide.');
        },
        onInactive: () {
          /// Triggered when the app is inactive.
          logger.i('Inactive.');
        },
        onRestart: () {
          /// Triggered when the app is restarted.
          logger.i('Restart.');
        },
        onShow: () {
          /// Triggered when the app is shown.
          logger.i('Show.');
        },
        onStateChange: (oldState, newState) {
          /// Triggered when the app state changes.
          logger.i('State Change: $oldState -> $newState');
        },
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Send the app to the background or push another page and '
                  'watch the console.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    final route = MaterialPageRoute<void>(
                      builder: (_) => const TestPage(),
                    );
                    Navigator.of(context).push<void>(route);
                  },
                  child: const Text(
                    'PUSH ANOTHER PAGE',
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Look at the console and return to the first screen.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
}

Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    printTime: false,
  ),
);

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Focus_Widget_Example(),
    ),
  );
}
