import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionCheckScreen extends StatelessWidget {
  const VersionCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Version Info'),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('App Version: ${snapshot.data!.version}');
                }
                return const CircularProgressIndicator();
              },
            ),
            ElevatedButton(
              onPressed: () {
                PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
                  print('App Version: ${packageInfo.version}');
                });
              },
              child: const Text('Check Version'),
            ),
          ],
        ),
      ),
    );
  }
}
