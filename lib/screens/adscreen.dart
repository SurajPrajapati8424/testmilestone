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

// Interstitial
class InterstitialAdWidget {
  InterstitialAd? interstitialAd;
  bool isAdLoaded = false;

  // Singleton pattern for easy access
  static final InterstitialAdWidget instance = InterstitialAdWidget._internal();
  factory InterstitialAdWidget() => instance;
  InterstitialAdWidget._internal();

  /// Load an interstitial ad
  void loadInterstitialAd(String adUnitId) {
    InterstitialAd.load(
      adUnitId: adUnitId, // Test ad unit ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          isAdLoaded = true;
          interstitialAd?.setImmersiveMode(true); // Optional immersive mode

          // Handle events on full-screen content
          interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              isAdLoaded = false;
              // Load a new ad after the current one is closed
              // loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              ad.dispose();
              isAdLoaded = false;
              debugPrint('Failed to show interstitial ad: $error');
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Interstitial ad failed to load: $error');
          isAdLoaded = false;
        },
      ),
    );
  }

  /// Show the interstitial ad if loaded
  void showInterstitialAd() {
    if (isAdLoaded && interstitialAd != null) {
      interstitialAd?.show();
      isAdLoaded = false; // Reset the flag after showing the ad
    } else {
      debugPrint('Interstitial ad not ready yet');
    }
  }

  /// Dispose of the interstitial ad
  void dispose() {
    interstitialAd?.dispose();
  }
}

// Rewarded
class RewardedAdService {
  RewardedAd? rewardedAd;
  // bool isAdLoaded = false;

  // Singleton pattern for easy access
  static final RewardedAdService instance = RewardedAdService._internal();
  factory RewardedAdService() => instance;
  RewardedAdService._internal();

  /// Load a rewarded ad
  void loadRewardedAd({required String adUnitId}) {
    RewardedAd.load(
      adUnitId: adUnitId, // Test ad unit ID
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
          // isAdLoaded = true;

          // Set up full-screen content callback to handle events
          rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              ad.dispose();
              // isAdLoaded = false;
              loadRewardedAd(
                  adUnitId:
                      adUnitId); // Load a new ad after the current one is closed
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              ad.dispose();
              // isAdLoaded = false;
              debugPrint('Failed to show rewarded ad: $error');
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Rewarded ad failed to load: $error');
          // isAdLoaded = false;
        },
      ),
    );
  }

  // Show the rewarded ad and handle the reward
  void showRewardedAd(
      {required Function(num rewardAmount) onUserEarnedReward}) {
    if (/*isAdLoaded &&*/ rewardedAd != null) {
      rewardedAd?.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          onUserEarnedReward(reward.amount); // Pass the reward amount
        },
      );
      // isAdLoaded = false; // Reset the flag after showing the ad
    } else {
      debugPrint('Rewarded ad not ready yet');
    }
  }

  /// Dispose of the rewarded ad
  void dispose() {
    rewardedAd?.dispose();
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