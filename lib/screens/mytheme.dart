// import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:testmilestone/screens/profile.dart';

// import '../widgets/text.dart';

// /**
//  * This is a simple example of how to implement a theme toggle in your app.
//  * Changes in runApp() method.
//  runApp(
//     ChangeNotifierProvider(
//       create: (context) =>> AppThemeNotifier(),
//       child: const ScreenUtilInit(
//         designSize: Size(360, 752),
//         child: BetterFeedback(
//           child: TestScreen(),
//         ),
//       ),
//     ),
//   );
// }

class ConstTheme_ {
  final Color = AppColor();
  final TextStyle = AppTextStyle();
  final Spacing = AppSpacing();
  final Size = AppSize();
  final Radius = AppRadius();
  final Icon = AppIconSize();
  final FontSize = FontSizes();
  final FWeight = FontWeights();
}

class ConstTheme {
  static final Color = AppColor();
  static final TextStyle = AppTextStyle();
  static final Spacing = AppSpacing();
  static final Size = AppSize();
  static final Radius = AppRadius();
  static final Icon = AppIconSize();
  static final FontSize = FontSizes();
  static final FWeight = FontWeights();
  ConstTheme._();

  static CupertinoThemeData get lightTheme {
    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: Color.primary,
      barBackgroundColor: Color.background,
      scaffoldBackgroundColor: Color.white,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle.xxs,
        actionTextStyle: TextStyle.xs,
        tabLabelTextStyle: TextStyle.small,
        navTitleTextStyle: TextStyle.smPlus,
        navLargeTitleTextStyle: TextStyle.large,
        navActionTextStyle: TextStyle.xl,
      ),
    );
  }

  static CupertinoThemeData get darkTheme {
    return CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: Color.primary,
      barBackgroundColor: Color.black,
      scaffoldBackgroundColor: Color.black,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle.xxs.copyWith(color: Color.white),
        actionTextStyle: TextStyle.xs.copyWith(color: Color.white),
        tabLabelTextStyle: TextStyle.small.copyWith(color: Color.white),
        navTitleTextStyle: TextStyle.smPlus.copyWith(color: Color.white),
        navLargeTitleTextStyle: TextStyle.large.copyWith(color: Color.white),
        navActionTextStyle: TextStyle.xl.copyWith(color: Color.white),
      ),
    );
  }
}

class AppColor {
  // Brand Colors
  Color get primary => const Color(0xFF00C85C);
  Color get secondary => const Color(0xFF00BFA5);
  Color get accent => Colors.greenAccent;

  // Neutral Colors
  Color get black => const Color(0xFF2A2A2A);
  Color get white => const Color(0xFFFFFFFF);
  Color get lightGrey => const Color(0xFFE0E0E0);
  Color get dividerColorL => const Color.fromARGB(255, 217, 216, 217);
  Color get dividerColorD =>
      const Color.fromARGB(255, 217, 216, 217).withAlpha(100);
  Color get grey => const Color(0xFF9E9E9E);
  Color get mediumGrey => Colors.grey.shade700;
  Color get darkGrey => const Color(0xFF424242);

  // Semantic Colors
  Color get success => const Color(0xFF4CAF50);
  Color get error => const Color(0xFFD32F2F);
  Color get warning => const Color(0xFFFFA000);
  Color get info => const Color(0xFF1976D2);

  // Background Colors
  Color get background => const Color(0xFFFAFAFA);
  Color get transparent => Colors.transparent;

  // Text
  Color get selectionColor => const Color.fromARGB(71, 0, 166, 105);
  Color get selectionHandleColor => const Color.fromARGB(255, 80, 80, 80);
}

class AppTextStyle {
  TextStyle get xxs2 => GoogleFonts.nunito(
      fontSize: 10.w, fontWeight: FontWeight.w700, color: AppColor().black);
  TextStyle get xxs => GoogleFonts.nunito(
      fontSize: 13.w, fontWeight: FontWeight.w700, color: AppColor().black);
  TextStyle get xs => GoogleFonts.nunito(
      fontSize: 15.w, fontWeight: FontWeight.w700, color: AppColor().black);
  TextStyle get small => GoogleFonts.nunito(
      fontSize: 16.w, fontWeight: FontWeight.w700, color: AppColor().black);
  TextStyle get smPlus => GoogleFonts.nunito(
      fontSize: 18.w, fontWeight: FontWeight.w600, color: AppColor().black);
  TextStyle get medium => GoogleFonts.nunito(
      fontSize: 20.w, fontWeight: FontWeight.w700, color: AppColor().black);
  TextStyle get large => GoogleFonts.nunito(
      fontSize: 24.w, fontWeight: FontWeight.w700, color: AppColor().black);
  TextStyle get xl => GoogleFonts.nunito(
      fontSize: 28.w, fontWeight: FontWeight.w700, color: AppColor().black);
  TextStyle get xxl => GoogleFonts.nunito(
      fontSize: 32.w, fontWeight: FontWeight.w800, color: AppColor().black);
}

class FontSizes {
  double get xxs2 => 10.w;
  double get xxs => 13.w;
  double get xs => 15.w;
  double get small => 16.w;
  double get smPlus => 18.w;
  double get medium => 20.w;
  double get large => 24.w;
  double get xl => 28.w;
  double get xxl => 32.w;
}

class FontWeights {
  FontWeight get Normal => FontWeight.w700;
  FontWeight get Bold => FontWeight.w800;
  FontWeight get Extra => FontWeight.w900;
}

class AppSpacing {
  // Padding and Margin
  double get xs => 4.0.w;
  double get small => 8.0.w;
  double get medium => 16.0.w;
  double get mediumPlus => 20.0.w;
  double get large => 24.0.w;
  double get xl => 32.0.w;
  double get xxl => 48.0.w;
}

class AppSize {
  // Button Sizes
  double get small => 36.w;
  double get smallPlus => 43.8.w;
  double get medium => 46.w;
  double get large => 56.0.w;
  double get xl => 70.0.w;
}

class AppIconSize {
  // Icon Sizes
  double get small => 16.0.w;
  double get smPlus => 20.0.w;
  double get medium => 24.0.w;
  double get large => 32.0.w;
}

class AppRadius {
  // Border Radius
  double get xs => 4.0.w;
  double get small => 7.0.w; // old 8.w
  double get smPlus => 10.0.w;
  double get medium => 10.5.w;
  double get mediumPlus => 12.0.w;
  double get large => 15.0.w;
  double get xl => 20.0.w;
  double get xxl => 24.0.w;
}

// /////////////////
class AppThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
