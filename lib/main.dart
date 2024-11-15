import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testmilestone/screens/adscreen.dart';

import 'function/countdown.dart';
import 'function/webview.dart';
import 'screens/achievementandlogout.dart';
import 'screens/adblockscreen.dart';
import 'screens/addimagescreen.dart';
import 'screens/animatedtextScreen.dart';
import 'screens/blurhashscreen.dart';
import 'screens/feedbackscreen.dart';
import 'screens/nointernet.dart';
import 'screens/playaudio.dart';
import 'screens/popuppremiumcontent.dart';
import 'screens/profile.dart';
import 'screens/rating.dart';
import 'screens/readmorescreen.dart';
import 'screens/richtexteditor.dart';
import 'screens/safetextscreen.dart';
import 'screens/slidetoastscreen.dart';
import 'screens/textgradientscreen.dart';
import 'screens/wordcloud.dart';
import 'widgets/button.dart';

import 'function/download.dart';
import 'package:feedback/feedback.dart';

import 'widgets/text.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    const ScreenUtilInit(
      designSize: Size(360, 752),
      child: BetterFeedback(child: MyApp()),
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
                ValueListenableBuilder(
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
                // FUNCTION
                const TextWidget(text: 'FUNCTION', color: Colors.black),
                const DividerWidget(thickness: 2),
                const SizedBox(height: 5),
                Wrap(children: [
                  Button(
                      text: 'play',
                      onTap: () {
                        Navigator.pushNamed(context, '/playaudio');
                      }),
                  Button(
                    text: 'download',
                    onTap: () async {
                      const urlOrString = 'suraj';
                      String fileName = 'tech';
                      String extensionName = 'csv';
                      // const urlOrString =
                      //     'https://wsform.com/wp-content/uploads/2021/04/day.csv';
                      await downloadFile(urlOrString, fileName, extensionName);
                    },
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
                    text: 'open in Chrome',
                    onTap: () async {
                      await Browser().open(url: 'https://flutter.dev');
                    },
                  ),
                ]),
                // PAGES
                const TextWidget(text: 'PAGES', color: Colors.black),
                const DividerWidget(thickness: 2),
                const SizedBox(height: 5),
                Wrap(
                  children: [
                    Button(
                      text: 'open in App',
                      onTap: () {
                        // showQuestionOption(context, 'https://youtube.com');
                        openInAppWebView(context, 'https://youtube.com');
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
                      text: 'No Internet screen',
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
                    Button(
                        text: 'Ad Block',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdblockScreen()))),
                    Button(
                        text: 'Blur Hash',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BlurHashApp()))),
                    Button(
                        text: 'Premium Content',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PopupPremiumContent()))),
                    Button(
                        text: 'Achievement And Logout',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AchievementAndLogout()))),
                    Button(
                        text: 'Profile',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilePage()))),
                    Button(
                        text: 'Add Image',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddImageScreen()))),
                    Button(
                        text: 'Feedback',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FeedbackScreen()))),
                    const TextWidget(
                        text: '[ TEXT',
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                    Button(
                        text: 'Read More',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DemoApp()))),
                    Button(
                        text: 'Animated Text',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AnimatedTextScreen()))),
                    Button(
                        text: 'Gradient Text',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TextGradientScreen()))),
                    Button(
                        text: 'CountDown',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CountDownPage()))),
                    const TextWidget(
                        text: 'TEXT ]',
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
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
