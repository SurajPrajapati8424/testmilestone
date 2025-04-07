import 'package:flutter/cupertino.dart';

import '../screens/mytheme.dart';

class AppThemeWidget extends StatefulWidget {
  final Widget Function(BuildContext context, CupertinoThemeData colorTheme,
      ConstTheme_ constTheme, VoidCallback changeTheme, bool isDark) builder;
  const AppThemeWidget({super.key, required this.builder});
  @override
  State<AppThemeWidget> createState() => _AppThemeWidgetState();
}

class _AppThemeWidgetState extends State<AppThemeWidget> {
  bool _isDark = false;
  void _changeTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = _isDark ? ConstTheme.darkTheme : ConstTheme.lightTheme;
    final ConstTheme_ constTheme = ConstTheme_();
    return widget.builder(
      context,
      colorTheme,
      constTheme,
      _changeTheme,
      _isDark,
    );
  }
}













// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AppThemeWidget extends StatefulWidget {
//   final Widget Function(
//     BuildContext context,
//     CupertinoThemeData colorTheme,
//     ConstTheme_ constTheme,
//     void Function() changeTheme,
//     bool isDark
//   ) builder;
//   final void Function()? onStart;
//   final void Function()? onClose;

//   const AppThemeWidget({
//     Key? key,
//     required this.builder,
//     this.onStart,
//     this.onClose,
//   }) : super(key: key);

//   @override
//   State<AppThemeWidget> createState() => _AppThemeWidgetState();
// }

// class _AppThemeWidgetState extends State<AppThemeWidget> {
//   bool _isDark = false;
//   final ConstTheme_ _constTheme = ConstTheme_();
  
//   @override
//   void initState() {
//     super.initState();
//     _loadThemePreference();
//     if (widget.onStart != null) {
//       widget.onStart!();
//     }
//   }
  
//   @override
//   void dispose() {
//     if (widget.onClose != null) {
//       widget.onClose!();
//     }
//     super.dispose();
//   }

//   Future<void> _loadThemePreference() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedIsDark = prefs.getBool('is_dark_theme') ?? false;
//     if (savedIsDark != _isDark) {
//       setState(() {
//         _isDark = savedIsDark;
//       });
//     }
//   }

//   Future<void> _saveThemePreference() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('is_dark_theme', _isDark);
//   }

//   void _changeTheme() {
//     setState(() {
//       _isDark = !_isDark;
//     });
//     _saveThemePreference();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorTheme = _isDark 
//       ? ConstTheme.darkTheme 
//       : ConstTheme.lightTheme;
    
//     return CupertinoTheme(
//       data: colorTheme,
//       child: Material(
//         child: widget.builder(
//           context,
//           colorTheme,
//           _constTheme,
//           _changeTheme,
//           _isDark,
//         ),
//       ),
//     );
//   }
// }