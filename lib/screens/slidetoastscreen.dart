import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';

import '../widgets/text.dart';

class SlidingToast extends StatelessWidget {
  const SlidingToast({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Sliding & Popup Toast"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.maxFinite),
            ElevatedButton(
              onPressed: () => slideToast(
                context: context,
                text: 'This is Noraml toast/glass',
                pass: true,
                leadingText: 'F',
                iconData: Icons.person_3_sharp,
                glassBlur: 0, // only for glass blur
                toastAlignment: Alignment.topCenter,
                onTapped: () {
                  debugPrint('tap');
                },
                onDisposed: () {
                  debugPrint('close');
                },
              ),
              child: const TextWidget(text: "Sliding toast"),
            ),
            ElevatedButton(
              onPressed: () => slideErrorToast(
                context: context,
                text: 'This is Error',
                toastAlignment: Alignment.bottomCenter,
                onTapped: () {},
                onDisposed: () {},
              ),
              child: const TextWidget(text: "Sliding Error toast"),
            ),
            ElevatedButton(
              onPressed: () => slideSuccessToast(
                context: context,
                text: 'This is Success',
                toastAlignment: Alignment.topCenter,
                onTapped: () {},
                onDisposed: () {},
              ),
              child: const TextWidget(text: "Sliding Success toast"),
            ),
            ElevatedButton(
              onPressed: () => popToast(
                context: context,
                text: 'This is Pop-up',
                toastAlignment: Alignment.topCenter,
                onTapped: () {},
                onDisposed: () {},
              ),
              child: const TextWidget(text: "Pop toast"),
            ),
          ],
        ),
      ),
    );
  }
}

// widget
Icon trailingWidget({IconData? icon, bool pass = true}) => Icon(
      icon ?? Icons.person,
      color: pass ? const Color(0xFF00C85C) : Colors.red,
    );

Container leadingWidget({String? text, bool pass = true}) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: pass ? const Color(0xFF00C85C) : Colors.red,
    ),
    alignment: Alignment.center,
    child: TextWidget(text: text ?? "🦄", fontSize: 20),
  );
}

// Slide Toast
void slideToast({
  required BuildContext context,
  required String text,
  bool pass = true,
  Alignment toastAlignment = Alignment.topCenter,
  String? leadingText,
  IconData? iconData,
  double? glassBlur,
  required Function() onTapped,
  required Function() onDisposed,
}) {
  InteractiveToast.slide(
    context,
    leading: leadingWidget(pass: pass, text: leadingText),
    title: TextWidget(
      text: text,
      color: Colors.black,
      fontSize: 16.w,
      fontWeight: FontWeight.w600,
    ),
    trailing: trailingWidget(pass: pass, icon: iconData),
    toastStyle: ToastStyle(
        titleLeadingGap: 10,
        backgroundColor: Colors.white,
        glassBlur: glassBlur,
        progressBarColor: pass ? const Color(0xFF00C85C) : Colors.red),
    toastSetting: SlidingToastSetting(
      animationDuration: const Duration(seconds: 1),
      displayDuration: const Duration(seconds: 2),
      toastAlignment: toastAlignment,
    ),
    onTapped: onTapped,
    onDisposed: onDisposed,
  );
}

void slideErrorToast({
  required BuildContext context,
  required String text,
  Alignment toastAlignment = Alignment.topCenter,
  required Function() onTapped,
  required Function() onDisposed,
}) {
  InteractiveToast.slideError(
    context,
    title: TextWidget(
      text: text,
      color: Colors.black,
      fontSize: 16.w,
      fontWeight: FontWeight.w600,
    ),
    toastStyle:
        const ToastStyle(titleLeadingGap: 10, backgroundColor: Colors.white),
    toastSetting: SlidingToastSetting(
      animationDuration: const Duration(seconds: 1),
      displayDuration: const Duration(seconds: 2),
      toastAlignment: toastAlignment,
    ),
    onTapped: onTapped,
    onDisposed: onDisposed,
  );
}

void slideSuccessToast({
  required BuildContext context,
  required String text,
  Alignment toastAlignment = Alignment.topCenter,
  required Function() onTapped,
  required Function() onDisposed,
}) {
  InteractiveToast.slideSuccess(
    context,
    title: TextWidget(
      text: text,
      color: Colors.black,
      fontSize: 16.w,
      fontWeight: FontWeight.w600,
    ),
    toastStyle: const ToastStyle(
      titleLeadingGap: 10,
      backgroundColor: Colors.white,
    ),
    toastSetting: SlidingToastSetting(
      animationDuration: const Duration(seconds: 1),
      displayDuration: const Duration(seconds: 2),
      toastAlignment: toastAlignment,
    ),
    onTapped: onTapped,
    onDisposed: onDisposed,
  );
}

void popToast({
  required BuildContext context,
  required String text,
  Alignment toastAlignment = Alignment.bottomCenter,
  required Function() onTapped,
  required Function() onDisposed,
}) {
  InteractiveToast.pop(
    context,
    title: Text(
      text == ''
          ? "Hi! I'm a popup toast 🐺. "
              "I have fading and scaling effect."
          : text,
    ),
    leading: leadingWidget(),
    trailing: trailingWidget(),
    toastSetting: PopupToastSetting(
      animationDuration: const Duration(seconds: 1),
      displayDuration: const Duration(seconds: 3),
      toastAlignment: toastAlignment,
    ),
    toastStyle: const ToastStyle(expandedTitle: true),
    onTapped: onTapped,
    onDisposed: onDisposed,
  );
}
