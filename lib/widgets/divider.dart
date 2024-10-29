import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final Color color;
  final double thickness;
  final EdgeInsetsGeometry padding;
  final double indent;
  final double endIndent;
  final double height;
  const DividerWidget({
    super.key,
    this.color = const Color.fromARGB(255, 217, 216, 217),
    this.thickness = 0.5,
    this.height = 0.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 15.0),
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Divider(
        color: color,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        height: height,
      ),
    );
  }
}
