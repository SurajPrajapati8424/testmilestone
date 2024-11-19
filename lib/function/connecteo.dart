// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:connecteo/connecteo.dart';
import 'dart:async';

class ConnectivityService {
  static ConnectionChecker? _connecteo;
  static StreamSubscription<bool>? _subscription;
  static bool isConnected = true;

  static void listenForConnectivity(BuildContext context) {
    _connecteo = ConnectionChecker();
    _subscription = _connecteo?.connectionStream.listen((hasConnection) {
      if (!hasConnection) {
        // Show the no-internet dialog if there is no connection
        isConnected = false;
        showNoInternetDialog(context);
        debugPrint('No Internet');
      } else {
        // Close the dialog if connection is restored
        isConnected = true;
        Navigator.of(context, rootNavigator: true).pop('dialog');
      }
    });
  }

  // Method to show the "No Internet" dialog
  static void showNoInternetDialog(BuildContext context) {
    if (!isConnected) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('No Internet Connection'),
            content: Text('Please check your internet connection.'),
          );
        },
      );
    }
  }

  static void dispose() {
    _subscription?.cancel();
  }
}
