import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../widgets/button.dart';
import '../widgets/text.dart';

class AchievementAndLogout extends StatelessWidget {
  const AchievementAndLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => showAchievement(context),
              child: const Text('Achievement'),
            ),
            ElevatedButton(
              onPressed: () => showLogout(context),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

// achievement
Future<dynamic> showAchievement(BuildContext context) {
  return showMaterialModalBottomSheet(
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10.w),
        Container(
          height: 4,
          width: 40,
          margin: EdgeInsets.only(bottom: 16.w),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.w),
          ),
        ),
        SizedBox(height: 10.w),
        Container(
          width: 330.w,
          height: 330.w,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 10.w),
              TextWidget(
                text: 'I got the achievement',
                fontSize: 18.w,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 15.w),
              SizedBox(
                height: 120.w,
                width: 120.w,
                child: Image.network(
                  'https://cdn-icons-png.freepik.com/512/2643/2643032.png?ga=GA1.1.2087962844.1731066583',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
              SizedBox(height: 12.w),
              TextWidget(
                  text: 'Shining Star!',
                  fontSize: 30.w,
                  fontWeight: FontWeight.w800),
              SizedBox(height: 10.w),
              TextWidget(
                  text: 'December 22, 2024',
                  fontSize: 16.w,
                  fontWeight: FontWeight.w600),
              SizedBox(height: 10.w),
              TextWidget(
                  text: 'Golingo', fontSize: 20.w, fontWeight: FontWeight.w700),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Button(
                      text: 'Share Achievements',
                      height: 50.w,
                      fontSize: 18.w,
                      color: const Color(0xFF00C85C),
                      borderRadius: 22.w,
                      fontWeight: FontWeight.w600,
                      leftWidget: const Icon(
                        Icons.share_outlined,
                        color: Colors.white,
                      ),
                      textCenter: true,
                      onTap: () {
                        // Add share functionality here
                      },
                    ))
                  ],
                ),
                SizedBox(height: 20.w),
              ],
            ))
      ],
    ),
    backgroundColor: Colors.grey.shade100,
    barrierColor: Colors.black.withOpacity(.4),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.w))),
  );
}

// logout
Future<dynamic> showLogout(BuildContext context) {
  return showMaterialModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.w),
          Container(
            height: 4,
            width: 40,
            margin: EdgeInsets.only(bottom: 16.w),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8..w),
            ),
          ),
          SizedBox(height: 10.w),
          TextWidget(
            text: "Logout",
            color: Colors.red,
            fontSize: 22.w,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w800,
          ),
          SizedBox(height: 20.w),
          Divider(color: Colors.grey, thickness: 0.2.w),
          SizedBox(height: 20.w),
          TextWidget(
            text: 'Are you sure you want to log out ?',
            textAlign: TextAlign.center,
            fontSize: 18.w,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 20.w),
          Row(
            children: [
              Expanded(
                  child: Button(
                text: 'Cancel',
                height: 50.w,
                textCenter: true,
                textColor: Colors.deepPurple,
                color: Colors.deepPurple.shade100,
                borderRadius: 22.w,
                onTap: () {},
              )),
              SizedBox(width: 7.w),
              Expanded(
                  child: Button(
                text: 'Yes, Logout',
                height: 50.w,
                textCenter: true,
                textColor: Colors.white,
                color: Colors.deepPurple,
                borderRadius: 22.w,
                onTap: () {},
              )),
            ],
          ),
          SizedBox(height: 30.w),
        ],
      ),
    ),
    backgroundColor: Colors.grey.shade100,
    barrierColor: Colors.black.withOpacity(.4),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.w))),
  );
}
