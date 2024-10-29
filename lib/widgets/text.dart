import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final bool? softWrap;
  @override
  const TextWidget({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.textAlign = TextAlign.start,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.textOverflow,
    this.maxLines,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      style: GoogleFonts.nunito(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      ),
    );
  }
}
