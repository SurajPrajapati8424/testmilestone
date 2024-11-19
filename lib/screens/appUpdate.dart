import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_version_update/app_version_update.dart';

class AppUpdateScreen extends StatefulWidget {
  const AppUpdateScreen({super.key});
  @override
  State<AppUpdateScreen> createState() => _AppUpdateScreenState();
}

class _AppUpdateScreenState extends State<AppUpdateScreen> {
  String latestVersion = '1.1.1';
  @override
  void initState() {
    super.initState();
    _verifyVersion();
  }

  void _verifyVersion() async {
    try {
      await AppVersionUpdate.checkForUpdates(
        // appleId: '284882215',
        playStoreId: 'com.example.testmilestone',
      ).then((result) async {
        print(result.storeVersion);
        if (result.canUpdate!) {
          // await AppVersionUpdate.showBottomSheetUpdate(context: context, appVersionResult: appVersionResult)
          // await AppVersionUpdate.showPageUpdate(context: context, appVersionResult: appVersionResult)
          // or use your own widget with information received from AppVersionResult
          await AppVersionUpdate.showAlertUpdate(
            appVersionResult: result,
            // ignore: use_build_context_synchronously
            context: context,
            backgroundColor: Colors.grey[200],
            title: 'A newer version is available.',
            titleTextStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 24.0),
            content: 'Would you like to update your app to the latest version?',
            contentTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            updateButtonText: 'UPDATE',
            cancelButtonText: 'UPDATE LATER',
          );

          //## AppVersionUpdate.showBottomSheetUpdate ##
          // await AppVersionUpdate.showBottomSheetUpdate(
          //   context: context,
          //   mandatory: true,
          //   appVersionResult: result,
          // );

          //## AppVersionUpdate.showPageUpdate ##

          // await AppVersionUpdate.showPageUpdate(
          //   context: context,
          //   appVersionResult: result,
          // );
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('au error');
        print(e);
        print('au error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Update Example'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('App Update Check'),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
