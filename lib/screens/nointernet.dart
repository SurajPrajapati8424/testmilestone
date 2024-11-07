import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/button.dart';
import '/widgets/text.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,
              color: Colors.black54,
              size: 100.w,
            ),
            SizedBox(height: 20.w),
            Container(
              width: 300.w,
              padding: EdgeInsets.only(top: 15.w, bottom: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.w)),
                color: Colors.black54,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidget(
                    text: 'Oops! There is no Internet\nConnection',
                    textAlign: TextAlign.center,
                    color: Colors.white,
                    fontSize: 18.w,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            Container(
              width: 300.w,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12.w)),
                color: const Color(0xFF00C85C),
                border: Border(
                  bottom: BorderSide(width: 4.w, color: Colors.black26),
                ),
              ),
              child: Button(
                width: 250.w,
                // height: 45.w,
                text: 'Refresh',
                textCenter: true,
                // textColor: ,
                color: Colors.transparent,
                onTap: () {
                  debugPrint('REFRESH');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
