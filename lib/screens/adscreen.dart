import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// banner(small & big), interstitial, rewarded & native ads

// Banner Ads
class ResponsiveBanner extends StatefulWidget {
  final String adUnitId;
  final AdSize adSize;
  const ResponsiveBanner(
      {super.key, required this.adUnitId, required this.adSize});
  @override
  State<ResponsiveBanner> createState() => BannerAdState();
}

class BannerAdState extends State<ResponsiveBanner> {
  BannerAd? bannerAd;
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    loadBannerAd();
  }

  void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: widget.adUnitId,
      size: widget.adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner ad failed to load: ${error.message}');
          ad.dispose();
        },
        onAdClosed: (ad) {
          bannerAd?.dispose();
        },
        onAdImpression: (ad) {},
        onAdOpened: (ad) {
          debugPrint("-> OPENED");
        },
      ),
    );
    // load the Ad
    bannerAd?.load();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: bannerAd!.size.width.toDouble().w,
      height: bannerAd!.size.height.toDouble().w,
      color: Colors.grey[200],
      child: isLoaded && bannerAd != null
          ? SafeArea(
              child: SizedBox(
                width: bannerAd!.size.width.toDouble().w,
                height: bannerAd!.size.height.toDouble().w,
                child: AdWidget(ad: bannerAd!),
              ),
            )
          : Center(
              child: SizedBox(
                height: 20.w,
                width: 20.w,
                child: const CircularProgressIndicator(
                  color: Color(0xFF00C85C),
                ),
              ),
            ),
    );
  }
}

/**
1. google_mobile_ads: ^5.2.0
2. Sample Ad Manager app ID: ca-app-pub-3940256099942544~3347511713 inside <application>
  <meta-data
      android:name="com.google.android.gms.ads.APPLICATION_ID"
      android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"/>
3. 


 https://admanager.google.com/

 */
/* // 5. Banner Ad Implementation Example
class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  BannerAdWidgetState createState() => BannerAdWidgetState();
}

class BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ad unit ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );

    bannerAd?.load();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        title: const Text('Ads'),
      ),
      body: Stack(
        children: [
          const TextWidget(
              text: 'This is Ad Screen', fontSize: 18, color: Colors.red),
          adpopup(context, isLoaded, bannerAd)
        ],
      ),
    );
  }
}

Widget adpopup(BuildContext context, bool isLoaded, BannerAd? bannerAd) {
  return AlertDialog(
      actions: [
        Button(
          text: 'close',
          onTap: () {
            Navigator.of(context).pop();
          },
        )
      ],
      content: isLoaded
          ? SizedBox(
              width: bannerAd!.size.width.toDouble(),
              height: bannerAd.size.height.toDouble(),
              child: AdWidget(ad: bannerAd),
            )
          : const SizedBox(
              height: 50,
              child: CircularProgressIndicator(
                color: Color(0xFF00C85C),
              ),
            ));
}
*/