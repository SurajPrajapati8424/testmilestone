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
  Future<void> loadInterstitialAd(String adUnitId) async {
    InterstitialAd.load(
      adUnitId: adUnitId, // Test ad unit ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('Interstitial Loaded');
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
  Future<void> showInterstitialAd() async {
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
  // static RewardedAdService? _instance;
  RewardedAd? rewardedAd;
  // bool isAdLoaded = false;

  // Singleton pattern for easy access
  static final RewardedAdService instance = RewardedAdService._internal();
  factory RewardedAdService() => instance;
  RewardedAdService._internal();
  // Singleton pattern
  // static RewardedAdService get instance {
  //   _instance ??= RewardedAdService._();
  //   return _instance!;
  // }
  // RewardedAdService._();

  // Load a rewarded ad
  Future<void> loadRewardedAd({required String adUnitId}) async {
    RewardedAd.load(
      adUnitId: adUnitId, // Test ad unit ID
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          debugPrint('Rewarded loaded');
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
  Future<void> showRewardedAd(
      {required Function(num rewardAmount) onUserEarnedReward}) async {
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

// Native
class NativeAdSingleton {
  static final NativeAdSingleton _instance =
      NativeAdSingleton._internal(adUnitId: '');

  NativeAd? nativeAd;
  bool isAdLoaded = false;
  late String adUnitId;
  final ValueNotifier<bool> nativeNotifier = ValueNotifier(false);

  NativeAdSingleton._internal({required this.adUnitId});

  // Factory constructor to return the same instance with the same adUnitId
  factory NativeAdSingleton.instance(String adUnitId) {
    _instance.adUnitId = adUnitId;
    return _instance;
  }

  Future<void> initialize() async {
    // Call this during app startup
    await MobileAds.instance.initialize();
  }

  void loadAd(
      {required TemplateType templateType,
      required VoidCallback onAdLoaded,
      required VoidCallback onAdFailed}) {
    nativeAd = NativeAd(
      adUnitId: adUnitId,
      // factoryId: 'adFactoryExample',
      listener: NativeAdListener(onAdLoaded: (ad) {
        debugPrint('Native loaded');
        isAdLoaded = true;
        nativeNotifier.value = true;
        onAdLoaded();
      }, onAdFailedToLoad: (ad, error) {
        debugPrint('Native ad failed to load: ${error.message}');
        isAdLoaded = false;
        nativeNotifier.value = false;
        ad.dispose();
        onAdFailed();
      }, onAdClosed: (ad) {
        ad.dispose();
      }),
      request: const AdRequest(),
      // Optional: Customize the ad's style
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: templateType,
        mainBackgroundColor: Colors.deepPurple,
        cornerRadius: 10.w,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          backgroundColor: Colors.red,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.red,
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.normal,
          size: 16.0,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.red,
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.normal,
          size: 14.0,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.red,
          backgroundColor: Colors.transparent,
          style: NativeTemplateFontStyle.normal,
          size: 12.0,
        ),
      ),
    );
    nativeAd!.load();
  }

  Widget displayAd(
      {double minWidth = 320,
      double minHeight = 90,
      double width = 400,
      double height = 200}) {
    if (isAdLoaded && nativeAd != null) {
      return Container(
        constraints: BoxConstraints(minWidth: minWidth, minHeight: minHeight),
        width: width,
        height: height,
        child: AdWidget(ad: nativeAd!),
      );
    } else {
      return const SizedBox(); // or a placeholder
    }
  }

  void disposeAd() {
    nativeAd?.dispose();
    nativeAd = null;
    isAdLoaded = false;
    nativeNotifier.value = false;
  }
}
