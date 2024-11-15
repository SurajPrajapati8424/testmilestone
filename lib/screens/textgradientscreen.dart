import 'package:flutter/material.dart';
import 'package:text_gradiate/text_gradiate.dart';

import '../widgets/text.dart';

class TextGradientScreen extends StatelessWidget {
  const TextGradientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextGradiate Example'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextGradiate(
              text: TextWidget(
                text: 'AQ Quiz Gradient',
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
              colors: [Colors.deepPurple, Colors.redAccent],
            ),
            SizedBox(height: 20),
            TextGradiate(
              text: TextWidget(
                  text: 'Hello, Gradient!',
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900),
              colors: [Colors.deepOrange, Colors.green],
              gradientType: GradientType.linear,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              tileMode: TileMode.clamp,
            ),
            SizedBox(height: 20),
            TextGradiate(
              text: TextWidget(
                  text: 'Flutter is awesome!',
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900),
              colors: [Colors.red, Colors.indigo],
              gradientType: GradientType.sweep,
              center: Alignment.centerLeft,
            ),
          ],
        ),
      ),
    );
  }
}

/*
text:                                     The child widget to which the gradient effect will be applied.
colors:                                   The list of colors to use for the gradient.
gradientType:                             Specifies the type of gradient (linear, radial, or sweep).
begin (for linear gradients):             The starting point of the gradient.
end (for linear gradients):               The ending point of the gradient.
tileMode (for linear gradients):          The tiling strategy for the gradient.
center (for radial and sweep gradients):  The center point of the gradient.
focal (for radial gradients):             The focal point of the gradient.
focalRadius (for radial gradients):       The focal radius of the gradient.
startAngle (for sweep gradients):         The starting angle of the gradient.
endAngle (for sweep gradients):           The ending angle of the gradient.
stops:                                    The stops of the gradient.
transform:                                The transform matrix for the gradient (applicable only for linear and sweep gradients).

*/