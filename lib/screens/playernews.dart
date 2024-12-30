import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testmilestone/screens/profile.dart';
import 'package:testmilestone/widgets/button.dart';

import '../widgets/text.dart';
import 'playerstatus.dart';

class PlayerNews extends StatelessWidget {
  const PlayerNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 36.w),
              CustomAppBar(
                title: 'App Name',
                fontSize: 18.w,
                isBackButton: true,
                leftWidgets: const [],
                rightWidgets: [
                  IconButton(
                    icon: Icon(
                      Icons.search_outlined,
                      color: Colors.grey.shade700,
                      size: 25.w,
                    ),
                    onPressed: () {},
                  ),
                ],
                onLeftWidgetTap: () {},
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.w),
              SizedBox(height: 50.w, child: const CategoryLabel()),
              SizedBox(height: 15.w),
              const Expanded(child: RepeatMyCards()),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.w),
              child: Button(
                width: 190.w,
                height: 56.w,
                text: 'Create',
                leftWidget: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25.w,
                ),
                fontSize: 18.w,
                textCenter: true,
                textColor: Colors.white,
                color: const Color(0xFFFF5174),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.5),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
                onTap: () {
                  debugPrint('floating button');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryLabel extends StatelessWidget {
  const CategoryLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'label': 'News',
        'icon': Icons.article_outlined,
        'color': Colors.blue,
        'colorLight': Colors.blue.shade50,
        'onTap': () {
          debugPrint('News clicked');
        }
      },
      {
        'label': 'Video',
        'icon': Icons.videocam_sharp,
        'color': Colors.pink,
        'colorLight': Colors.pink.shade50,
        'onTap': () {
          debugPrint('Video clicked');
        }
      },
      {
        'label': 'Photos',
        'icon': Icons.photo_camera_back_rounded,
        'color': Colors.yellow.shade800,
        'colorLight': Colors.yellow.shade50,
        'onTap': () {
          debugPrint('Photos clicked');
        }
      },
      {
        'label': 'History',
        'icon': Icons.history,
        'color': Colors.purple,
        'colorLight': Colors.purple.shade50,
        'onTap': () {
          debugPrint('History clicked');
        }
      },
    ];

    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      separatorBuilder: (context, index) => SizedBox(width: 10.w),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Label(
          text: categories[index]['label'],
          isIcon: true,
          icon: categories[index]['icon'],
          textColor: categories[index]['color'],
          iconBackgroungColor: categories[index]['color'],
          labelColor: categories[index]['colorLight'],
          onTap: categories[index]['onTap'],
        );
      },
    );
  }
}

