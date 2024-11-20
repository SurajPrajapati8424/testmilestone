// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class Logger_Example extends StatelessWidget {
  const Logger_Example({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoggerDemo(),
    );
  }
}

class LoggerDemo extends StatelessWidget {
  const LoggerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logger Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            demo();
          },
          child: const Text('Run Logger Demo'),
        ),
      ),
    );
  }

  void demo() {
    logger.d('Log message with 2 methods');
    loggerNoStack.i('Info message');
    loggerNoStack.w('Just a warning!');
    logger.e('Error! Something bad happened', error: 'Test Error');
    loggerNoStack.t({'key': 5, 'value': 'something'});
    Logger(printer: SimplePrinter(colors: true)).t('boom');
  }
}
