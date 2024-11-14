import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/inputfield.dart';
import '../widgets/text.dart';
import 'profile.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

final List<Map<String, dynamic>> imgApi = [
  {
    'name': 'Study',
    'imgUrl':
        'https://img.freepik.com/premium-photo/teenager-student-girl-yellow_1368-37801.jpg?w=740',
    'blurHash': '',
  },
  {
    'name': 'Car',
    'imgUrl':
        'https://img.freepik.com/free-photo/yellow-car-with-number-70-side_1340-23401.jpg?t=st=1726166378~exp=1726169978~hmac=2e8bec878c6b9852ddb8f21396ee46201d09e9af01948cf21ae2ff2e3614adaf&w=740',
    'blurHash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
  },
  {
    'name': 'Planet',
    'imgUrl':
        'https://www.marinedealnews.com/wp-content/uploads/2023/01/cropped-yuce-yoney-200x200.jpeg',
    'blurHash': 'LGF5]+Yk^6#M@-5c,1J5@[or[Q6.',
  },
  {
    'name': 'Quiz',
    'imgUrl':
        'https://th-i.thgim.com/public/education/2k3md8/article37987957.ece/alternates/FREE_1200/20EPBSPage2RCMReddyjpg',
    'blurHash': 'L6PZfSi_.AyE_3t7t7R**0o#DgR4',
  },
  {
    'name': 'Sport',
    'imgUrl':
        'https://img.freepik.com/premium-photo/female-professional-volleyball-players-action-3d-stadium_654080-1060.jpg?w=900',
    'blurHash': 'LKN]Rv%2Tw=w]~RBVZRi};RPxuwH',
  },
  {
    'name': 'Study',
    'imgUrl':
        'https://img.freepik.com/premium-photo/teenager-student-girl-yellow_1368-37801.jpg?w=740',
    'blurHash': '',
  },
  {
    'name': 'Car',
    'imgUrl':
        'https://img.freepik.com/free-photo/yellow-car-with-number-70-side_1340-23401.jpg?t=st=1726166378~exp=1726169978~hmac=2e8bec878c6b9852ddb8f21396ee46201d09e9af01948cf21ae2ff2e3614adaf&w=740',
    'blurHash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
  },
  {
    'name': 'Planet',
    'imgUrl':
        'https://www.marinedealnews.com/wp-content/uploads/2023/01/cropped-yuce-yoney-200x200.jpeg',
    'blurHash': 'LGF5]+Yk^6#M@-5c,1J5@[or[Q6.',
  },
  {
    'name': 'Quiz',
    'imgUrl':
        'https://th-i.thgim.com/public/education/2k3md8/article37987957.ece/alternates/FREE_1200/20EPBSPage2RCMReddyjpg',
    'blurHash': 'L6PZfSi_.AyE_3t7t7R**0o#DgR4',
  },
  {
    'name': 'Sport',
    'imgUrl':
        'https://img.freepik.com/premium-photo/female-professional-volleyball-players-action-3d-stadium_654080-1060.jpg?w=900',
    'blurHash': 'LKN]Rv%2Tw=w]~RBVZRi};RPxuwH',
  },
  {
    'name': 'Study',
    'imgUrl':
        'https://img.freepik.com/premium-photo/teenager-student-girl-yellow_1368-37801.jpg?w=740',
    'blurHash': '',
  },
  {
    'name': 'Car',
    'imgUrl':
        'https://img.freepik.com/free-photo/yellow-car-with-number-70-side_1340-23401.jpg?t=st=1726166378~exp=1726169978~hmac=2e8bec878c6b9852ddb8f21396ee46201d09e9af01948cf21ae2ff2e3614adaf&w=740',
    'blurHash': 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
  },
  {
    'name': 'Planet',
    'imgUrl':
        'https://www.marinedealnews.com/wp-content/uploads/2023/01/cropped-yuce-yoney-200x200.jpeg',
    'blurHash': 'LGF5]+Yk^6#M@-5c,1J5@[or[Q6.',
  },
  {
    'name': 'Quiz',
    'imgUrl':
        'https://th-i.thgim.com/public/education/2k3md8/article37987957.ece/alternates/FREE_1200/20EPBSPage2RCMReddyjpg',
    'blurHash': 'L6PZfSi_.AyE_3t7t7R**0o#DgR4',
  },
  {
    'name': 'Sport',
    'imgUrl':
        'https://img.freepik.com/premium-photo/female-professional-volleyball-players-action-3d-stadium_654080-1060.jpg?w=900',
    'blurHash': 'LKN]Rv%2Tw=w]~RBVZRi};RPxuwH',
  },
];

