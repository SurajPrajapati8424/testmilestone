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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.w),
              SizedBox(
                width: 150.w,
                height: 150.w,
                child: Image.network(
                  'https://cdn-icons-png.freepik.com/512/14026/14026930.png?ga=GA1.1.2087962844.1731066583',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 25.w),
              TextWidget(
                text: 'Premium Content',
                fontSize: 22.w,
                color: Colors.black,
                fontWeight: FontWeight.w800,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.w),
              TextWidget(
                text:
                    'Upgrade your plan to unlock all course and Premium contents.',
                fontSize: 16.w,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25.w),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      text: 'Upgrade Plan',
                      height: 50.w,
                      textCenter: true,
                      fontSize: 16.w,
                      textColor: Colors.white,
                      color: Colors.blue.shade600,
                      borderRadius: 20.w,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.w),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      text: 'Maybe Later',
                      height: 50.w,
                      textCenter: true,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.blue.shade600,
                      color: Colors.blue.shade100.withOpacity(0.2),
                      borderRadius: 22.w,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.w),
            ],
          ));
    },
  );
}
