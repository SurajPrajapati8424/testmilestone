import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class TimepickerScreen extends StatefulWidget {
  const TimepickerScreen({super.key});

  @override
  State<TimepickerScreen> createState() => _TimepickerScreenState();
}

class _TimepickerScreenState extends State<TimepickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Timepicker Screen'),
      ),
      body: Center(
        child: TimePickerSpinnerPopUp(
          mode: CupertinoDatePickerMode.time,
          initTime: DateTime.now(),
          minTime: DateTime.now().subtract(const Duration(days: 10)),
          maxTime: DateTime.now().add(const Duration(days: 10)),
          barrierColor: Colors.black12, //Barrier Color when pop up show
          minuteInterval: 1,
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          cancelText: 'Cancel',
          confirmText: 'OK',
          enable: true,
          use24hFormat: false,
          radius: 10,
          pressType: PressType.singlePress,
          timeFormat: 'dd/MM/yyyy',
          // Customize your time widget
          // timeWidgetBuilder: (dateTime) {},
          locale: const Locale('en'),
          onChange: (dateTime) {
            // Implement your logic with select dateTime
            debugPrint('$dateTime');
          },
        ),
      ),
    );
  }
}