class AddImageScreen extends StatelessWidget {
  const AddImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                // AppBar
                CustomAppBar(
                  title: 'Add Image',
                  fontSize: 21.w,
                  isBackButton: false,
                  leftWidgets: [
                    Icon(
                      Icons.close,
                      size: 24.25.w,
                    )
                  ],
                  onLeftWidgetTap: () {
                    debugPrint('Clicked');
                  },
                  rightWidgets: [],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      // Search Bar
                      const SerachBar(),
                      // Tabs
                      SizedBox(height: 20.w),
                      const Tabs(),
                      // Images
                      SizedBox(height: 5.w),
                      ImageWindow(imgApi: imgApi),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SerachBar extends StatelessWidget {
  const SerachBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        height: 49.w,
        decoration: BoxDecoration(
            color: const Color(0xFF00C85C).withOpacity(0.1),
            borderRadius: BorderRadius.circular(18.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.search_outlined,
              size: 22.w,
              color: const Color(0xFF00C85C),
            ),
            SizedBox(width: 7.w),
            Center(
              child: SizedBox(
                width: 250.w,
                child: AnswerInputWidget(
                  hintText: 'Search for images here',
                  textColor: const Color(0xFF00C85C),
                  fontSize: 16.w,
                  fontWeight: FontWeight.w700,
                  isCenter: false,
                  hasDivider: false,
                  maxLines: 1,
                  maxLength: 60,
                  onChanged: (val) {
                    debugPrint(val);
                  },
                ),
              ),
            )
          ],
        ));
  }
}

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 34.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF00C85C),
              border: Border.all(width: 1.75.w, color: const Color(0xFF00C85C)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26.25.w),
              ),
            ),
            child: TextWidget(
              text: 'Images',
              textAlign: TextAlign.center,
              color: Colors.white,
              fontSize: 15.25.w,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 34.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.75.w, color: const Color(0xFF00C85C)),
            ),
            child: TextWidget(
              text: 'Pick Media',
              textAlign: TextAlign.center,
              color: const Color(0xFF00C85C),
              fontSize: 15.25.w,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 34.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.75.w, color: const Color(0xFF00C85C)),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(26.25.w),
              ),
            ),
            child: TextWidget(
              text: 'Camera',
              textAlign: TextAlign.center,
              color: const Color(0xFF00C85C),
              fontSize: 15.25.w,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class ImageWindow extends StatelessWidget {
  final List<Map<String, dynamic>> imgApi;
  const ImageWindow({super.key, required this.imgApi});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.w,
        childAspectRatio: 1.5575.w,
      ),
      itemCount: imgApi.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> items = imgApi[index];
        return GestureDetector(
          onTap: () {
            debugPrint(items['name']);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.w),
            child: BlurHash(
              hash: items['blurHash'],
              image: items['imgUrl'],
              imageFit: BoxFit.cover,
              duration: const Duration(milliseconds: 500),
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.error, color: Colors.red),
              ),
            ),
            // Image.network(
            //   items['imgUrl'],
            //   fit: BoxFit.cover,
            //   errorBuilder: (context, error, stackTrace) => const Center(
            //     child: Icon(Icons.error, color: Colors.red),
            //   ),
            // ),
          ),
        );
      },
    );
  }
}