class RepeatMyCards extends StatelessWidget {
  const RepeatMyCards({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> list = [
      {
        'imageUrl':
            'https://s3-alpha-sig.figma.com/img/7a1d/1248/29ba25492701f28628a01fde7bc278d1?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=i~BaNmBXGxd~WEHCav87Lc1~uquBDowckqFr2p2QJRTiXlBJLZq-rdIEpbm7kPQ8JTxgskEHLH4nl0cmKEZbbfJAR3xX5laXrnzcqP0LE6Cz5DsbAj4REk6o4dIdeergfBwigYjRvyaJ-8I9is0Qx5n1NxajMxUd20xamV8wO0jwT-y-oUpQVypeoJEFI0mGwynkLUv0neBHRgokIVMaH9aVfi7DowBvHbM6ZAO6OaMk3Vg2yygA7AR7bQpPRFPsFKUnMBabxx-sb9Nt7i8fh3QCy8xt7Ka1PBaNySv6NghvaWovYQ1bJ1d3myAmyG2c7fBc4mbqHjw35q40o2JSpw__',
        'date': '12 Sep 2024',
        'title': 'Add onboarding in Travel booking app desin.',
        'description':
            'Add onboarding in Travel booking app desin. Travel booking app desin Add onboarding  desin Add onboarding in Travel in Travel.',
        'authorName': 'Blanca Hill',
        'authorImageUrl': 'https://i.pravatar.cc/150?img=2',
        'commentCount': 3,
        'onTap': () {
          print('card 01');
        }
      },
      {
        'imageUrl': '',
        'date': '10 Dec 2024',
        'title': 'Add onboarding in Travel booking app desin.',
        'description':
            'Add onboarding in Travel booking app desin. Travel booking app desin Add onboarding  desin Add onboarding in Travel in Travel.',
        'authorName': 'Blanca Hill',
        'authorImageUrl': 'https://i.pravatar.cc/150?img=8',
        'commentCount': 24,
        'onTap': () {
          print('card 02');
        }
      },
      {
        'imageUrl':
            'https://s3-alpha-sig.figma.com/img/7a1d/1248/29ba25492701f28628a01fde7bc278d1?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=i~BaNmBXGxd~WEHCav87Lc1~uquBDowckqFr2p2QJRTiXlBJLZq-rdIEpbm7kPQ8JTxgskEHLH4nl0cmKEZbbfJAR3xX5laXrnzcqP0LE6Cz5DsbAj4REk6o4dIdeergfBwigYjRvyaJ-8I9is0Qx5n1NxajMxUd20xamV8wO0jwT-y-oUpQVypeoJEFI0mGwynkLUv0neBHRgokIVMaH9aVfi7DowBvHbM6ZAO6OaMk3Vg2yygA7AR7bQpPRFPsFKUnMBabxx-sb9Nt7i8fh3QCy8xt7Ka1PBaNySv6NghvaWovYQ1bJ1d3myAmyG2c7fBc4mbqHjw35q40o2JSpw__',
        'date': '12 Sep 2024',
        'title': 'Add onboarding in Travel booking app desin.',
        'description':
            'Add onboarding in Travel booking app desin. Travel booking app desin Add onboarding  desin Add onboarding in Travel in Travel.',
        'authorName': 'Blanca Hill',
        'authorImageUrl': 'https://i.pravatar.cc/150?img=2',
        'commentCount': 3,
        'onTap': () {
          print('card 03');
        }
      },
    ];
    return ListView.builder(
      // separatorBuilder: (context, index) => SizedBox(height: 15.w),
      itemCount: list.length,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              MyCards(
                imageUrl: list[index]['imageUrl'],
                date: list[index]['date'],
                title: list[index]['title'],
                description: list[index]['description'],
                authorName: list[index]['authorName'],
                authorImageUrl: list[index]['authorImageUrl'],
                commentCount: list[index]['commentCount'],
                onTap: list[index]['onTap'],
              ),
              SizedBox(height: 15.w),
            ],
          ),
        );
      },
    );
  }
}

class MyCards extends StatelessWidget {
  final String? imageUrl;
  final String date;
  final String title;
  final String description;
  final String authorName;
  final String authorImageUrl;
  final int commentCount;
  final Function()? onTap;
  const MyCards(
      {super.key,
      this.imageUrl,
      required this.date,
      required this.title,
      required this.description,
      required this.authorName,
      required this.authorImageUrl,
      required this.commentCount,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8.w,
                offset: Offset(0, 5.w),
              ),
            ]),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            children: [
              if (imageUrl != null && imageUrl!.isNotEmpty) ...[
                SizedBox(height: 10.w),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.w),
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error, color: Colors.red),
                        );
                      },
                    ),
                  ),
                ),
              ],
              SizedBox(height: 10.w),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: Colors.grey.shade400,
                    size: 22.w,
                  ),
                  SizedBox(width: 7.w),
                  TextWidget(
                    text: date,
                    fontSize: 13.w,
                    color: Colors.black26,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(height: 10.w),
              TextWidget(
                text: title,
                color: Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 10.w),
              TextWidget(
                text: description,
                color: Colors.black26,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 10.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9.w),
                    child: Image.network(
                      authorImageUrl,
                      height: 30.w,
                      width: 30.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 35.w,
                          width: 35.w,
                          color: Colors.grey[300],
                          child: Icon(Icons.person, color: Colors.grey[600]),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  TextWidget(
                    text: authorName,
                    color: Colors.black26,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  Expanded(child: Container()),
                  Icon(
                    CupertinoIcons.conversation_bubble,
                    color: Colors.grey.shade400,
                    size: 20.w,
                  ),
                  SizedBox(width: 7.w),
                  TextWidget(
                    text: '$commentCount',
                    color: Colors.grey.shade400,
                    fontSize: 18.w,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
