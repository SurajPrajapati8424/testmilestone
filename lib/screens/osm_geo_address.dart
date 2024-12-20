// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:geocoding/geocoding.dart';
import '../widgets/text.dart';
import '../widgets/button.dart';

class OSMtest extends StatelessWidget {
  const OSMtest({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<GeoPoint?> notifier = ValueNotifier(null);
    ValueNotifier<Placemark?> address = ValueNotifier(null);
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
                  child: TextWidget(
                    text:
                        // p?.toString() ?? "",
                        p != null
                            ? "lat: ${p.latitude.toStringAsFixed(6)}\nlong: ${p.longitude.toStringAsFixed(6)}"
                            : "no location picked",
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            Column(
              children: [
                Button(
                    onTap: () async {
                      var p = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const SearchPage()));
                      if (p != null) {
                        notifier.value = p as GeoPoint;
                        print(p);
                      }
                    },
                    text: "pick address"),
                Button(
                  text: "Look up Adderess",
                  onTap: () async {
                    address.value = await getLocationDetails(notifier.value!);
                  },
                ),
                // Address
                ValueListenableBuilder<Placemark?>(
                  valueListenable: address,
                  builder: (ctx, p, child) {
                    return Center(
                      child: TextWidget(
                        text: p != null
                            ? ">>> $p"
                            // "City: ${p.locality ?? 'N/A'}\nState: ${p.administrativeArea ?? 'N/A'}\nCountry: ${p.country ?? 'N/A'}\nPincode: ${p.postalCode ?? 'N/A'}"
                            : "no address picked",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

///////////////
Future<Placemark?> getLocationDetails(GeoPoint point) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(point.latitude, point.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      print("Location details:\n$place");
      return place;
    }
  } catch (e) {
    print("Error getting location details: $e");
  }
  return null;
}

////////////////////////////////
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // late TextEditingController textEditingController = TextEditingController();
  final PickerMapController controller = PickerMapController(
    initMapWithUserPosition:
        const UserTrackingOption(enableTracking: true, unFollowUser: false),
  );

  // @override
  // void initState() {
  //   super.initState();
  //   textEditingController.addListener(textOnChanged);
  // }

  // void textOnChanged() {
  //   controller.setSearchableText(textEditingController.text);
  // }

  @override
  void dispose() {
    // textEditingController.removeListener(textOnChanged);
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPickerLocation(
      controller: controller,
      showDefaultMarkerPickWidget: true,
      topWidgetPicker: null,
      bottomWidgetPicker: Positioned(
        bottom: 12,
        right: 8,
        child: PointerInterceptor(
          child: FloatingActionButton(
            onPressed: () async {
              GeoPoint p = await controller.selectAdvancedPositionPicker();
              await getLocationDetails(p);
              Navigator.pop(context, p);
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ),
      ),
      pickerConfig: const CustomPickerLocationConfig(
        zoomOption: ZoomOption(
          initZoom: 18,
        ),
      ),
    );
  }
}
