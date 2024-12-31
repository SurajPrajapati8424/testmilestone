import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'package:testmilestone/views/home.dart';

import '../modal/styles.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';

// import 'store_config.dart';
class MagicWeatherFlutter extends StatelessWidget {
  const MagicWeatherFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        barBackgroundColor: kColorBar,
        primaryColor: kColorText,
        textTheme: CupertinoTextThemeData(
          primaryColor: kColorText,
        ),
      ),
      home: AppContainer(),
    );
  }
}

// configure SDK
Future<void> configureSDK() async {
  // Enable debug logs before calling `configure`.
  await Purchases.setLogLevel(LogLevel.debug);

  /*
    - appUserID is nil, so an anonymous ID will be generated automatically by the Purchases SDK. Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids

    - PurchasesAreCompletedyBy is PurchasesAreCompletedByRevenueCat, so Purchases will automatically handle finishing transactions. Read more about completing purchases here: https://www.revenuecat.com/docs/migrating-to-revenuecat/sdk-or-not/finishing-transactions
    */
  PurchasesConfiguration configuration;
  if (StoreConfig.isForAmazonAppstore()) {
    configuration = AmazonConfiguration(StoreConfig.instance.apiKey)
      ..appUserID = null
      ..purchasesAreCompletedBy = const PurchasesAreCompletedByRevenueCat();
  } else {
    configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
      ..appUserID = null
      ..purchasesAreCompletedBy = const PurchasesAreCompletedByRevenueCat();
  }
  await Purchases.configure(configuration);
}

// Store Config
class StoreConfig {
  final Store store;
  final String apiKey;
  static StoreConfig? _instance;

  factory StoreConfig({required Store store, required String apiKey}) {
    _instance ??= StoreConfig._internal(store, apiKey);
    return _instance!;
  }

  StoreConfig._internal(this.store, this.apiKey);

  static StoreConfig get instance {
    return _instance!;
  }

  static bool isForAppleStore() => instance.store == Store.appStore;

  static bool isForGooglePlay() => instance.store == Store.playStore;

  static bool isForAmazonAppstore() => instance.store == Store.amazon;
}
