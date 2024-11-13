import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/button.dart';
import '../widgets/text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // AppBar
          CustomAppBar(
            title: 'Profile',
            isBackButton: false,
            leftWidgets: const [],
            rightWidgets: [
              IconButton(
                onPressed: () {
                  debugPrint('Setting');
                },
                icon: const Icon(Icons.settings_outlined),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              children: [
                // User
                const UserProfile(
                  userName: 'Andrew Ainsley',
                  userEmail: 'quiz@advancequiz.com',
                  imgUrl:
                      'https://images.unsplash.com/photo-1640960543409-dbe56ccc30e2?q=80&&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ),
                // Score Grid
                SizedBox(height: 10.w),
                const Stats(),
                // Tab
                SizedBox(height: 18.w),
                tabs(context),
                // Quiz Played Section
                SizedBox(height: 18.w),
                quizPlayed(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// AppBar
class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData? icons;
  final bool isBackButton;
  final Function()? onLeftWidgetTap;
  final List<Widget>? leftWidgets;
  final List<Widget>? rightWidgets;
  final TextAlign? textAlign;
  const CustomAppBar({
    super.key,
    required this.title,
    this.icons,
    this.isBackButton = false,
    this.onLeftWidgetTap,
    this.leftWidgets,
    this.rightWidgets,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
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
              padding: EdgeInsets.only(left: 144.w),
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
                color: const Color(0xFF2A2A2A),
                fontSize: 17.5.w,
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

// User
class UserProfile extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String imgUrl;
  const UserProfile(
      {super.key,
      required this.userName,
      required this.userEmail,
      required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image
          SizedBox(
            height: 60.w,
            width: 60.w,
            child: Stack(
              children: [
                // profile image
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: SizedBox(
                    height: 50.w,
                    width: 50.w,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        imgUrl,
                      ),
                      backgroundColor: const Color(0xFF00C85C),
                      child: const TextWidget(text: 'Profile'),
                    ),
                  ),
                ),
                // edit icons
                Positioned(
                  top: 4.w,
                  right: 4.w,
                  child: Container(
                    height: 15.w,
                    width: 15.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.w),
                      border: Border.all(
                          color: const Color(0xFF00C85C), width: 1.w),
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.edit,
                    size: 15.w,
                    color: const Color(0xFF00C85C),
                  ),
                ),
              ],
            ),
          ),
          // Name + email
          SizedBox(width: 14.w),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget(
                    text: userName,
                    fontSize: 17.5.w,
                    fontWeight: FontWeight.w700),
                TextWidget(
                  text: userEmail,
                  fontSize: 12.25.w,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF616161),
                ),
              ],
            ),
          ),
          // edit name btn
          // SizedBox(width: 60.w),
          Expanded(
            flex: 1,
            child: Button(
              height: 35.w,
              minWidth: 87.5.w,
              text: 'Edit Name',
              fontSize: 12.25.w,
              fontWeight: FontWeight.w600,
              textCenter: true,
              borderRadius: 22.w,
              color: const Color(0xFF00C85C),
              padding: EdgeInsets.zero,
              onTap: () {
                debugPrint('Edit Name');
              },
            ),
          ),
        ],
      ),
    );
  }
}

// User Score
class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Statistics Section
        DividerWidget(
            thickness: 2.w,
            color: const Color(0xFFEEEEEE),
            padding: EdgeInsets.zero),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(flex: 1, child: _buildStatItem('7', 'Collections')),
            SizedBox(height: 51.w, child: const VerticalWidget()),
            Expanded(flex: 1, child: _buildStatItem('372.5K', 'followers')),
            SizedBox(height: 51.w, child: const VerticalWidget()),
            Expanded(flex: 1, child: _buildStatItem('269', 'following')),
          ],
        ),
        SizedBox(height: 14.w),
        DividerWidget(
            thickness: 2.w,
            color: const Color(0xFFEEEEEE),
            padding: EdgeInsets.zero),
        SizedBox(height: 14.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(flex: 1, child: _buildStatItem('45', 'My Quiz')),
            SizedBox(height: 51.w, child: const VerticalWidget()),
            Expanded(flex: 1, child: _buildStatItem('0', 'Collections')),
            SizedBox(height: 51.w, child: const VerticalWidget()),
            Expanded(flex: 1, child: _buildStatItem('16.8K', 'Plays')),
          ],
        ),
        const SizedBox(height: 14),
        DividerWidget(
            thickness: 2.w,
            color: const Color(0xFFEEEEEE),
            padding: EdgeInsets.zero),
      ],
    );
  }
}

Widget _buildStatItem(String count, String label) {
  return Column(
    children: [
      SizedBox(height: 4.w),
      TextWidget(text: count, fontSize: 17.5.w, fontWeight: FontWeight.w700),
      SizedBox(height: 4.w),
      TextWidget(
        text: label,
        fontSize: 14.w,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF424242),
      ),
      SizedBox(height: 4.w),
    ],
  );
}

// Tab
Widget tabs(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: GestureDetector(
          onTap: () {
            debugPrint('Clicked Quiz Played');
          },
          child: Container(
            height: 33.25.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF00C85C),
              border: Border.all(width: 1.75.w, color: const Color(0xFF00C85C)),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26.25.w),
                  bottomLeft: Radius.circular(1.75.w)),
            ),
            child: TextWidget(
              text: 'Quiz Played',
              color: Colors.white,
              fontSize: 15.75.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            debugPrint('Clicked About');
          },
          child: Container(
            height: 33.25.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.75.w, color: const Color(0xFF00C85C)),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(26.25.w),
                  bottomRight: Radius.circular(1.75.w)),
            ),
            child: TextWidget(
              text: 'About',
              color: const Color(0xFF00C85C),
              fontSize: 15.75.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      )
    ],
  );
}

// Quiz Played Section
Widget quizPlayed() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextWidget(
          text: 'Quiz Played (4)',
          fontSize: 17.5.w,
          fontWeight: FontWeight.w700),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
              text: 'Newest',
              fontSize: 15.75.w,
              color: const Color(0xFF00C85C),
              fontWeight: FontWeight.w700),
          SizedBox(width: 7.w),
          SizedBox(
            width: 26.w,
            child: Stack(
              children: [
                Icon(CupertinoIcons.arrow_up,
                    color: const Color(0xFF00C85C), size: 15.6.w),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Icon(CupertinoIcons.arrow_down,
                      color: const Color(0xFF00C85C), size: 15.6.w),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

/////////////
class DividerWidget extends StatelessWidget {
  final Color color;
  final double thickness;
  final EdgeInsetsGeometry padding;
  final double indent;
  final double endIndent;
  final double height;
  const DividerWidget({
    super.key,
    this.color = const Color.fromARGB(255, 217, 216, 217),
    this.thickness = 0.5,
    this.height = 0.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 15.0),
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Divider(
        color: color,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        height: height,
      ),
    );
  }
}

class VerticalWidget extends StatelessWidget {
  final Color color;
  final double thickness;
  final EdgeInsetsGeometry padding;
  final double indent;
  final double endIndent;
  final double width;
  const VerticalWidget({
    super.key,
    this.color = const Color.fromARGB(255, 217, 216, 217),
    this.thickness = 0.5,
    this.width = 0.5,
    this.padding = const EdgeInsets.symmetric(horizontal: 15.0),
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: VerticalDivider(
        color: color,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        width: width,
      ),
    );
  }
}
