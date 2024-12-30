import 'dart:async';

import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:testmilestone/screens/profile.dart';

import '../widgets/button.dart';
import '../widgets/text.dart';

class Playerstatus extends StatelessWidget {
  const Playerstatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Column(
          children: [
            SizedBox(height: 36.w),
            CustomAppBar(
              title: 'App Name',
              fontSize: 18.w,
              isBackButton: false,
              rightWidgets: [
                CircleAvatar(
                  backgroundImage:
                      const NetworkImage('https://i.pravatar.cc/150?img=1'),
                  backgroundColor: Colors.transparent,
                  minRadius: 20.w,
                )
              ],
              leftWidgets: [
                IconButton(icon: const Icon(Icons.menu), onPressed: () {})
              ],
              onLeftWidgetTap: () {},
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.w),
            buildJoinCreateButton(),
            SizedBox(height: 20.w),
            const Expanded(child: CardListScreen())
          ],
        ));
  }
}

Widget buildJoinCreateButton() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 22.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Button(
            text: 'Join',
            width: 130.w,
            height: 53.w,
            textCenter: true,
            textColor: Colors.grey.shade700,
            color: Colors.white,
            fontSize: 16.w,
            borderRadius: 12.w,
            // border: Border.all(color: Colors.grey.shade400, width: 2.w),
            onTap: () {}),
        Button(
            text: 'Create',
            width: 130.w,
            height: 53.w,
            textCenter: true,
            // textColor: Colors.grey.shade400,
            color: const Color(0xFF00C85C),
            fontSize: 16.w,
            borderRadius: 12.w,
            // border: Border.all(color: const Color(0xFF00C85C), width: 2.w),
            leftWidget: Icon(
              Icons.add,
              color: Colors.white,
              size: 24.w,
            ),
            onTap: () {}),
      ],
    ),
  );
}

