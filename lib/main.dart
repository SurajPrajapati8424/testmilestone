// ignore_for_file: unused_import, avoid_print
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testmilestone/screens/adscreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'function/countdown.dart';
import 'function/webview.dart';
import 'screens/achievementandlogout.dart';
import 'screens/adblockscreen.dart';
import 'screens/addimagescreen.dart';
import 'screens/animatedtextScreen.dart';
import 'screens/appUpdate.dart';
import 'screens/blurhashscreen.dart';
import 'screens/cardswiper.dart';
import 'screens/chiclet_button.dart';
import 'screens/deviceinfo.dart';
import 'screens/face_camera.dart';
import 'screens/feedbackscreen.dart';
import 'screens/fl_chart.dart';
import 'screens/flutteranimationscreen.dart';
import 'screens/focusonit.dart';
import 'screens/geoscreen.dart';
import 'screens/logger.dart';
import 'screens/no_screenshot.dart';
import 'screens/nointernet.dart';
import 'screens/permissionguardscreen.dart';
import 'screens/playaudio.dart';
import 'screens/popscopescreen.dart';
import 'screens/popuppremiumcontent.dart';
import 'screens/profile.dart';
import 'screens/quiz_setting.dart';
import 'screens/rating.dart';
import 'screens/readmorescreen.dart';
import 'screens/richtexteditor.dart';
import 'screens/safetextscreen.dart';
// import 'screens/secure_app.dart';
import 'screens/slidetoastscreen.dart';
import 'screens/smoothsheet.dart';
import 'screens/staggeredscreen.dart';
import 'screens/starsviewscreen.dart';
import 'screens/textgradientscreen.dart';
import 'screens/textroundedscreen.dart';
import 'screens/timepickerscreen.dart';
import 'screens/tooltipscreen.dart';
import 'screens/versionCheck.dart';
import 'screens/widget_and_text_animator.dart';
import 'screens/wordcloud.dart';
import 'screens/wordcloud2.dart';
import 'widgets/button.dart';
import 'function/download.dart';
import 'package:feedback/feedback.dart';
import 'widgets/text.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await FaceCamera.initialize();

  // QuickSettings.setup(
  //   onTileClicked: onTileClicked,
  //   onTileAdded: onTileAdded,
  //   onTileRemoved: onTileRemoved,
  // );

  runApp(
    const ScreenUtilInit(
      designSize: Size(360, 752),
      child: BetterFeedback(child: MyApp()),
    ),
  );
}

// @pragma("vm:entry-point")
// Tile onTileClicked(Tile tile) {
//   final oldStatus = tile.tileStatus;
//   if (oldStatus == TileStatus.active) {
//     // Tile has been clicked while it was active
//     // Set it to inactive and change its values accordingly
//     // Here: Disable the alarm
//     tile.label = "Alarm OFF";
//     tile.tileStatus = TileStatus.inactive;
//     tile.subtitle = "6:30 AM";
//     tile.drawableName = "alarm_off";
//     AlarmManager.instance.unscheduleAlarm();
//   } else {
//     // Tile has been clicked while it was inactive
//     // Set it to active and change its values accordingly
//     // Here: Enable the alarm
//     tile.label = "Alarm ON";
//     tile.tileStatus = TileStatus.active;
//     tile.subtitle = "6:30 AM";
//     tile.drawableName = "alarm_check";
//     AlarmManager.instance.scheduleAlarm();
//   }
//   // Return the updated tile, or null if you don't want to update the tile
//   return tile;
// }

// @pragma("vm:entry-point")
// Tile onTileAdded(Tile tile) {
//   tile.label = "Alarm ON";
//   tile.tileStatus = TileStatus.active;
//   tile.subtitle = "6:30 AM";
//   tile.drawableName = "alarm_check";
//   AlarmManager.instance.scheduleAlarm();
//   return tile;
// }

// @pragma("vm:entry-point")
// void onTileRemoved() {
//   print("Tile removed");
//   AlarmManager.instance.unscheduleAlarm();
// }

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
                  Button(
                    text: 'Permission Guard',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PermissionGuardScreen()),
                      );
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
                      text: 'Word_Cloud 2',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Word_Cloud()));
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
                    Button(
                        text: 'Rounded Text',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TextRoundedScreen()))),
                    const TextWidget(
                        text: 'TEXT ]',
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                    Button(
                      text: 'Staggered Screen',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StaggeredScreen()),
                        );
                      },
                    ),
                    Button(
                      text: 'Timepicker',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TimepickerScreen()),
                        );
                      },
                    ),
                    Button(
                      text: 'App Update',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AppUpdateScreen()),
                        );
                      },
                    ),
                    Button(
                      text: 'Version Check',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VersionCheckScreen()),
                        );
                      },
                    ),
                    Button(
                      text: 'Device Info',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DeviceInfo()),
                        );
                      },
                    ),
                    Button(
                      text: 'Geo-Location',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LocationScreen()),
                        );
                      },
                    ),
                    Button(
                      text: 'Fl_Chart',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FlChart()),
                        );
                      },
                    ),
                    Button(
                        text: 'No Screenshot',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const No_Screenshot()));
                        }),
                    Button(
                        text: 'Logger',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Logger_Example()));
                        }),
                    Button(
                        text: 'Focus on IT',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Focus_Widget_Example()));
                        }),
                    Button(
                        text: 'Face_Camera',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Face_Camera()));
                        }),
                    // Button(
                    //     text: 'Secure App',
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   const SecureAppScreen()));
                    //     }),
                    Button(
                        text: 'Card Swiper',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CardSwiperExample()));
                        }),
                    Button(
                        text: 'StarsView',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const StarsViewExample()));
                        }),
                    Button(
                        text: 'Tooltip',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TooltipExample()));
                        }),
                    Button(
                        text: 'Chiclet',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChicletExample()));
                        }),
                    Button(
                        text: 'Pop-Scope',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PopScopeScreen()));
                        }),
                    Button(
                        text: 'BasicScrollableSheetExample',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BasicScrollableSheetExample()));
                        }),
                    Button(
                        text: 'Quiz Settings',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Quiz_Settings()));
                        }),
                    Button(
                        text: 'Widget-Text Animator',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const WidgetTextAnimator()));
                        }),
                    Button(
                        text: 'Flutter Animation',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const WidgetTextAnimator()));
                        }),
                    Button(
                        text: 'Flutter Animation',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FlutterAnimationScreen()));
                        }),
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
