import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import 'package:routing_client_dart/routing_client_dart.dart' as routing;

// import 'package:flutter_osm_plugin_example/src/home/main_example.dart';
// import 'package:flutter_osm_plugin_example/src/search_example.dart';
// import 'package:flutter_osm_plugin_example/src/simple_example_hook.dart';

//import 'src/adv_home/home_example.dart';
// import 'src/home/home_example.dart';

class Osmscreen extends StatelessWidget {
  const Osmscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      initialRoute: "/home",
      routes: {
        "/home": (context) => const MainPageExample(),
        "/simple": (context) => Scaffold(
              appBar: AppBar(
                title: const Text('simple'),
              ),
              body: OSMViewer(
                controller: SimpleMapController(
                  initPosition: GeoPoint(
                    latitude: 47.4358055,
                    longitude: 8.4737324,
                  ),
                  markerHome: const MarkerIcon(
                    icon: Icon(Icons.home),
                  ),
                ),
                zoomOption: const ZoomOption(
                  initZoom: 16,
                  minZoomLevel: 11,
                ),
              ),
            ),
        "/old-home": (context) => const OldMainExample(),
        "/hook": (context) => const SimpleHookExample(),
        //"/adv-home": (ctx) => AdvandedMainExample(),
        // "/nav": (ctx) => MyHomeNavigationPage(
        //       map: Container(),
        // ),
        "/second": (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/old-home");
                  },
                  child: const Text("another page"),
                ),
              ),
            ),
        "/picker-result": (context) => const LocationAppExample(),
        "/search": (context) => const SearchPage(),
      },
    );
  }
}
// /home
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:pointer_interceptor/pointer_interceptor.dart';

class MainPageExample extends StatelessWidget {
  const MainPageExample({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Main(),
      drawer: PointerInterceptor(
        child: const DrawerMain(),
      ),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<Main> with OSMMixinObserver {
  late MapController controller;
  ValueNotifier<bool> trackingNotifier = ValueNotifier(false);
  ValueNotifier<bool> showFab = ValueNotifier(false);
  ValueNotifier<bool> disableMapControlUserTracking = ValueNotifier(true);
  ValueNotifier<IconData> userLocationIcon = ValueNotifier(Icons.near_me);
  ValueNotifier<GeoPoint?> lastGeoPoint = ValueNotifier(null);
  List<GeoPoint> geos = [];
  ValueNotifier<GeoPoint?> userLocationNotifier = ValueNotifier(null);
  final mapKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initPosition: GeoPoint(
        latitude: 47.4358055,
        longitude: 8.4737324,
      ),
      // initMapWithUserPosition: UserTrackingOption(
      //   enableTracking: trackingNotifier.value,
      // ),
      useExternalTracking: disableMapControlUserTracking.value,
    );
    controller.addObserver(this);
    trackingNotifier.addListener(() async {
      if (userLocationNotifier.value != null && !trackingNotifier.value) {
        await controller.removeMarker(userLocationNotifier.value!);
        userLocationNotifier.value = null;
      }
    });
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      showFab.value = true;
    }
  }

  @override
  void onSingleTap(GeoPoint position) {
    super.onSingleTap(position);
    Future.microtask(() async {
      if (lastGeoPoint.value != null) {
        // await controller.changeLocationMarker(
        //   oldLocation: lastGeoPoint.value!,
        //   newLocation: position,
        //   //iconAnchor: IconAnchor(anchor: Anchor.top),
        // );
        //controller.removeMarker(lastGeoPoint.value!);
        await controller.addMarker(
          position,
          markerIcon: const MarkerIcon(
            icon: Icon(
              Icons.person_pin,
              color: Colors.red,
              size: 32,
            ),
          ),
          //angle: userLocation.angle,
        );
      } else {
        await controller.addMarker(
          position,
          markerIcon: const MarkerIcon(
            icon: Icon(
              Icons.person_pin,
              color: Colors.red,
              size: 32,
            ),
          ),
          // iconAnchor: IconAnchor(
          //   anchor: Anchor.left,
          //   //offset: (x: 32.5, y: -32),
          // ),
          //angle: -pi / 4,
        );
      }
      //await controller.moveTo(position, animate: true);
      lastGeoPoint.value = position;
      geos.add(position);
    });
  }

  @override
  void onRegionChanged(Region region) {
    super.onRegionChanged(region);
    if (trackingNotifier.value) {
      final userLocation = userLocationNotifier.value;
      if (userLocation == null ||
          !region.center.isEqual(
            userLocation,
            precision: 1e4,
          )) {
        userLocationIcon.value = Icons.gps_not_fixed;
      } else {
        userLocationIcon.value = Icons.gps_fixed;
      }
    }
  }

