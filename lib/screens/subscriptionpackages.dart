import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testmilestone/widgets/text.dart';

import '../function/darkencolor.dart';
import '../widgets/button.dart';

class SubscriptionPlanScreen extends StatelessWidget {
  const SubscriptionPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  'https://s3-alpha-sig.figma.com/img/f970/d431/5acd7486cc05be6d2cf62aa420535749?Expires=1737331200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=aqkeBOZumzDHCO8mR4wF-yYFWHwg2qkLIK775IW7RgLBezI4Bm3GSJYwMRCVeJaskMpvI~bvqS6cypUo~boPDtxSiexO2BRovUiuy8eLld7YHKuZu8ogPZBBk~JvYSfKYdpbV97sntEbO03hA4zu4ZcJI7GAEVHv1JSwQ~0W8UST-SOJT1HDkf481PHbPb~Rqup62oM-wSjpQ9UOxMbmEMiwKKtIxW2zCVPvCJLMClzzLBvVzGxjQGfrcpHTaUZoFfvydu6SBc662EKzbJPiheOot1I8~5WmYPmMYD-yoHdcHTCOrdQZuzDkR4hr7cFVBnWKq9XHiZGsBb1OozNXIA__',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 24.w),

                    // Title
                    TextWidget(
                      text:
                          'Enhance your Quiz \n–– Go Pro for Exclusive Benefits!',
                      fontSize: 25.w,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),

                    SizedBox(height: 24.w),

                    // Benefits
                    buildBenefitItem('Unique gourmet recipes'),
                    buildBenefitItem('Advanced nutritional insights'),
                    buildBenefitItem('Personalized support from our Chef'),

                    SizedBox(height: 32.w),
                    // Subscription Options
                    const PackageList(),
                    SizedBox(height: 32.w),

                    // Continue Button
                    SizedBox(height: 32.w),
                    Button(
                      width: MediaQuery.of(context).size.width,
                      text: 'Continue',
                      color: const Color(0xFF00C85C),
                      onTap: () {},
                    ),
                    SizedBox(height: 15.w),
                    Button(
                      width: MediaQuery.of(context).size.width,
                      text: 'Restore',
                      color: Colors.transparent,
                      textCenter: true,
                      textColor: Colors.black,
                      padding: EdgeInsets.zero,
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBenefitItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.w),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.checkmark_alt,
            color: const Color(0xFF00C85C),
            size: 25.w,
          ),
          SizedBox(width: 7.w),
          TextWidget(
            text: text,
            color: Colors.black,
            fontSize: 15.w,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}

class PackageList extends StatefulWidget {
  const PackageList({super.key});

  @override
  State<PackageList> createState() => PackageListState();
}

class PackageListState extends State<PackageList> {
  int primary = 2;
  Map<String, dynamic> selectedData = {
    'period': '1 Year',
    'price': '30.0',
    'index': 2
  };
  void selectPackage(int index, String period, String price) {
    setState(() {
      primary = index;
      selectedData = {'period': period, 'price': price, 'index': index};
      debugPrint(selectedData.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PackageCard(
          title: '1 Month',
          description: 'Full access for just \$2.99/mo',
          price: '2.99',
          isSelected: primary == 0,
          onSelect: () => selectPackage(0, '1 Month', '2.99'),
        ),
        PackageCard(
          title: '3 Months',
          description: 'Full access for just \$7.99/mo',
          price: '7.99',
          isSelected: primary == 1,
          onSelect: () => selectPackage(1, '3 Months', '7.99'),
        ),
        PackageCard(
          title: '1 Year',
          description: 'Full access for just \$30.0/yr',
          price: '30.0',
          discount: '33% OFF',
          isSelected: primary == 2,
          onSelect: () => selectPackage(2, '1 Year', '30'),
        ),
      ],
    );
  }
}

class PackageCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final bool isSelected;
  final String? discount;
  final VoidCallback onSelect;
  const PackageCard(
      {super.key,
      required this.title,
      required this.description,
      required this.isSelected,
      this.discount,
      required this.price,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding:
            EdgeInsets.only(left: 15.w, right: 20.w, top: 10.w, bottom: 10.w),
        margin: EdgeInsets.only(bottom: 12.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15.w),
          border: Border(
            left: BorderSide(
                width: 2.2.w,
                color: isSelected
                    ? const Color(0xFF00C85C)
                    : darkenColor(Colors.white)),
            right: BorderSide(
                width: 2.2.w,
                color: isSelected
                    ? const Color(0xFF00C85C)
                    : darkenColor(Colors.white)),
            top: BorderSide(
                width: 2.2.w,
                color: isSelected
                    ? const Color(0xFF00C85C)
                    : darkenColor(Colors.white)),
            bottom: BorderSide(
                width: 5,
                color: isSelected
                    ? const Color(0xFF00C85C)
                    : darkenColor(Colors.white)),
          ),
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 22.w,
                      height: 22.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? const Color(0xFF00C85C)
                            : Colors.grey.withOpacity(0.4),
                      ),
                    ),
                    SizedBox(width: 7.w),
                    TextWidget(
                      text: title,
                      fontSize: 16.w,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                SizedBox(height: 5.w),
                TextWidget(
                  text: description,
                  fontSize: 14.w,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            const Spacer(),
            if (discount != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.w),
                decoration: BoxDecoration(
                    color: const Color(0xFF00C85C),
                    borderRadius: BorderRadius.circular(15.w),
                    border: Border(
                        bottom: BorderSide(
                            width: 5.w,
                            color: darkenColor(const Color(0xFF00C85C))))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidget(
                      text: '\$ 99',
                      color: Colors.white,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 3.w),
                    TextWidget(
                      text: '(33% OFF)',
                      color: Colors.white,
                      fontSize: 12.w,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              )
            else
              TextWidget(
                text: '\$ $price',
                fontSize: 16.w,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
          ],
        ),
      ),
    );
  }
}
