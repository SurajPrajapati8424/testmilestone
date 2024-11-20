import 'package:flutter/material.dart';
import 'package:starsview/starsview.dart';

class StarsViewExample extends StatelessWidget {
  const StarsViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
                Colors.red,
                Colors.blue,
              ],
            ))),
            const StarsView(
              fps: 25, // default -> 60
            )
          ],
        ),
      ),
    );
  }
}
