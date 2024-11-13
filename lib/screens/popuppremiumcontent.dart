import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/button.dart';
import '../widgets/text.dart';

class PopupPremiumContent extends StatelessWidget {
  const PopupPremiumContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () => showLightPremiumContent(context),
            child: const Text('Premium Content')),
      ),
    );
  }
}

void showLightPremiumContent(BuildContext context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (builder) {
      return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.w)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 100.w,
                height: 120.w,
                child: Image.network(
                  'https://cdn-icons-png.freepik.com/512/14026/14026930.png?ga=GA1.1.2087962844.1731066583',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 7.w),
              TextWidget(
                text: 'Premium Content',
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 7.w),
              TextWidget(
                text:
                    'Upgrade your plan to uncloc all course and Premium contents',
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 12.w),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      text: 'Upgrade Plan',
                      textCenter: true,
                      fontSize: 18.w,
                      textColor: Colors.white,
                      color: const Color(0xFF00C85C),
                      borderRadius: 22.w,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7.w,
              ),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      text: 'Maybe Later',
                      textCenter: true,
                      fontSize: 18.w,
                      textColor: Colors.black,
                      color: Colors.grey.shade200,
                      borderRadius: 22.w,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ));
    },
  );
}
