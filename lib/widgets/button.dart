import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';

import 'text.dart';

class Button extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color color;
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool textCenter;
  final double? fontSize;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;
  final String? stackText;
  final void Function()? onTap;
  final FontWeight? fontWeight;
  final Widget? leftWidget;
  final BoxBorder? border;
  final double? minWidth;
  final Widget? topIcon;
  final List<BoxShadow>? boxShadow;
  const Button({
    super.key,
    this.text = 'Button',
    this.textColor,
    this.stackText,
    this.color = const Color(0xFFFF981F),
    this.height,
    this.width,
    this.borderRadius,
    this.textCenter = false,
    this.fontSize,
    this.onTap,
    this.textOverflow = TextOverflow.visible,
    this.maxLines,
    this.padding,
    this.fontWeight,
    this.leftWidget,
    this.border,
    this.minWidth,
    this.topIcon,
    this.boxShadow,
  });

  Color darkenColor(Color color, [double amount = 0.087]) {
    final hsl = HSLColor.fromColor(color);
    final darkerHsl =
        hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return darkerHsl.toColor();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        constraints: BoxConstraints(
          minWidth: minWidth ?? 0,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          border: border ??
              Border(
                bottom: BorderSide(width: 5, color: darkenColor(color)),
              ),
          boxShadow: boxShadow,
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (topIcon != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: topIcon!,
                ), // Icon
              Stack(
                alignment: textCenter ? Alignment.center : Alignment.centerLeft,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      leftWidget ?? const SizedBox(height: 0, width: 0),
                      if (leftWidget != null)
                        const SizedBox(
                            width: 8), // add some space between image and text
                      TextWidget(
                        text: text,
                        color: stackText != null
                            ? Colors.transparent
                            : textColor ?? Colors.white,
                        fontSize: fontSize ?? 16,
                        fontWeight: fontWeight ?? FontWeight.w700,
                        textAlign:
                            textCenter ? TextAlign.center : TextAlign.start,
                        maxLines: maxLines,
                        textOverflow: textOverflow,
                      ),
                      if (stackText != null)
                        TextWidget(
                          text: stackText ?? '',
                          color: textColor ?? Colors.white,
                          fontSize: fontSize ?? 16,
                          fontWeight: fontWeight ?? FontWeight.w700,
                          textAlign:
                              textCenter ? TextAlign.center : TextAlign.start,
                          maxLines: maxLines,
                          textOverflow: textOverflow,
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