  @override
  void onLocationChanged(UserLocation userLocation) async {
    super.onLocationChanged(userLocation);
    if (disableMapControlUserTracking.value && trackingNotifier.value) {
      await controller.moveTo(userLocation);
      if (userLocationNotifier.value == null) {
        await controller.addMarker(
          userLocation,
          markerIcon: const MarkerIcon(
            icon: Icon(Icons.navigation),
          ),
          angle: userLocation.angle,
        );
      } else {
        await controller.changeLocationMarker(
          oldLocation: userLocationNotifier.value!,
          newLocation: userLocation,
          angle: userLocation.angle,
        );
      }
      userLocationNotifier.value = userLocation;
    } else {
      if (userLocationNotifier.value != null && !trackingNotifier.value) {
        await controller.removeMarker(userLocationNotifier.value!);
        userLocationNotifier.value = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.maybeOf(context)?.viewPadding.top;
    return Stack(
      children: [
        Map(
          controller: controller,
        ),
        if (!kReleaseMode || kIsWeb) ...[
          Positioned(
            bottom: 23.0,
            left: 15,
            child: ZoomNavigation(
              controller: controller,
            ),
          )
        ],
        Positioned.fill(
          child: ValueListenableBuilder(
            valueListenable: showFab,
            builder: (context, isVisible, child) {
              if (!isVisible) {
                return const SizedBox.shrink();
              }
              return Stack(
                children: [
                  if (!kIsWeb) ...[
                    Positioned(
                      top: (topPadding ?? 26) + 48,
                      right: 15,
                      child: MapRotation(
                        controller: controller,
                      ),
                    )
                  ],
                  Positioned(
                    top: kIsWeb ? 26 : topPadding ?? 26.0,
                    left: 12,
                    child: PointerInterceptor(
                      child: const MainNavigation(),
                    ),
                  ),
                  Positioned(
                    bottom: 32,
                    right: 15,
                    child: ActivationUserLocation(
                      controller: controller,
                      trackingNotifier: trackingNotifier,
                      userLocation: userLocationNotifier,
                      userLocationIcon: userLocationIcon,
                    ),
                  ),
                  Positioned(
                    bottom: 148,
                    right: 15,
                    child: IconButton(
                      onPressed: () async {
                        Future.forEach(geos, (element) async {
                          await controller.removeMarker(element);
                          await Future.delayed(
                              const Duration(milliseconds: 100));
                        });
                      },
                      icon: const Icon(Icons.clear_all),
                    ),
                  ),
                  Positioned(
                    bottom: 92,
                    right: 15,
                    child: DirectionRouteLocation(
                      controller: controller,
                    ),
                  ),
                  Positioned(
                    top: kIsWeb ? 26 : topPadding,
                    left: 64,
                    right: 72,
                    child: SearchInMap(
                      controller: controller,
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class ZoomNavigation extends StatelessWidget {
  const ZoomNavigation({
    super.key,
    required this.controller,
  });
  final MapController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PointerInterceptor(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              maximumSize: const Size(48, 48),
              minimumSize: const Size(24, 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
              padding: EdgeInsets.zero,
            ),
            child: const Center(
              child: Icon(Icons.add),
            ),
            onPressed: () async {
              controller.zoomIn();
            },
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        PointerInterceptor(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              maximumSize: const Size(48, 48),
              minimumSize: const Size(24, 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
              padding: EdgeInsets.zero,
            ),
            child: const Center(
              child: Icon(Icons.remove),
            ),
            onPressed: () async {
              controller.zoomOut();
            },
          ),
        ),
      ],
    );
  }
}

class MapRotation extends HookWidget {
  const MapRotation({
    super.key,
    required this.controller,
  });
  final MapController controller;
  @override
  Widget build(BuildContext context) {
    final angle = useValueNotifier(0.0);
    return FloatingActionButton(
      key: UniqueKey(),
      onPressed: () async {
        angle.value += 30;
        if (angle.value > 360) {
          angle.value = 0;
        }
        await controller.rotateMapCamera(angle.value);
      },
      heroTag: "RotationMapFab",
      elevation: 1,
      mini: true,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ValueListenableBuilder(
          valueListenable: angle,
          builder: (ctx, angle, child) {
            return AnimatedRotation(
              turns: angle == 0 ? 0 : 360 / angle,
              duration: const Duration(milliseconds: 250),
              child: child!,
            );
          },
          child: Image.asset("asset/compass.png"),
        ),
      ),
    );
  }
}

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: UniqueKey(),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      heroTag: "MainMenuFab",
      mini: true,
      backgroundColor: Colors.white,
      child: const Icon(Icons.menu),
    );
  }
}

class DrawerMain extends StatelessWidget {
  const DrawerMain({super.key});

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: GestureDetector(
        onHorizontalDragEnd: (_) {
          Scaffold.of(context).closeDrawer();
        },
        child: PointerInterceptor(
          child: Drawer(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.viewPaddingOf(context).top),
                ListTile(
                  onTap: () {},
                  title: const Text("search example"),
                ),
                ListTile(
                  onTap: () {},
                  title: const Text("map with hook example"),
                ),
                PointerInterceptor(
                  child: ListTile(
                    onTap: () async {
                      Scaffold.of(context).closeDrawer();
                      await Navigator.pushNamed(context, '/old-home');
                    },
                    title: const Text("old home example"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Map extends StatelessWidget {
  const Map({
    super.key,
    required this.controller,
  });
  final MapController controller;
  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      controller: controller,
      // mapIsLoading: Center(
      //   child: CircularProgressIndicator(),
      // ),
      onLocationChanged: (location) {
        debugPrint(location.toString());
      },
      osmOption: OSMOption(
        enableRotationByGesture: true,
        zoomOption: const ZoomOption(
          initZoom: 16,
          minZoomLevel: 3,
          maxZoomLevel: 19,
          stepZoom: 1.0,
        ),
        userLocationMarker: UserLocationMaker(
            personMarker: MarkerIcon(
              // icon: Icon(
              //   Icons.car_crash_sharp,
              //   color: Colors.red,
              //   size: 48,
              // ),
              // iconWidget: SizedBox.square(
              //   dimension: 56,
              //   child: Image.asset(
              //     "asset/taxi.png",
              //     scale: .3,
              //   ),
              // ),
              iconWidget: SizedBox(
                width: 32,
                height: 64,
                child: Image.asset(
                  "asset/directionIcon.png",
                  scale: .3,
                ),
              ),
              // assetMarker: AssetMarker(
              //   image: AssetImage(
              //     "asset/taxi.png",
              //   ),
              //   scaleAssetImage: 0.3,
              // ),
            ),
            directionArrowMarker: const MarkerIcon(
              icon: Icon(
                Icons.navigation_rounded,
                size: 48,
              ),
              // iconWidget: SizedBox(
              //   width: 32,
              //   height: 64,
              //   child: Image.asset(
              //     "asset/directionIcon.png",
              //     scale: .3,
              //   ),
              // ),
            )
            // directionArrowMarker: MarkerIcon(
            //   assetMarker: AssetMarker(
            //     image: AssetImage(
            //       "asset/taxi.png",
            //     ),
            //     scaleAssetImage: 0.25,
            //   ),
            // ),
            ),
        staticPoints: [
          StaticPositionGeoPoint(
            "line 1",
            const MarkerIcon(
              icon: Icon(
                Icons.train,
                color: Colors.green,
                size: 32,
              ),
            ),
            [
              GeoPoint(
                latitude: 47.4333594,
                longitude: 8.4680184,
              ),
              GeoPoint(
                latitude: 47.4317782,
                longitude: 8.4716146,
              ),
            ],
          ),
        ],
        roadConfiguration: const RoadOption(
          roadColor: Colors.blueAccent,
        ),
        showContributorBadgeForOSM: true,
        //trackMyPosition: trackingNotifier.value,
        showDefaultInfoWindow: false,
      ),
    );
  }
}

class SearchLocation extends StatelessWidget {
  const SearchLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField();
  }
}

class ActivationUserLocation extends StatelessWidget {
  final ValueNotifier<bool> trackingNotifier;
  final MapController controller;
  final ValueNotifier<IconData> userLocationIcon;
  final ValueNotifier<GeoPoint?> userLocation;

  const ActivationUserLocation({
    super.key,
    required this.trackingNotifier,
    required this.controller,
    required this.userLocationIcon,
    required this.userLocation,
  });
  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onLongPress: () async {
          //await controller.disabledTracking();
          await controller.stopLocationUpdating();
          trackingNotifier.value = false;
        },
        child: FloatingActionButton(
          key: UniqueKey(),
          onPressed: () async {
            if (!trackingNotifier.value) {
              /*await controller.currentLocation();
              await controller.enableTracking(
                enableStopFollow: true,
                disableUserMarkerRotation: false,
                anchor: Anchor.right,
                useDirectionMarker: true,
              );*/
              await controller.startLocationUpdating();
              trackingNotifier.value = true;

              //await controller.zoom(5.0);
            } else {
              if (userLocation.value != null) {
                await controller.moveTo(userLocation.value!);
              }

              /*await controller.enableTracking(
                  enableStopFollow: false,
                  disableUserMarkerRotation: true,
                  anchor: Anchor.center,
                  useDirectionMarker: true);*/
              // if (userLocationNotifier.value != null) {
              //   await controller
              //       .goToLocation(userLocationNotifier.value!);
              // }
            }
          },
          mini: true,
          heroTag: "UserLocationFab",
          child: ValueListenableBuilder<bool>(
            valueListenable: trackingNotifier,
            builder: (ctx, isTracking, _) {
              if (isTracking) {
                return ValueListenableBuilder<IconData>(
                  valueListenable: userLocationIcon,
                  builder: (context, icon, _) {
                    return Icon(icon);
                  },
                );
              }
              return const Icon(Icons.near_me);
            },
          ),
        ),
      ),
    );
  }
}

class DirectionRouteLocation extends StatelessWidget {
  final MapController controller;

  const DirectionRouteLocation({
    super.key,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: FloatingActionButton(
        key: UniqueKey(),
        onPressed: () async {},
        mini: true,
        heroTag: "directionFab",
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Icon(
          Icons.directions,
          color: Colors.white,
        ),
      ),
    );
  }
}

class SearchInMap extends StatefulWidget {
  final MapController controller;

  const SearchInMap({
    super.key,
    required this.controller,
  });
  @override
  State<StatefulWidget> createState() => _SearchInMapState();
}

class _SearchInMapState extends State<SearchInMap> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.addListener(onTextChanged);
  }

  void onTextChanged() {}
  @override
  void dispose() {
    textController.removeListener(onTextChanged);
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: const StadiumBorder(),
        child: TextField(
          controller: textController,
          onTap: () {},
          maxLines: 1,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            filled: false,
            isDense: true,
            hintText: "search",
            prefixIcon: Icon(
              Icons.search,
              size: 22,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

///
///

class LocationAppExample extends StatefulWidget {
  const LocationAppExample({super.key});

  @override
  State<StatefulWidget> createState() => _LocationAppExampleState();
}

class _LocationAppExampleState extends State<LocationAppExample> {
  ValueNotifier<GeoPoint?> notifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("search picker example"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder<GeoPoint?>(
              valueListenable: notifier,
              builder: (ctx, p, child) {
                return Center(
                  child: Text(
                    p?.toString() ?? "",
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var p = await Navigator.pushNamed(context, "/search");
                    if (p != null) {
                      notifier.value = p as GeoPoint;
                    }
                  },
                  child: const Text("pick address"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var p = await showSimplePickerLocation(
                      context: context,
                      isDismissible: true,
                      title: "location picker",
                      textConfirmPicker: "pick",
                      zoomOption: const ZoomOption(
                        initZoom: 8,
                      ),
                      initPosition: GeoPoint(
                        latitude: 47.4358055,
                        longitude: 8.4737324,
                      ),
                      radius: 8.0,
                    );
                    if (p != null) {
                      notifier.value = p;
                    }
                  },
                  child: const Text("show picker address"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController textEditingController = TextEditingController();
  late PickerMapController controller = PickerMapController(
    initMapWithUserPosition: const UserTrackingOption(),
  );

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(textOnChanged);
  }

  void textOnChanged() {
    controller.setSearchableText(textEditingController.text);
  }

  @override
  void dispose() {
    textEditingController.removeListener(textOnChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPickerLocation(
      controller: controller,
      showDefaultMarkerPickWidget: true,
      topWidgetPicker: Padding(
        padding: const EdgeInsets.only(
          top: 56,
          left: 8,
          right: 8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                PointerInterceptor(
                  child: TextButton(
                    style: TextButton.styleFrom(),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                ),
                Expanded(
                  child: PointerInterceptor(
                    child: TextField(
                      controller: textEditingController,
                      onEditingComplete: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        suffix: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: textEditingController,
                          builder: (ctx, text, child) {
                            if (text.text.isNotEmpty) {
                              return child!;
                            }
                            return const SizedBox.shrink();
                          },
                          child: InkWell(
                            focusNode: FocusNode(),
                            onTap: () {
                              textEditingController.clear();
                              controller.setSearchableText("");
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        focusColor: Colors.black,
                        filled: true,
                        hintText: "search",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        fillColor: Colors.grey[300],
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const TopSearchWidget()
          ],
        ),
      ),
      bottomWidgetPicker: Positioned(
        bottom: 12,
        right: 8,
        child: PointerInterceptor(
          child: FloatingActionButton(
            onPressed: () async {
              GeoPoint p = await controller.selectAdvancedPositionPicker();
              if (!context.mounted) return;
              Navigator.pop(context, p);
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ),
      ),
      pickerConfig: const CustomPickerLocationConfig(
        zoomOption: ZoomOption(
          initZoom: 8,
        ),
      ),
    );
  }
}

class TopSearchWidget extends StatefulWidget {
  const TopSearchWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TopSearchWidgetState();
}

class _TopSearchWidgetState extends State<TopSearchWidget> {
  late PickerMapController controller;
  ValueNotifier<GeoPoint?> notifierGeoPoint = ValueNotifier(null);
  ValueNotifier<bool> notifierAutoCompletion = ValueNotifier(false);

  late StreamController<List<SearchInfo>> streamSuggestion = StreamController();
  late Future<List<SearchInfo>> _futureSuggestionAddress;
  String oldText = "";
  Timer? _timerToStartSuggestionReq;
  final Key streamKey = const Key("streamAddressSug");

  @override
  void initState() {
    super.initState();
    controller = CustomPickerLocation.of(context);
    controller.searchableText.addListener(onSearchableTextChanged);
  }

  void onSearchableTextChanged() async {
    final v = controller.searchableText.value;
    if (v.length > 3 && oldText != v) {
      oldText = v;
      if (_timerToStartSuggestionReq != null &&
          _timerToStartSuggestionReq!.isActive) {
        _timerToStartSuggestionReq!.cancel();
      }
      _timerToStartSuggestionReq =
          Timer.periodic(const Duration(seconds: 3), (timer) async {
        await suggestionProcessing(v);
        timer.cancel();
      });
    }
    if (v.isEmpty) {
      await reInitStream();
    }
  }

  Future reInitStream() async {
    notifierAutoCompletion.value = false;
    await streamSuggestion.close();
    setState(() {
      streamSuggestion = StreamController();
    });
  }

  Future<void> suggestionProcessing(String addr) async {
    notifierAutoCompletion.value = true;
    _futureSuggestionAddress = addressSuggestion(
      addr,
      limitInformation: 5,
    );
    _futureSuggestionAddress.then((value) {
      streamSuggestion.sink.add(value);
    });
  }

  @override
  void dispose() {
    controller.searchableText.removeListener(onSearchableTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: notifierAutoCompletion,
      builder: (ctx, isVisible, child) {
        return AnimatedContainer(
          duration: const Duration(
            milliseconds: 500,
          ),
          height: isVisible ? MediaQuery.of(context).size.height / 4 : 0,
          child: Card(
            child: child!,
          ),
        );
      },
      child: StreamBuilder<List<SearchInfo>>(
        stream: streamSuggestion.stream,
        key: streamKey,
        builder: (ctx, snap) {
          if (snap.hasData) {
            return ListView.builder(
              itemExtent: 50.0,
              itemBuilder: (ctx, index) {
                return PointerInterceptor(
                  child: ListTile(
                    title: Text(
                      snap.data![index].address.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    onTap: () async {
                      /// go to location selected by address
                      controller.goToLocation(
                        snap.data![index].point!,
                      );

                      /// hide suggestion card
                      notifierAutoCompletion.value = false;
                      await reInitStream();
                      if (!context.mounted) return;
                      FocusScope.of(context).requestFocus(
                        FocusNode(),
                      );
                    },
                  ),
                );
              },
              itemCount: snap.data!.length,
            );
          }
          if (snap.connectionState == ConnectionState.waiting) {
            return const Card(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

///
///

class OldMainExample extends StatefulWidget {
  const OldMainExample({super.key});

  @override
  State<OldMainExample> createState() => _MainExampleState();
}

class _MainExampleState extends State<OldMainExample>
    with OSMMixinObserver, TickerProviderStateMixin {
  late MapController controller;
  late GlobalKey<ScaffoldState> scaffoldKey;
  Key mapGlobalkey = UniqueKey();
  ValueNotifier<bool> zoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> visibilityZoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> visibilityOSMLayers = ValueNotifier(false);
  ValueNotifier<double> positionOSMLayers = ValueNotifier(-200);
  ValueNotifier<GeoPoint?> centerMap = ValueNotifier(null);
  ValueNotifier<bool> trackingNotifier = ValueNotifier(false);
  ValueNotifier<bool> showFab = ValueNotifier(true);
  ValueNotifier<GeoPoint?> lastGeoPoint = ValueNotifier(null);
  ValueNotifier<bool> beginDrawRoad = ValueNotifier(false);
  List<GeoPoint> pointsRoad = [];
  late final manager = routing.OSRMManager();
  Timer? timer;
  int x = 0;
  late AnimationController animationController;
  late Animation<double> animation =
      Tween<double>(begin: 0, end: 2 * pi).animate(animationController);
  final ValueNotifier<int> mapRotate = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
    // controller = MapController.withUserPosition(
    //     trackUserLocation: UserTrackingOption(
    //   enableTracking: true,
    //   unFollowUser: false,
    // )
    controller = MapController.withPosition(
      initPosition: GeoPoint(
        latitude: 47.4358055,
        longitude: 8.4737324,
      ),
      // areaLimit: BoundingBox(
      //   east: 10.4922941,
      //   north: 47.8084648,
      //   south: 45.817995,
      //   west: 5.9559113,
      // ),
    );
    //  controller = MapController.cyclOSMLayer(

    //   initPosition: GeoPoint(
    //     latitude: 47.4358055,
    //     longitude: 8.4737324,
    //   ),
    // areaLimit: BoundingBox(
    //   east: 10.4922941,
    //   north: 47.8084648,
    //   south: 45.817995,
    //   west: 5.9559113,
    // ),
    //);
    //  controller = MapController.publicTransportationLayer(
    //   initMapWithUserPosition: false,
    //   initPosition: GeoPoint(
    //     latitude: 47.4358055,
    //     longitude: 8.4737324,
    //   ),
    // );

    /*  controller = MapController.customLayer(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(
        latitude: 47.4358055,
        longitude: 8.4737324,
      ),
      customTile: CustomTile(
        sourceName: "outdoors",
        tileExtension: ".png",
        minZoomLevel: 2,
        maxZoomLevel: 19,
        urlsServers: [
          TileURLs(
            url: "https://tile.thunderforest.com/outdoors/",
          )
        ],
        tileSize: 256,
        keyApi: MapEntry(
          "apikey",
          dotenv.env['api']!,
        ),
      ),
    ); */
    // controller = MapController.customLayer(
    //   //initPosition: initPosition,
    //   initMapWithUserPosition: UserTrackingOption(),
    //   customTile: CustomTile(
    //     urlsServers: [
    //       TileURLs(url: "https://tile.openstreetmap.de/"),
    //     ],
    //     tileExtension: ".png",
    //     sourceName: "osmGermany",
    //     maxZoomLevel: 20,
    //   ),
    // );
    /* controller = MapController.customLayer(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(
        latitude: 47.4358055,
        longitude: 8.4737324,
      ),
      customTile: CustomTile(
        sourceName: "opentopomap",
        tileExtension: ".png",
        minZoomLevel: 2,
        maxZoomLevel: 19,
        urlsServers: [
          "https://a.tile.opentopomap.org/",
          "https://b.tile.opentopomap.org/",
          "https://c.tile.opentopomap.org/",
        ],
        tileSize: 256,
      ),
    );*/
    controller.addObserver(this);
    scaffoldKey = GlobalKey<ScaffoldState>();
    controller.listenerMapLongTapping.addListener(() async {
      if (controller.listenerMapLongTapping.value != null) {
        await controller.moveTo(controller.listenerMapLongTapping.value!);
        /* await controller.addMarker(
          controller.listenerMapLongTapping.value!,
          markerIcon: MarkerIcon(
            iconWidget: SizedBox.fromSize(
              size: Size.square(32),
              child: Stack(
                children: [
                  Icon(
                    Icons.store,
                    color: Colors.brown,
                    size: 32,
                  ),
                  Text(
                    randNum,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          //angle: pi / 3,
        );*/
      }
    });
    controller.listenerMapSingleTapping.addListener(() async {
      if (controller.listenerMapSingleTapping.value != null) {
        debugPrint(controller.listenerMapSingleTapping.value.toString());
        if (beginDrawRoad.value) {
          pointsRoad.add(controller.listenerMapSingleTapping.value!);

          await controller.addMarker(
            controller.listenerMapSingleTapping.value!,
            markerIcon: const MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.amber,
                size: 48,
              ),
            ),
          );
          if (pointsRoad.length >= 2 && showFab.value && mounted) {
            roadActionBt(context);
          }
        } else if (lastGeoPoint.value != null) {
          await controller.changeLocationMarker(
            oldLocation: lastGeoPoint.value!,
            newLocation: controller.listenerMapSingleTapping.value!,
          );

          lastGeoPoint.value = controller.listenerMapSingleTapping.value;
        } else {
          await controller.addMarker(
            controller.listenerMapSingleTapping.value!,
            markerIcon: const MarkerIcon(
              icon: Icon(
                Icons.person_pin,
                color: Colors.red,
                size: 48,
              ),
              // assetMarker: AssetMarker(
              //   image: AssetImage("asset/pin.png"),
              // ),
              // assetMarker: AssetMarker(
              //   image: AssetImage("asset/pin.png"),
              //   //scaleAssetImage: 2,
              // ),
            ),
            iconAnchor: IconAnchor(
              anchor: Anchor.top,
              //offset: (x: 32.5, y: -32),
            ),
            //angle: -pi / 4,
          );
          lastGeoPoint.value = controller.listenerMapSingleTapping.value;
        }
      }
    });
    controller.listenerRegionIsChanging.addListener(() async {
      if (controller.listenerRegionIsChanging.value != null) {
        centerMap.value = controller.listenerRegionIsChanging.value!.center;
      }
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    //controller.listenerMapIsReady.addListener(mapIsInitialized);
  }

  Future<void> mapIsInitialized() async {
    await controller.setZoom(zoomLevel: 12);
    // await controller.setMarkerOfStaticPoint(
    //   id: "line 1",
    //   markerIcon: MarkerIcon(
    //     icon: Icon(
    //       Icons.train,
    //       color: Colors.red,
    //       size: 48,
    //     ),
    //   ),
    // );
    await controller.setMarkerOfStaticPoint(
      id: "line 2",
      markerIcon: const MarkerIcon(
        icon: Icon(
          Icons.train,
          color: Colors.orange,
          size: 36,
        ),
      ),
    );

    await controller.setStaticPosition(
      [
        GeoPointWithOrientation.radian(
          latitude: 47.4433594,
          longitude: 8.4680184,
          radianAngle: pi / 4,
        ),
        GeoPointWithOrientation.radian(
          latitude: 47.4517782,
          longitude: 8.4716146,
          radianAngle: pi / 2,
        ),
      ],
      "line 2",
    );

    // Future.delayed(Duration(seconds: 5), () {
    //   controller.changeTileLayer(tileLayer: CustomTile.cycleOSM());
    // });
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      await mapIsInitialized();
    }
  }

  @override
  void onRoadTap(RoadInfo road) {
    super.onRoadTap(road);
    debugPrint("road:$road");
    Future.microtask(() => controller.removeRoad(roadKey: road.key));
  }

  @override
  void dispose() {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
    }
    //controller.listenerMapIsReady.removeListener(mapIsInitialized);
    animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('OSM'),
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context); //, '/home');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.layers),
            onPressed: () async {
              if (visibilityOSMLayers.value) {
                positionOSMLayers.value = -200;
                await Future.delayed(const Duration(milliseconds: 700));
              }
              visibilityOSMLayers.value = !visibilityOSMLayers.value;
              showFab.value = !visibilityOSMLayers.value;
              Future.delayed(const Duration(milliseconds: 500), () {
                positionOSMLayers.value = visibilityOSMLayers.value ? 32 : -200;
              });
            },
          ),
          Builder(builder: (ctx) {
            return GestureDetector(
              onLongPress: () => drawMultiRoads(),
              onDoubleTap: () async {
                await controller.clearAllRoads();
              },
              child: IconButton(
                onPressed: () {
                  beginDrawRoad.value = true;
                },
                icon: const Icon(Icons.route),
              ),
            );
          }),
          IconButton(
            onPressed: () async {
              await drawRoadManually();
            },
            icon: const Icon(Icons.alt_route),
          ),
          IconButton(
            onPressed: () async {
              visibilityZoomNotifierActivation.value =
                  !visibilityZoomNotifierActivation.value;
              zoomNotifierActivation.value = !zoomNotifierActivation.value;
            },
            icon: const Icon(Icons.zoom_out_map),
          ),
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, "/picker-result");
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              await controller.toggleLayersVisibility();
            },
            icon: const Icon(Icons.location_on),
          ),
        ],
      ),
      body: Stack(
        children: [
          OSMFlutter(
            controller: controller,
            osmOption: OSMOption(
              enableRotationByGesture: true,
              zoomOption: const ZoomOption(
                initZoom: 8,
                minZoomLevel: 3,
                maxZoomLevel: 19,
                stepZoom: 1.0,
              ),
              userLocationMarker: UserLocationMaker(
                  personMarker: MarkerIcon(
                    // icon: Icon(
                    //   Icons.car_crash_sharp,
                    //   color: Colors.red,
                    //   size: 48,
                    // ),
                    // iconWidget: SizedBox.square(
                    //   dimension: 56,
                    //   child: Image.asset(
                    //     "asset/taxi.png",
                    //     scale: .3,
                    //   ),
                    // ),
                    iconWidget: SizedBox(
                      width: 32,
                      height: 64,
                      child: Image.asset(
                        "asset/directionIcon.png",
                        scale: .3,
                      ),
                    ),
                    // assetMarker: AssetMarker(
                    //   image: AssetImage(
                    //     "asset/taxi.png",
                    //   ),
                    //   scaleAssetImage: 0.3,
                    // ),
                  ),
                  directionArrowMarker: MarkerIcon(
                    // icon: Icon(
                    //   Icons.navigation_rounded,
                    //   size: 48,
                    // ),
                    iconWidget: SizedBox(
                      width: 32,
                      height: 64,
                      child: Image.asset(
                        "asset/directionIcon.png",
                        scale: .3,
                      ),
                    ),
                  )
                  // directionArrowMarker: MarkerIcon(
                  //   assetMarker: AssetMarker(
                  //     image: AssetImage(
                  //       "asset/taxi.png",
                  //     ),
                  //     scaleAssetImage: 0.25,
                  //   ),
                  // ),
                  ),
              staticPoints: [
                StaticPositionGeoPoint(
                  "line 1",
                  const MarkerIcon(
                    icon: Icon(
                      Icons.train,
                      color: Colors.green,
                      size: 32,
                    ),
                  ),
                  [
                    GeoPoint(
                      latitude: 47.4333594,
                      longitude: 8.4680184,
                    ),
                    GeoPoint(
                      latitude: 47.4317782,
                      longitude: 8.4716146,
                    ),
                  ],
                ),
                /*StaticPositionGeoPoint(
                      "line 2",
                      MarkerIcon(
                        icon: Icon(
                          Icons.train,
                          color: Colors.red,
                          size: 48,
                        ),
                      ),
                      [
                        GeoPoint(latitude: 47.4433594, longitude: 8.4680184),
                        GeoPoint(latitude: 47.4517782, longitude: 8.4716146),
                      ],
                    )*/
              ],
              roadConfiguration: const RoadOption(
                roadColor: Colors.blueAccent,
              ),
              showContributorBadgeForOSM: true,
              //trackMyPosition: trackingNotifier.value,
              showDefaultInfoWindow: false,
            ),
            mapIsLoading: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Map is Loading.."),
                ],
              ),
            ),
            onMapIsReady: (isReady) {
              if (isReady) {
                debugPrint("map is ready");
              }
            },
            onLocationChanged: (myLocation) {
              debugPrint('user location :$myLocation');
            },
            onGeoPointClicked: (geoPoint) async {
              if (geoPoint ==
                  GeoPoint(
                    latitude: 47.442475,
                    longitude: 8.4680389,
                  )) {
                final newGeoPoint = GeoPoint(
                  latitude: 47.4517782,
                  longitude: 8.4716146,
                );
                await controller.changeLocationMarker(
                  oldLocation: geoPoint,
                  newLocation: newGeoPoint,
                  markerIcon: const MarkerIcon(
                    icon: Icon(
                      Icons.bus_alert,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                );
              }
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    geoPoint.toMap().toString(),
                  ),
                  action: SnackBarAction(
                    onPressed: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                    label: "hide",
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: ValueListenableBuilder<bool>(
              valueListenable: visibilityZoomNotifierActivation,
              builder: (ctx, visibility, child) {
                return Visibility(
                  visible: visibility,
                  child: child!,
                );
              },
              child: ValueListenableBuilder<bool>(
                valueListenable: zoomNotifierActivation,
                builder: (ctx, isVisible, child) {
                  return AnimatedOpacity(
                    opacity: isVisible ? 1.0 : 0.0,
                    onEnd: () {
                      visibilityZoomNotifierActivation.value = isVisible;
                    },
                    duration: const Duration(milliseconds: 500),
                    child: child,
                  );
                },
                child: Column(
                  children: [
                    ElevatedButton(
                      child: const Icon(Icons.add),
                      onPressed: () async {
                        controller.zoomIn();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      child: const Icon(Icons.remove),
                      onPressed: () async {
                        controller.zoomOut();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: visibilityOSMLayers,
            builder: (ctx, isVisible, child) {
              if (!isVisible) {
                return const SizedBox.shrink();
              }
              return child!;
            },
            child: ValueListenableBuilder<double>(
              valueListenable: positionOSMLayers,
              builder: (ctx, position, child) {
                return AnimatedPositioned(
                  bottom: position,
                  left: 24,
                  right: 24,
                  duration: const Duration(milliseconds: 500),
                  child: OSMLayersChoiceWidget(
                    centerPoint: centerMap.value!,
                    setLayerCallback: (tile) async {
                      await controller.changeTileLayer(tileLayer: tile);
                    },
                  ),
                );
              },
            ),
          ),
          if (!kIsWeb) ...[
            Positioned(
              top: 5,
              right: 12,
              child: FloatingActionButton(
                key: UniqueKey(),
                heroTag: "rotateCamera",
                onPressed: () async {
                  animationController.forward().then((value) {
                    animationController.reset();
                  });
                  mapRotate.value = 0;
                  await controller.rotateMapCamera(mapRotate.value.toDouble());
                },
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: animation.value,
                      child: child!,
                    );
                  },
                  child: const Icon(Icons.screen_rotation_alt_outlined),
                ),
              ),
            ),
          ],
        ],
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: showFab,
        builder: (ctx, isShow, child) {
          if (!isShow) {
            return const SizedBox.shrink();
          }
          return child!;
        },
        child: PointerInterceptor(
          child: FloatingActionButton(
            key: UniqueKey(),
            heroTag: "locationUser",
            onPressed: () async {
              if (!trackingNotifier.value) {
                await controller.currentLocation();
                await controller.enableTracking(
                  enableStopFollow: true,
                  disableUserMarkerRotation: false,
                  anchor: Anchor.left,
                );
                //await controller.zoom(5.0);
              } else {
                await controller.disabledTracking();
              }
              trackingNotifier.value = !trackingNotifier.value;
            },
            child: ValueListenableBuilder<bool>(
              valueListenable: trackingNotifier,
              builder: (ctx, isTracking, _) {
                if (isTracking) {
                  return const Icon(Icons.gps_off_sharp);
                }
                return const Icon(Icons.my_location);
              },
            ),
          ),
        ),
      ),
    );
  }

  void roadActionBt(BuildContext ctx) async {
    try {
      ///selection geoPoint

      showFab.value = false;
      ValueNotifier<RoadType> notifierRoadType = ValueNotifier(RoadType.car);

      final bottomPersistant = scaffoldKey.currentState!.showBottomSheet(
        (ctx) {
          return PointerInterceptor(
            child: RoadTypeChoiceWidget(
              setValueCallback: (roadType) {
                notifierRoadType.value = roadType;
              },
            ),
          );
        },
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      );
      await bottomPersistant.closed.then((roadType) async {
        showFab.value = true;
        beginDrawRoad.value = false;
        /* final road = await manager.getRoad(
            waypoints: [pointsRoad.first, pointsRoad.last]
                .map(
                  (e) => routing.LngLat(
                    lat: e.latitude,
                    lng: e.longitude,
                  ),
                )
                .toList());
        final lnglats = road.polyline
                ?.map(
                  (e) => GeoPoint(
                    latitude: e.lat,
                    longitude: e.lng,
                  ),
                )
                .toList() ??
            <GeoPoint>[];
        await controller.drawRoadManually(
          lnglats,
          RoadOption(
            roadWidth: 20,
            roadColor: Colors.red,
            zoomInto: true,
            roadBorderWidth: 30,
            roadBorderColor: Colors.green,
          ),
        );*/
        RoadInfo roadInformation = await controller.drawRoad(
          pointsRoad.first,
          pointsRoad.last,
          roadType: notifierRoadType.value,
          intersectPoint:
              pointsRoad.getRange(1, pointsRoad.length - 1).toList(),
          roadOption: const RoadOption(
            roadWidth: 15,
            roadColor: Colors.red,
            zoomInto: true,
            roadBorderWidth: 10.0,
            roadBorderColor: Colors.green,
            isDotted: true,
          ),
        );
        pointsRoad.clear();
        debugPrint(
            "app duration:${Duration(seconds: roadInformation.duration!.toInt()).inMinutes}");
        debugPrint("app distance:${roadInformation.distance}Km");
        debugPrint("app road:$roadInformation");
        final console = roadInformation.instructions
            .map((e) => e.toString())
            .reduce(
              (value, element) => "$value -> \n $element",
            )
            .toString();
        debugPrint(
          console,
          wrapWidth: console.length,
        );
        // final box = await BoundingBox.fromGeoPointsAsync([point2, point]);
        // controller.zoomToBoundingBox(
        //   box,
        //   paddinInPixel: 64,
        // );
      });
    } on RoadException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${e.errorMessage()}",
          ),
        ),
      );
    }
  }

  @override
  Future<void> mapRestored() async {
    super.mapRestored();
    debugPrint("log map restored");
  }

  void drawMultiRoads() async {
    /*
      8.4638911095,47.4834379430|8.5046595453,47.4046149269
      8.5244329867,47.4814981476|8.4129691189,47.3982152237
      8.4371175094,47.4519015578|8.5147623089,47.4321999727
     */

    final configs = [
      MultiRoadConfiguration(
        startPoint: GeoPoint(
          latitude: 47.4834379430,
          longitude: 8.4638911095,
        ),
        destinationPoint: GeoPoint(
          latitude: 47.4046149269,
          longitude: 8.5046595453,
        ),
      ),
      MultiRoadConfiguration(
          startPoint: GeoPoint(
            latitude: 47.4814981476,
            longitude: 8.5244329867,
          ),
          destinationPoint: GeoPoint(
            latitude: 47.3982152237,
            longitude: 8.4129691189,
          ),
          roadOptionConfiguration: const MultiRoadOption(
            roadColor: Colors.orange,
          )),
      MultiRoadConfiguration(
        startPoint: GeoPoint(
          latitude: 47.4519015578,
          longitude: 8.4371175094,
        ),
        destinationPoint: GeoPoint(
          latitude: 47.4321999727,
          longitude: 8.5147623089,
        ),
      ),
    ];
    final listRoadInfo = await controller.drawMultipleRoad(
      configs,
      commonRoadOption: const MultiRoadOption(
        roadColor: Colors.red,
      ),
    );
    debugPrint(listRoadInfo.toString());
  }

  Future<void> drawRoadManually() async {
    const encoded =
        "mfp_I__vpAqJ`@wUrCa\\dCgGig@{DwWq@cf@lG{m@bDiQrCkGqImHu@cY`CcP@sDb@e@hD_LjKkRt@InHpCD`F";
    final list = await encoded.toListGeo();
    await controller.drawRoadManually(
      list,
      const RoadOption(
        zoomInto: true,
        roadColor: Colors.blueAccent,
      ),
    );
  }
}

class RoadTypeChoiceWidget extends StatelessWidget {
  final Function(RoadType road) setValueCallback;

  const RoadTypeChoiceWidget({
    super.key,
    required this.setValueCallback,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: PopScope(
        canPop: false,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 64,
            width: 196,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            margin: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setValueCallback(RoadType.car);
                    Navigator.pop(context, RoadType.car);
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.directions_car),
                      Text("Car"),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setValueCallback(RoadType.bike);
                    Navigator.pop(context);
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.directions_bike),
                      Text("Bike"),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setValueCallback(RoadType.foot);
                    Navigator.pop(context);
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.directions_walk),
                      Text("Foot"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OSMLayersChoiceWidget extends StatelessWidget {
  final Function(CustomTile? layer) setLayerCallback;
  final GeoPoint centerPoint;
  const OSMLayersChoiceWidget({
    super.key,
    required this.setLayerCallback,
    required this.centerPoint,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 102,
          width: 342,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 8),
          child: PointerInterceptor(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setLayerCallback(CustomTile.publicTransportationOSM());
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox.square(
                        dimension: 64,
                        child: Image.asset(
                          'asset/transport.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Text("Transportation"),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setLayerCallback(CustomTile.cycleOSM());
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox.square(
                        dimension: 64,
                        child: Image.asset(
                          'asset/cycling.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Text("CycleOSM"),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setLayerCallback(null);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox.square(
                        dimension: 64,
                        child: Image.asset(
                          'asset/earth.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Text("OSM"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
class BlockMapExample extends StatelessWidget {
  const BlockMapExample({super.key});
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

///////////////////////////
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
//import 'package:osm_flutter_hooks/osm_flutter_hooks.dart';

class SimpleHookExample extends StatefulWidget {
  const SimpleHookExample({super.key});

  @override
  State<SimpleHookExample> createState() => _SimpleExampleState();
}

class _SimpleExampleState extends State<SimpleHookExample> {
  late PageController controller;
  late int indexPage;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 1);
    indexPage = controller.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("osm simple hook"),
      ),
      body: const SimpleOSM(),
    );
  }
}

class SimpleOSM extends HookWidget {
  const SimpleOSM({super.key});

  @override
  Widget build(BuildContext context) {
    /* final controller = useMapController(
        initPosition: GeoPoint(
      latitude: 47.4358055,
      longitude: 8.4737324,
    ));
    useMapIsReady(
      controller: controller,
      mapIsReady: () async {
        await controller.setZoom(zoomLevel: 15);
      },
    );*/
    return OSMFlutter(
      controller: MapController.withUserPosition(),
      osmOption: const OSMOption(),
    );
  }
}
