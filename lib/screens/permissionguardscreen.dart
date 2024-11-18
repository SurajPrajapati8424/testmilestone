// ignore_for_file: unused_import, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:permission_guard/permission_guard.dart';
import '../widgets/button.dart';

class PermissionGuardScreen extends StatelessWidget {
  const PermissionGuardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Permission.storage.requestGuarded(context).then((onValue) {
    //   if (onValue != PermissionStatus.granted ||
    //       onValue != PermissionStatus.limited) {

    //   }
    //   debugPrint('Photo Permission Granted');
    // });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 01
            // Button(
            //   text: 'Go to Setting',
            //   onTap: () async {
            //     bool openSetting = await openAppSettings();
            //     debugPrint('openSetting :$openSetting');
            //   },
            // ),
            // // 02
            PermissionGuard(
              permission: Permission.storage,
              child: const PermissionGrantedBody(),
              onPermissionStatusChanged: (status) {
                if (status != PermissionStatus.granted ||
                    status != PermissionStatus.limited) {
                  debugPrint('PermissionStatus.denied');
                  Future.delayed(const Duration(seconds: 2), () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Storage Permission Denied'),
                          content: const Text(
                              'Storage permission is required to proceed'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OPEN SETTINGS'),
                              onPressed: () async {
                                // Navigator.of(context).pop();
                                await openAppSettings();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  });
                }
                debugPrint('Permission status changed: $status');
              },
              onPermissionGranted: () {
                debugPrint('Permission granted');
              },
            ),
            // 03
            // Button(
            //     text: 'Permission with requestGuarded()',
            //     onTap: customPermission(context)),
            // 04
            // Button(
            //   text: 'Permission with Request',
            //   onTap: () async {
            //     final status = await Permission.storage.request();
            //     debugPrint('Status :$status');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

// 03
customPermission(BuildContext context) {
  Permission.storage.requestGuarded(context).then((onValue) {
    if (onValue != PermissionStatus.granted) return;
    debugPrint('Photo Permission Granted');
  });
}

class PermissionGrantedBody extends StatelessWidget {
  const PermissionGrantedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: Color(0xFFFF981F),
            size: 48,
          ),
          SizedBox(height: 5),
          Text(
            'This is the child content\nprovided to PermissionGuard',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


/*
PermissionGuardOptions({
  // Useful to customize the behavior of the guardian.
  bool requestOnInit,
  bool skipInitialChange,
  List<PermissionStatus> validStatuses,
  // Useful to customize loader appearance & behavior.
  bool displayLoader,
  Widget loader,
  // Useful to override the default dimensions.
  EdgeInsets? padding,
  double? iconSpacing,
  double? titleSpacing,
  double? descriptionSpacing,
  // Useful to override default icon.
  Widget? icon,
  // Useful to override default strings with translated ones based on status.
  String Function(PermissionStatus status)? title,
  String Function(PermissionStatus status)? description,
  String Function(PermissionStatus status)? action,
  // Useful to provide custom widgets based on status.
  Widget Function(PermissionStatus status)? titleBuilder,
  Widget Function(PermissionStatus status)? descriptionBuilder,
  // (Provides action `call` method so it can be used in a custom widget)
  Widget Function(PermissionStatus status, VoidCallback call)? actionBuilder,
});
*/
/*
PermissionGuardOptions(
  requestOnInit: true,
  displayLoader: true,
  loader: CircularProgressIndicator(),
)
*/
