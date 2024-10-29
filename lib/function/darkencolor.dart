import 'package:flutter/material.dart';

Color darkenColor(Color color, [double amount = 0.087]) {
  final hsl = HSLColor.fromColor(color);
  final darkerHsl = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return darkerHsl.toColor();
}

Color lightenColor(Color color, [double amount = 0.087]) {
  final hsl = HSLColor.fromColor(color);
  final lighterHsl =
      hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
  return lighterHsl.toColor();
}
