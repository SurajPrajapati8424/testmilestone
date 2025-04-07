import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testmilestone/widgets/themeWidget.dart';

class DividerWidget extends StatelessWidget {
  final Color? color;
  final double? thickness;
  final EdgeInsetsGeometry? padding;
  final double? indent;
  final double? endIndent;
  final double? height;
  const DividerWidget({
    super.key,
    this.color,
    this.thickness,
    this.height,
    this.padding,
    this.indent,
    this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    return AppThemeWidget(
      builder: (context, colorTheme, constTheme, changeTheme, isDark) =>
          Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Divider(
          color: isDark
              ? constTheme.Color.dividerColorD
              : constTheme.Color.dividerColorL,
          thickness: thickness ?? 0.8.w,
          indent: indent ?? 0.0.w,
          endIndent: endIndent ?? 0.0.w,
          height: height ?? 0.0.w,
        ),
      ),
    );
  }
}
