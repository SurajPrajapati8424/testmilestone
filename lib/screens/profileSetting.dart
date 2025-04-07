import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../function/webview.dart';
import '../widgets/button.dart';
import '../widgets/divider.dart';
import '../widgets/inputfield.dart';
import '../widgets/text.dart';
import '../widgets/themeWidget.dart';

class Profilesetting extends StatefulWidget {
  const Profilesetting({super.key});

  @override
  State<Profilesetting> createState() => _ProfilesettingState();
}

class _ProfilesettingState extends State<Profilesetting> {
  TextEditingController nameController = TextEditingController();
  String initialName = "Joe Donnnnn";
  @override
  void initState() {
    super.initState();
    nameController.text = initialName;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeWidget(
      builder: (context, colorTheme, constTheme, changeTheme, isDark) =>
          Scaffold(
        backgroundColor: colorTheme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Circular Profile Image
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 160.w,
                      width: 160.w,
                      decoration: BoxDecoration(
                        color: constTheme.Color.transparent,
                        borderRadius: BorderRadius.circular(80.w),
                        border: Border.all(
                          color: colorTheme.primaryColor,
                          width: 3.w,
                        ),
                      ),
                      child: const SizedBox(),
                    ),
                    SmoothClipRRect(
                      borderRadius: BorderRadius.circular(80.w),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1640960543409-dbe56ccc30e2?q=80&&auto=format&fit=crop&ixlib=rb-5.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        height: 150.w,
                        width: 150.w,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 150.w,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: colorTheme.primaryColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(80.w),
                            ),
                            child: Icon(
                              Icons.image_not_supported,
                              color: constTheme.Color.background,
                              size: constTheme.Icon.large,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          return loadingProgress == null
                              ? child
                              : Container(
                                  height: 150.w,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                    color: colorTheme.primaryColor
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(80.w),
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        color: colorTheme.primaryColor),
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: constTheme.Spacing.mediumPlus),
                const DividerWidget(),
                SizedBox(height: constTheme.Spacing.mediumPlus),
                // Name with Edit Option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: nameController.text,
                      textStyle: colorTheme.textTheme.navLargeTitleTextStyle,
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      iconSize: constTheme.Icon.smPlus,
                      color: colorTheme.primaryColor,
                      onPressed: () {
                        showEditNameDialog(context, nameController);
                      },
                    ),
                  ],
                ),
                SizedBox(height: constTheme.Spacing.mediumPlus),

                // Mode Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'Dark Mode',
                      textStyle: colorTheme.textTheme.navTitleTextStyle
                          .copyWith(fontWeight: constTheme.FWeight.Bold),
                    ),
                    Switch(
                      activeColor: constTheme.Color.primary,
                      activeTrackColor:
                          constTheme.Color.primary.withOpacity(0.3),
                      inactiveThumbColor: constTheme.Color.white,
                      inactiveTrackColor: constTheme.Color.lightGrey,
                      value: isDark,
                      onChanged: (value) => changeTheme(),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.35.w),
                // Logout Button
                Button(
                  text: 'Logout',
                  height: constTheme.Size.large,
                  width: MediaQuery.sizeOf(context).width,
                  color: isDark
                      ? constTheme.Color.error
                      : constTheme.Color.background,
                  leftWidget: Icon(Icons.logout,
                      color: isDark
                          ? constTheme.Color.background
                          : constTheme.Color.error,
                      size: constTheme.Icon.smPlus),
                  fontSize: constTheme.FontSize.smPlus,
                  textCenter: true,
                  textColor: isDark
                      ? constTheme.Color.background
                      : constTheme.Color.error,
                  onTap: () {
                    logout(context);
                  },
                ),
                SizedBox(height: constTheme.Spacing.medium),

                // Terms & Conditions
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 15,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Browser()
                            .open(url: 'https://docs.flutter.dev/tos');
                      },
                      child: TextWidget(
                        text: 'Terms & Conditions',
                        textStyle: colorTheme.textTheme.textStyle.copyWith(
                          decoration: TextDecoration.underline,
                          color: constTheme.Color.info,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Browser().open(
                            url: 'https://policies.google.com/privacy?hl=en');
                      },
                      child: TextWidget(
                        text: 'Privacy Policy',
                        textStyle: colorTheme.textTheme.textStyle.copyWith(
                          decoration: TextDecoration.underline,
                          color: constTheme.Color.info,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Browser().open(url: 'https://flutter.dev/events');
                      },
                      child: TextWidget(
                        text: 'Contact Us',
                        textStyle: colorTheme.textTheme.textStyle.copyWith(
                          decoration: TextDecoration.underline,
                          color: constTheme.Color.info,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// FUNCTIONS

void showEditNameDialog(_, TextEditingController controller) {
  showDialog(
    context: _,
    barrierDismissible: false,
    builder: (context) {
      return AppThemeWidget(
        builder: (context, colorTheme, constTheme, changeTheme, isDark) =>
            AlertDialog(
          backgroundColor: colorTheme.scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(constTheme.Radius.large),
          ),
          title: TextWidget(
              text: 'Edit Name',
              textStyle: colorTheme.textTheme.navTitleTextStyle
                  .copyWith(fontWeight: constTheme.FWeight.Bold)),
          content: SingleChildScrollView(
            child: AnswerInputWidget(
              controller: controller,
              hintText: "Enter Your Name",
              onChanged: (str) {
                debugPrint("New Name: $str");
              },
            ),
          ),
          // TextField(
          //   controller: controller,
          //   decoration: const InputDecoration(hintText: "Enter your name"),
          // ),
          actions: [
            IconButton(
                onPressed: changeTheme,
                icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode)),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: TextWidget(
                  text: 'Cancel',
                  textStyle: colorTheme.textTheme.navTitleTextStyle),
            ),
            Button(
              text: 'Save',
              width: constTheme.Size.xl,
              color: colorTheme.primaryColor,
              fontSize: constTheme.FontSize.smPlus,
              textColor: constTheme.Color.white,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

void logout(_) {
  showDialog(
    context: _,
    builder: (BuildContext context) {
      return AppThemeWidget(
        builder: (context, colorTheme, constTheme, changeTheme, isDark) =>
            AlertDialog(
          backgroundColor: colorTheme.scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(constTheme.Radius.large),
          ),
          title: TextWidget(
              text: 'Logout',
              textStyle: colorTheme.textTheme.navTitleTextStyle
                  .copyWith(fontWeight: constTheme.FWeight.Bold)),
          content: TextWidget(
              text: 'Are you sure you want to logout?',
              textStyle: colorTheme.textTheme.navTitleTextStyle),
          actions: [
            IconButton(
                onPressed: changeTheme,
                icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode)),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: TextWidget(
                  text: 'Cancel',
                  textStyle: colorTheme.textTheme.navTitleTextStyle),
            ),
            Button(
                text: 'Logout',
                fontSize: constTheme.FontSize.smPlus,
                color: constTheme.Color.error,
                onTap: () {
                  Navigator.of(context).pop();
                })
          ],
        ),
      );
    },
  );
}
