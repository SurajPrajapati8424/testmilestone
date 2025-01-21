import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testmilestone/function/darkencolor.dart';
import 'package:testmilestone/screens/profile.dart';
import 'package:testmilestone/widgets/button.dart';

import '../widgets/text.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> darkModeValue = ValueNotifier<bool>(false);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            const CustomAppBar(
              title: 'Settings',
              isBackButton: true,
              rightWidgets: [],
            ),

            // Banner
            SizedBox(height: 25.w),
            const PremiumBanner(),
            // Other
            SizedBox(height: 10.w),
            ProfileSetting(
              title: 'Personal Info',
              icon: Icons.person_2_rounded,
              iconColor: Colors.orange,
              onTap: () => debugPrint('Personal Info'),
            ),
            ProfileSetting(
              title: 'Notification',
              icon: Icons.notifications,
              iconColor: Colors.red.shade200,
              onTap: () => debugPrint('Notification'),
            ),
            ProfileSetting(
              title: 'Music & Effects',
              icon: Icons.volume_up_rounded,
              iconColor: Colors.blueAccent,
              onTap: () => debugPrint('Music & Effects'),
            ),
            ProfileSetting(
              title: 'Security',
              icon: Icons.shield,
              iconColor: Colors.green.shade500,
              onTap: () => debugPrint('Security'),
            ),

            ProfileSetting(
              title: 'Dark Mode',
              icon: Icons.remove_red_eye,
              iconColor: Colors.blue,
              isSwitch: true,
              rightWidget: ValueListenableBuilder<bool>(
                  valueListenable: darkModeValue,
                  builder: (context, value, child) {
                    return CupertinoSwitch(
                      value: value,
                      activeColor: const Color(0xFF00C85C),
                      trackColor: Colors.grey.shade300,
                      onChanged: (newVal) {
                        darkModeValue.value = newVal;
                        debugPrint('Dark Mode: $newVal');
                      },
                    );
                  }),
            ),
            ProfileSetting(
              title: 'Help Center',
              icon: CupertinoIcons.doc_text_fill,
              iconColor: Colors.deepOrange.shade200,
              onTap: () => debugPrint('Help Center'),
            ),
            ProfileSetting(
              title: 'About AQ Quiz',
              icon: Icons.info_rounded,
              iconColor: Colors.purple.shade600,
              onTap: () => debugPrint('About'),
            ),
            ProfileSetting(
              title: 'Logout',
              icon: Icons.exit_to_app_rounded,
              iconColor: Colors.red,
              textColor: Colors.red,
              isRightWidget: false,
              onTap: () => debugPrint('Logout'),
            ),
          ],
        ),
      )),
    );
  }
}

class PremiumBanner extends StatelessWidget {
  const PremiumBanner({super.key});

  @override
  Widget build(BuildContext context) {
    Color bgColor = const Color(0xFF00C85C);
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20.w),
          border: Border(
              bottom: BorderSide(color: darkenColor(bgColor), width: 5.w))),
      child: Stack(
        children: [
          ...starsPosition(),
          buildContent(),
        ],
      ),
    );
  }

  List<Widget> starsPosition() {
    Widget buildStars({double size = 18}) {
      return TextWidget(text: '🌟', fontSize: size.w);
    }

    final List<Positioned> stars = [
      Positioned(top: 10.w, right: 0.w, child: buildStars(size: 40.w)),
      Positioned(top: 0.w, right: 46.w, child: buildStars(size: 18.w)),
      Positioned(top: 5.w, right: 75.w, child: buildStars(size: 28.w)),
      Positioned(top: 35.w, right: 55.w, child: buildStars(size: 15.w)),
      Positioned(bottom: 9.w, right: 0, child: buildStars(size: 30.w)),
      Positioned(bottom: 0.w, right: 55, child: buildStars(size: 30.w)),
      Positioned(bottom: 11.w, right: 110.w, child: buildStars(size: 30.w)),
    ];
    return stars;
  }

  Widget buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextWidget(
          text: 'Play quizzes without \nads and restrictions',
          fontSize: 18.w,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 20.w),
        Button(
          text: 'GO PREMIUM',
          fontSize: 14.w,
          textCenter: true,
          textColor: const Color(0xFF00C85C),
          color: Colors.white,
          borderRadius: 25.w,
          border: Border.all(color: Colors.transparent),
          padding:
              EdgeInsets.only(top: 8.w, bottom: 8.w, left: 15.w, right: 15.w),
        ),
      ],
    );
  }
}

class ProfileSetting extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color? textColor;
  final Color? iconBgColor;
  final VoidCallback? onTap;
  final bool isSwitch;
  final bool isRightWidget;
  final Widget? rightWidget;

  const ProfileSetting({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    this.iconBgColor,
    this.onTap,
    this.textColor,
    this.isSwitch = false,
    this.isRightWidget = true,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBgColor ?? iconColor.withOpacity(0.2),
            ),
            child: Icon(icon, color: iconColor, size: 25.w),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: TextWidget(
              text: title,
              color: textColor ?? Colors.black,
              fontSize: 18.w,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.start,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
          isRightWidget
              ? !isSwitch
                  ? IconButton(
                      onPressed: onTap ?? () {},
                      icon: Icon(Icons.keyboard_arrow_right_rounded,
                          color: Colors.black, size: 25.w),
                    )
                  : rightWidget!
              : Container(),
        ],
      ),
    );
  }
}