class CardListScreen extends StatelessWidget {
  const CardListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> myList = [
      {
        'title': 'Player Name',
        'date': '12 Sep 2024',
        'url': 'https://i.pravatar.cc/50?img=',
        'commentCount': '5',
        'onTap': () {
          debugPrint('Player Name');
        }
      },
      {
        'title': 'Test Name',
        'date': '12 Sep 2024',
        'url': 'https://i.pravatar.cc/50?img=',
        'commentCount': '12',
        'onTap': () {
          debugPrint('Test');
        }
      },
      {
        'title': 'Working Name',
        'date': '12 Sep 2024',
        'url': 'https://i.pravatar.cc/50?img=',
        'commentCount': '02',
        'onTap': () {
          debugPrint('WOrking');
        }
      },
      {
        'title': 'Playing Name',
        'date': '12 Sep 2024',
        'url': 'https://i.pravatar.cc/50?img=',
        'commentCount': '45',
        'onTap': () {
          debugPrint('Playing');
        }
      },
    ];
    return AutoRefresh(
      duration: const Duration(seconds: 15),
      child: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 15.w),
          itemCount: myList.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(seconds: 3),
              child: SlideAnimation(
                verticalOffset: 44.0,
                child: FadeInAnimation(
                  child: Column(
                    children: [
                      PlayerDetailCard(
                        width: MediaQuery.of(context).size.width,
                        height: 200.w,
                        playerName: myList[index]['title'],
                        date: myList[index]['date'],
                        commentCount: myList[index]['commentCount'],
                        avatarUrls: myList[index]['url'],
                        onTap: myList[index]['onTap'],
                      ),
                      SizedBox(height: 15.w),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PlayerDetailCard extends StatelessWidget {
  final double? width;
  final double? height;
  final String playerName;
  final String date;
  final String avatarUrls;
  final String commentCount;
  final Function()? onTap;

  const PlayerDetailCard({
    super.key,
    this.width,
    this.height,
    required this.playerName,
    required this.date,
    required this.avatarUrls,
    required this.commentCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding:
            EdgeInsets.only(left: 15.w, right: 15.w, top: 20.w, bottom: 15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.w,
              offset: Offset(0, 4.w),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: playerName,
              fontSize: 18.w,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 15.w),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: Colors.grey.shade400,
                  size: 20.w,
                ),
                SizedBox(width: 7.w),
                TextWidget(
                  text: date,
                  fontSize: 14.w,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            SizedBox(height: 15.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Label(
                  text: 'Design',
                  isIcon: false,
                  onTap: () {},
                ),
                SizedBox(width: 12.w),
                Label(
                  text: 'Reseacrh',
                  textColor: Colors.pink,
                  labelColor: Colors.pink.shade50,
                  isIcon: false,
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 15.w),
            Row(
              children: [
                Expanded(child: HorizontalAvatar(url: avatarUrls)),
                Icon(
                  CupertinoIcons.conversation_bubble,
                  color: Colors.grey.shade400,
                  size: 20.w,
                ),
                SizedBox(width: 7.w),
                TextWidget(
                  text: commentCount,
                  color: Colors.grey.shade400,
                  fontSize: 16.w,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalAvatar extends StatelessWidget {
  final String url;
  const HorizontalAvatar({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final settings = RestrictedAmountPositions(
      maxAmountItems: 6,
      maxCoverage: 0.6,
      minCoverage: 0.25,
      align: StackAlign.left,
      laying: StackLaying.last,
      layoutDirection: LayoutDirection.horizontal,
    );
    return SizedBox(
      height: 35.w,
      child: WidgetStack(
        positions: settings,
        stackedWidgets: [
          for (var n = 0; n < 12; n++)
            Container(
              width: 35.w,
              height: 35.w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 2.w),
                borderRadius: BorderRadius.circular(8.5.w),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: Image.network('$url$n')),
            ),
        ],
        buildInfoWidget: (surplus) {
          return Container(
            width: 35.w,
            height: 35.w,
            decoration: BoxDecoration(
              color: Colors.pink.shade400,
              border: Border.all(color: Colors.white, width: 2.w),
              borderRadius: BorderRadius.all(Radius.circular(12.w)),
            ),
            child: Center(
              child: TextWidget(
                text: '$surplus+',
                color: Colors.white,
                fontSize: 15.w,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
      ),
    );
  }
}

class Label extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? labelColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final bool isIcon;
  final IconData? icon;
  final Color? iconBackgroungColor;
  final double? iconSize;
  final Function()? onTap;
  const Label(
      {super.key,
      required this.text,
      this.textColor,
      this.labelColor,
      required this.isIcon,
      this.fontSize,
      this.fontWeight,
      this.padding,
      this.icon,
      this.iconBackgroungColor,
      this.iconSize,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: padding ??
                EdgeInsets.only(left: 15.w, right: 15.w, top: 8.w, bottom: 8.w),
            decoration: BoxDecoration(
              color: labelColor ?? Colors.blue.shade100,
              borderRadius: BorderRadius.all(Radius.circular(25.w)),
            ),
            child: Row(children: [
              ...isIcon
                  ? [
                      Container(
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          color: iconBackgroungColor ?? Colors.blue.shade900,
                          borderRadius: BorderRadius.all(Radius.circular(45.w)),
                        ),
                        child: Icon(
                          icon ?? Icons.access_time_rounded,
                          color: Colors.white,
                          size: iconSize ?? 20.w,
                        ),
                      ),
                      SizedBox(width: 7.w),
                    ]
                  : [],
              TextWidget(
                text: text,
                fontSize: fontSize ?? 15.w,
                fontWeight: FontWeight.w700,
                color: textColor ?? Colors.blue.shade900,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

/// Automatically rebuild [child] widget after the given [duration]
class AutoRefresh extends StatefulWidget {
  final Duration duration;
  final Widget child;

  const AutoRefresh({
    super.key,
    required this.duration,
    required this.child,
  });

  @override
  State<AutoRefresh> createState() => _AutoRefreshState();
}

class _AutoRefreshState extends State<AutoRefresh> {
  int? keyValue;
  ValueKey? key;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    keyValue = 0;
    key = ValueKey(keyValue);

    _recursiveBuild();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }

  void _recursiveBuild() {
    _timer = Timer(
      widget.duration,
      () {
        setState(() {
          keyValue = keyValue! + 1;
          key = ValueKey(keyValue);
          _recursiveBuild();
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
