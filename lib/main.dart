import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'screens/rating.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(
    const ScreenUtilInit(
      designSize: Size(360, 752),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MileStone',
      theme: ThemeData(
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/rating": (context) => const RatingPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: const Center(
            child: Text('SUPEER'),
          ),
        );
      },
    );
  }
}
