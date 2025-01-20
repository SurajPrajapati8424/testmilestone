import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/button.dart';
import '../widgets/text.dart';

void showForgetAndResetPsk(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CallCircle(),
            SizedBox(height: 20.w),
            TextWidget(
              text: 'Welcome Back!',
              fontSize: 20.w,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF00C85C),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.w),
            TextWidget(
              text: 'You have successfully reset and created a new password.',
              fontSize: 14.w,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.w),
            Button(
              width: MediaQuery.sizeOf(context).width,
              text: 'Go to Home',
              color: const Color(0xFF00C85C),
              borderRadius: 20.w,
              fontSize: 16.w,
              fontWeight: FontWeight.w700,
              textColor: Colors.white,
              textCenter: true,
              onTap: Navigator.of(context).pop,
            ),
          ],
        ),
      );
    },
  );
}

class CallCircle extends StatelessWidget {
  const CallCircle({super.key});

  @override
  Widget build(BuildContext context) {
    const double size = 150;
    const Color backgroundColor = Color(0xFF00C85C);
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(top: 0, left: 0, child: simpleCircle(size: 20.w)),
        Positioned(top: 0, right: 70.w, child: simpleCircle(size: 5.w)),
        Positioned(top: 20.w, right: 0, child: simpleCircle(size: 12.w)),
        Positioned(top: 40.w, right: 0, child: simpleCircle(size: 4.w)),
        Positioned(bottom: 0, left: 40.w, child: simpleCircle(size: 11.w)),
        Positioned(left: 0, bottom: 40.w, child: simpleCircle(size: 4.w)),
        Positioned(bottom: 2, left: 90.w, child: simpleCircle(size: 5.w)),
        Positioned(right: 0, top: 90.w, child: simpleCircle(size: 12.w)),
        Container(
          width: size,
          height: size,
          margin: EdgeInsets.all(10.w),
          decoration: const BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: size * 0.38,
              height: size * 0.38,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.w)),
              child: const Center(
                child: Icon(
                  Icons.check_rounded,
                  color: backgroundColor,
                  size: size * 0.25,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget simpleCircle(
      {required double size, Color backgroundColor = const Color(0xFF00C85C)}) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.75.w),
          shape: BoxShape.circle,
        ));
  }
}
