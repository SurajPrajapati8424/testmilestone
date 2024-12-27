import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/text.dart';

/**
 * This is a simple example of how to implement a theme toggle in your app.
 * Changes in runApp() method.
 runApp(
    ChangeNotifierProvider(
      create: (context) => AppThemeNotifier(),
      child: const ScreenUtilInit(
        designSize: Size(360, 752),
        child: BetterFeedback(
          child: TestScreen(),
        ),
      ),
    ),
  );
}
 */
class AppColors {
  // Brand Colors
  static Color primary = const Color(0xFF00C85C);
  static Color secondary = const Color(0xFF00BFA5);
  static Color accent = Colors.greenAccent;

  // Neutral Colors
  static Color black = const Color(0xFF2A2A2A);
  static Color white = const Color(0xFFFFFFFF);
  static Color grey = const Color(0xFF9E9E9E);
  static Color darkGrey = const Color(0xFF424242);
  static Color lightGrey = const Color(0xFFE0E0E0);

  // Semantic Colors
  static Color success = const Color(0xFF4CAF50);
  static Color error = const Color(0xFFD32F2F);
  static Color warning = const Color(0xFFFFA000);
  static Color info = const Color(0xFF1976D2);

  // Background Colors
  static Color background = const Color(0xFFFAFAFA);
  static Color surface = const Color(0xFFFFFFFF);
}

class AppTextStyles {
  // Display Styles
  static TextStyle display1 = TextStyle(
    fontSize: 48.w,
    fontWeight: FontWeight.bold,
  );

  static TextStyle display2 = TextStyle(
    fontSize: 40.w,
    fontWeight: FontWeight.w600,
  );

  // Heading Styles
  static TextStyle h1 = TextStyle(
    fontSize: 32.w,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 24.w,
    fontWeight: FontWeight.w600,
  );

  static TextStyle h3 = TextStyle(
    fontSize: 20.w,
    fontWeight: FontWeight.w600,
  );
  // Body Styles
  static TextStyle bodyLarge = GoogleFonts.nunito(
    fontSize: 16.w,
    fontWeight: FontWeight.w700,
  );

  static TextStyle bodyMedium = GoogleFonts.nunito(
    fontSize: 14.w,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bodySmall = GoogleFonts.nunito(
    fontSize: 12.w,
    fontWeight: FontWeight.normal,
  );

  // Button Text Styles
  static TextStyle button = GoogleFonts.nunito(
    fontSize: 14.w,
    fontWeight: FontWeight.w500,
  );

  // Caption and Overline
  static TextStyle caption = GoogleFonts.nunito(
    fontSize: 12.w,
    fontWeight: FontWeight.normal,
  );

  static TextStyle overline = GoogleFonts.nunito(
    fontSize: 10.w,
    fontWeight: FontWeight.normal,
  );
}

class AppSpacing {
  // Padding and Margin
  static double xs = 4.0.w;
  static double small = 8.0.w;
  static double medium = 16.0.w;
  static double large = 24.0.w;
  static double xl = 32.0.w;
  static double xxl = 48.0.w;

  // Button Sizes
  static double buttonHeight = 55.0.w;
  static double buttonSmallHeight = 36.0.w;
  static double buttonLargeHeight = 56.0.w;

  // Icon Sizes
  static double iconSmall = 16.0.w;
  static double iconMedium = 24.0.w;
  static double iconLarge = 32.0.w;

  // Border Radius
  static double radiusSmall = 4.0.w;
  static double radiusMedium = 8.0.w;
  static double radiusLarge = 16.0.w;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.display1,
        displayMedium: AppTextStyles.display2,
        headlineLarge: AppTextStyles.h1,
        headlineMedium: AppTextStyles.h2,
        headlineSmall: AppTextStyles.h3,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.button,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(88, AppSpacing.buttonHeight),
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          textStyle: AppTextStyles.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
        ),
      ),
      // Others.........
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkGrey,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.display1.copyWith(color: AppColors.white),
        displayMedium: AppTextStyles.display2.copyWith(color: AppColors.white),
        headlineLarge: AppTextStyles.h1.copyWith(color: AppColors.white),
        headlineMedium: AppTextStyles.h2.copyWith(color: AppColors.white),
        headlineSmall: AppTextStyles.h3.copyWith(color: AppColors.white),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.white),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
        labelLarge: AppTextStyles.button.copyWith(color: AppColors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(88, AppSpacing.buttonHeight),
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          textStyle: AppTextStyles.button.copyWith(color: AppColors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
        ),
      ),
      // Others.........
    );
  }
}

class AppThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(builder: (context, themeProvider, child) {
      return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          // Provider.of<AppThemeNotifier>(context).themeData,
          debugShowCheckedModeBanner: false,
          home: const MyPage());
    });
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<AppThemeNotifier>(
          builder: (context, themeProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppSpacing.large),
                CustomAppBar(
                  title: 'Theme Toggle Demo',
                  isBackButton: false,
                  bgcolor: themeProvider.isDarkMode
                      ? AppColors.darkGrey
                      : AppColors.primary,
                  fontSize: AppTextStyles.bodyMedium.fontSize,
                  textColor: themeProvider.isDarkMode
                      ? AppColors.white
                      : AppColors.black,
                  leftWidgets: const [],
                  rightWidgets: [
                    Consumer<AppThemeNotifier>(
                      builder: (context, themeProvider, child) {
                        return IconButton(
                          icon: Icon(
                            themeProvider.isDarkMode
                                ? Icons.dark_mode
                                : Icons.light_mode,
                          ),
                          onPressed: () {
                            themeProvider.toggleTheme();
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.xl),
                Text(
                  'Current Theme: ${themeProvider.isDarkMode ? "Dark" : "Light"}',
                  style: AppTextStyles.h2,
                ),
                const SizedBox(height: 20),
                ButtonTwo(
                  width: 200,
                  text: themeProvider.isDarkMode
                      ? 'Switch to Light Mode'
                      : 'Switch to Dark Mode',
                  topIcon: themeProvider.isDarkMode
                      ? Icon(Icons.light_mode, size: AppSpacing.iconLarge)
                      : Icon(Icons.dark_mode, size: AppSpacing.iconLarge),
                  borderRadius: AppSpacing.radiusMedium,
                  color: themeProvider.isDarkMode
                      ? AppColors.darkGrey
                      : AppColors.primary,
                  darknessLevel: 0.0875,
                  onTap: () {
                    themeProvider.toggleTheme();
                  },
                ),
                SizedBox(height: AppSpacing.medium),
                ButtonTwo(
                  width: 200,
                  text: 'Test my color 1',
                  height: AppSpacing.buttonHeight,
                  color: AppColors.error,
                  darknessLevel: 0.0875,
                  onTap: () {},
                ),
                SizedBox(height: AppSpacing.medium),
                ButtonTwo(
                  width: 200,
                  text: 'Test my color 2',
                  height: AppSpacing.buttonHeight,
                  color: Colors.red,
                  darknessLevel: 0.0875,
                  onTap: () {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Transform.rotate(
                        angle: -pi / 2,
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 50,
                        )),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 90,
                    ),
                    // This example rotates an orange box containing text around its center by fifteen degrees.

                    Transform.rotate(
                      angle: 0.1 * pi / 360,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: const Color(0xFFE8581C),
                        child: const Text('Apartment for rent!'),
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/////////////////////

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData? icons;
  final bool isBackButton;
  final Function()? onLeftWidgetTap;
  final List<Widget>? leftWidgets;
  final List<Widget>? rightWidgets;
  final TextAlign? textAlign;
  final double? fontSize;
  final Color? bgcolor;
  final Color textColor;
  const CustomAppBar({
    super.key,
    required this.title,
    this.icons,
    this.isBackButton = false,
    this.onLeftWidgetTap,
    this.leftWidgets,
    this.rightWidgets,
    this.textAlign,
    this.fontSize,
    this.bgcolor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgcolor ?? Colors.white,
      ),
      child: Row(
        children: [
          if (isBackButton)
            GestureDetector(
              onTap: () {
                debugPrint('back');
              },
              child: Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Icon(
                  icons ?? Icons.arrow_back,
                  color: const Color(0xFF2A2A2A),
                  size: 21.875.w,
                ),
              ),
            ),
          if (isBackButton == false && leftWidgets!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 14.w),
              child: GestureDetector(
                  onTap: onLeftWidgetTap, child: Row(children: leftWidgets!)),
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  textAlign != null ? 0 : 13.125.w,
                  13.125.w,
                  14.875.w,
                  13.125.w),
              child: TextWidget(
                text: title,
                textOverflow: TextOverflow.ellipsis,
                color: textColor,
                fontSize: fontSize ?? 17.5.w,
                fontWeight: FontWeight.w800,
                textAlign: textAlign ?? TextAlign.start,
              ),
            ),
          ),
          if (rightWidgets!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(right: 3.w),
              child: Row(children: rightWidgets!),
            ),
        ],
      ),
    );
  }
}

/// Button
Color darkenColorTwo(Color color, [double amount = 0.087]) {
  assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');
  final hsl = HSLColor.fromColor(color);
  final newLightness = (hsl.lightness - amount).clamp(0.0, 1.0);
  final darkerHsl = hsl.withLightness(newLightness);
  return darkerHsl.toColor();
}

class ButtonTwo extends StatelessWidget {
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final double? minWidth;
  final Color color;
  final double? borderRadius;
  final Border? border;
  final Widget? topIcon;
  final Widget? leftWidget;
  final String text;
  final String? stackText;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool textCenter;
  final EdgeInsetsGeometry? padding;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final double? darknessLevel;

  const ButtonTwo({
    super.key,
    required this.onTap,
    this.height,
    this.width,
    this.minWidth,
    required this.color,
    this.borderRadius,
    this.border,
    this.topIcon,
    this.leftWidget,
    required this.text,
    this.stackText,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.textCenter = false,
    this.padding,
    this.maxLines,
    this.textOverflow,
    this.darknessLevel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width:
            width ?? double.infinity, // Default to full width if not specified
        constraints: BoxConstraints(
          minWidth: minWidth ?? 0,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          border: border ??
              Border(
                  bottom: BorderSide(
                      width: 5,
                      color: darkenColorTwo(color, darknessLevel ?? 0.087))),
        ),
        padding: padding ?? const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (topIcon != null) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: topIcon!,
              ),
            ],
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leftWidget != null) ...[
                  leftWidget!,
                  const SizedBox(width: 8), // Space between image and text
                ],
                TextWidget(
                  text: text,
                  color: stackText != null
                      ? Colors.transparent
                      : textColor ?? Colors.white,
                  fontSize: fontSize ?? 16,
                  fontWeight: fontWeight ?? FontWeight.w700,
                  textAlign: textCenter ? TextAlign.center : TextAlign.start,
                  maxLines: maxLines,
                  textOverflow: textOverflow,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
