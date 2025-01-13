import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Models
class SubscriptionPackage {
  final String title;
  final String description;
  final double price;
  final String? discount;
  final String period;

  const SubscriptionPackage({
    required this.title,
    required this.description,
    required this.price,
    this.discount,
    required this.period,
  });
}

class SubscriptionPlanScreenBkp extends StatelessWidget {
  const SubscriptionPlanScreenBkp({super.key});

  static const List<String> benefits = [
    'Unique gourmet recipes',
    'Advanced nutritional insights',
    'Personalized support from our Chef',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header Image
            SliverToBoxAdapter(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  'YOUR_IMAGE_URL',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.image_not_supported, size: 50.w),
                  ),
                ),
              ),
            ),

            // Content
            SliverPadding(
              padding: EdgeInsets.all(15.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 24.w),
                  _buildTitle(),
                  SizedBox(height: 24.w),
                  _buildBenefitsList(),
                  SizedBox(height: 32.w),
                  const PackageList(),
                  SizedBox(height: 32.w),
                  _buildButtons(context),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Enhance your Quiz\n–– Go Pro for Exclusive Benefits!',
      style: TextStyle(
        fontSize: 25.w,
        color: Colors.black,
        fontWeight: FontWeight.w900,
        height: 1.2,
      ),
    );
  }

  Widget _buildBenefitsList() {
    return Column(
      children: benefits.map((benefit) => _BenefitItem(text: benefit)).toList(),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _handleSubscription(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00C85C),
            minimumSize: Size(MediaQuery.of(context).size.width, 50.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.w),
            ),
          ),
          child: Text(
            'Continue',
            style: TextStyle(
              fontSize: 16.w,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 15.w),
        TextButton(
          onPressed: () => _handleRestore(context),
          child: Text(
            'Restore Purchase',
            style: TextStyle(
              fontSize: 16.w,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSubscription(BuildContext context) async {
    // Implement subscription logic
    try {
      // Add your subscription handling code here
    } catch (e) {
      _showError(context, 'Subscription failed. Please try again.');
    }
  }

  Future<void> _handleRestore(BuildContext context) async {
    // Implement restore purchase logic
    try {
      // Add your restore purchase handling code here
    } catch (e) {
      _showError(context, 'Restore failed. Please try again.');
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final String text;

  const _BenefitItem({required this.text});

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.w,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PackageList extends StatefulWidget {
  const PackageList({super.key});

  @override
  State<PackageList> createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  final List<SubscriptionPackage> packages = const [
    SubscriptionPackage(
      title: '1 Month',
      description: 'Full access for just \$2.99/mo',
      price: 2.99,
      period: '1 Month',
    ),
    SubscriptionPackage(
      title: '3 Months',
      description: 'Full access for just \$7.99/mo',
      price: 7.99,
      period: '3 Months',
    ),
    SubscriptionPackage(
      title: '1 Year',
      description: 'Full access for just \$30.0/yr',
      price: 30.0,
      period: '1 Year',
      discount: '33% OFF',
    ),
  ];

  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        packages.length,
        (index) => PackageCard(
          package: packages[index],
          isSelected: selectedIndex == index,
          onSelect: () => setState(() => selectedIndex = index),
        ),
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final SubscriptionPackage package;
  final bool isSelected;
  final VoidCallback onSelect;

  const PackageCard({
    super.key,
    required this.package,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
        margin: EdgeInsets.only(bottom: 12.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15.w),
          border: Border.all(
            color: isSelected ? const Color(0xFF00C85C) : Colors.grey.shade300,
            width: 2.w,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF00C85C).withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildSelectionIndicator(),
                      SizedBox(width: 7.w),
                      Text(
                        package.title,
                        style: TextStyle(
                          fontSize: 16.w,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.w),
                  Text(
                    package.description,
                    style: TextStyle(
                      fontSize: 14.w,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (package.discount != null)
              _buildDiscountBadge()
            else
              _buildPrice(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator() {
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isSelected ? const Color(0xFF00C85C) : Colors.grey.withOpacity(0.4),
        border: Border.all(
          color: isSelected ? const Color(0xFF00C85C) : Colors.transparent,
          width: 2.w,
        ),
      ),
      child: isSelected
          ? Icon(
              Icons.check,
              size: 16.w,
              color: Colors.white,
            )
          : null,
    );
  }

  Widget _buildDiscountBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF00C85C),
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '\$${package.price}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.w,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 3.w),
          Text(
            package.discount!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.w,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrice() {
    return Text(
      '\$${package.price}',
      style: TextStyle(
        fontSize: 16.w,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
