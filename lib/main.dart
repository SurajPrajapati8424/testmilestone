import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testmilestone/screens/adscreen.dart';

import 'function/webview.dart';
import 'screens/nointernet.dart';
import 'screens/playaudio.dart';
import 'screens/rating.dart';
import 'screens/richtexteditor.dart';
import 'screens/safetextscreen.dart';
import 'screens/slidetoastscreen.dart';
import 'screens/wordcloud.dart';
import 'widgets/button.dart';

import 'function/download.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    const ScreenUtilInit(
      designSize: Size(360, 752),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MileStone',
      theme: ThemeData(
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/rating": (context) => const RatingPage(),
        "/playaudio": (context) => const PlayAudioScreen(),
        "/word": (context) => const Wordcloud(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // test ads
                const Align(
                  alignment: Alignment.topCenter,
                  child: ResponsiveBanner(
                    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
                    adSize: AdSize.fullBanner,
                  ),
                ),
                Container(
                  child: ValueListenableBuilder(
                    valueListenable: NativeAdSingleton.instance(
                            'ca-app-pub-3940256099942544/2247696110')
                        .nativeNotifier,
                    builder: (context, isAdLoaded, child) {
                      if (isAdLoaded) {
                        return NativeAdSingleton.instance(
                                'ca-app-pub-3940256099942544/2247696110')
                            .displayAd(
                          width: 400,
                          height: 350,
                          // for Medium
                          //minWidth: 320,minHeight: 320,maxWidth: 400,maxHeight: 400
                        );
                      } else {
                        return const CircularProgressIndicator(); // Loading indicator
                      }
                    },
                  ),
                ),
                //
                Wrap(
                  children: [
                    Button(
                      text: 'play',
                      onTap: () {
                        Navigator.pushNamed(context, '/playaudio');
                      },
                    ),
                    Button(
                      text: 'rate',
                      onTap: () {
                        Navigator.pushNamed(context, '/rating');
                      },
                    ),
                    Button(
                      text: 'wordcloud',
                      onTap: () {
                        Navigator.pushNamed(context, '/word');
                      },
                    ),
                    Button(
                      text: 'download',
                      onTap: () async {
                        const urlOrString = 'suraj';
                        String fileName = 'tech';
                        String extensionName = 'csv';
                        // const urlOrString =
                        //     'https://wsform.com/wp-content/uploads/2021/04/day.csv';
                        await downloadFile(
                            urlOrString, fileName, extensionName);
                      },
                    ),
                    Button(
                      text: 'No Internet',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NoInternetScreen(),
                        ),
                      ),
                    ),
                    Button(
                      text: 'Word Doc',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WordDoc(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          text: 'init Interstitial',
                          onTap: () {
                            // Interstitial
                            InterstitialAdWidget().loadInterstitialAd(
                                'ca-app-pub-3940256099942544/1033173712');
                          },
                        ),
                        Button(
                          text: 'show Interstitial',
                          onTap: () {
                            //  Show interstitial ad
                            InterstitialAdWidget().showInterstitialAd();
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          text: 'open in Chrome',
                          onTap: () async {
                            await Browser().open(url: 'https://flutter.dev');
                          },
                        ),
                        Button(
                          text: 'open in App',
                          onTap: () {
                            // showQuestionOption(context, 'https://youtube.com');
                            openInAppWebView(context, 'https://youtube.com');
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          text: 'init Reward',
                          onTap: () async {
                            // Init Reward
                            await RewardedAdService().loadRewardedAd(
                                adUnitId:
                                    'ca-app-pub-3940256099942544/5224354917');
                          },
                        ),
                        Button(
                          text: 'show Reward',
                          onTap: () async {
                            //  Show Reward ad
                            await RewardedAdService().showRewardedAd(
                                onUserEarnedReward: (val) {
                              debugPrint('rewards is :$val');
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          text: 'init Native',
                          onTap: () {
                            // Init Native
                            NativeAdSingleton.instance(
                                    'ca-app-pub-3940256099942544/2247696110')
                                .loadAd(
                                    templateType: TemplateType.medium,
                                    onAdLoaded: () {},
                                    onAdFailed: () {});
                          },
                        ),
                        Button(
                          text: 'dispose Native',
                          onTap: () async {
                            NativeAdSingleton.instance(
                                    'ca-app-pub-3940256099942544/2247696110')
                                .disposeAd();
                          },
                        ),
                      ],
                    ),
                    Button(
                        text: 'Sliding Toast',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SlidingToast()))),
                    Button(
                        text: 'Safe Text',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SafetextScreen()))),
                  ],
                ),

                // // test
                // NativeBasicAd(
                //   adUnitId: 'ca-app-pub-3940256099942544/2247696110',
                //   templateType: TemplateType.medium,
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
