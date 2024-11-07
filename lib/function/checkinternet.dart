// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class ConnectivityService {
  static StreamSubscription<List<ConnectivityResult>>? _subscription;
  static bool isConnected = true;
  static void listenForConnectivity(BuildContext context) {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
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
    if (isConnected) {
      showDialog(
        context: context,
        barrierDismissible:
            false, // Prevent dialog from closing if tapped outside
        builder: (context) => const AlertDialog(
          title: Text('No Internet Connection'),
          content: Text('Please check your internet connection and try again.'),
          actions: [
            // TextButton(
            //   onPressed: () {
            //     // Navigator.of(context).pop(); // Only closes if user explicitly taps OK
            //   },
            //   child: const Text('OK'),
            // ),
          ],
        ),
      );
    }
  }

  static void dispose() {
    _subscription?.cancel();
  }
}

/////////////////////////

// class ConnectivityListener extends StatefulWidget {
//   const ConnectivityListener({super.key});

//   @override
//   ConnectivityListenerState createState() => ConnectivityListenerState();
// }

// class ConnectivityListenerState extends State<ConnectivityListener> {
//   late StreamSubscription<List<ConnectivityResult>> subscription;
//   bool isConnected = true;

//   @override
//   void initState() {
//     super.initState();
//     subscription = Connectivity().onConnectivityChanged.listen(
//       (List<ConnectivityResult> result) {
//         _startConnectivityMonitoring(result);
//       },
//     );
//   }

//   // Monitor connectivity changes and show/hide alert dialog
//   void _startConnectivityMonitoring(List<ConnectivityResult> result) async {
//     debugPrint('result:$result');
//     if (result.contains(ConnectivityResult.none)) {
//       _showNoConnectionDialog();
//       debugPrint('NO Internet');
//     } else {
//       // _dismissNoConnectionDialog();
//       // Checking for actual internet access
//       final connectivityResult = await (Connectivity().checkConnectivity());
//       if (connectivityResult[0] != ConnectivityResult.none) {
//         // Close dialog if connected
//         // ignore: use_build_context_synchronously
//         Navigator.of(context).pop();
//       }
//     }
//   }

//   // Show the "No Internet Connection" dialog
//   void _showNoConnectionDialog() {
//     if (isConnected) {
//       isConnected = false;
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("No Internet Connection"),
//             content: const Text(
//                 "Please check your internet connection and try again."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   isConnected = false;
//                 },
//                 child: const Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   void dispose() {
//     subscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// Future<void> checkInternetConnection() async {
//   bool isDialogOpen = false;
//   Connectivity()
//       .onConnectivityChanged
//       .listen((List<ConnectivityResult> result) {
//     if (result.contains(ConnectivityResult.mobile)) {
//       debugPrint('Internet is mobile');
//       isDialogOpen = false;
//     } else if (result.contains(ConnectivityResult.wifi)) {
//       isDialogOpen = false;
//       debugPrint('Internet is wifi');
//     } else if (result.contains(ConnectivityResult.ethernet)) {
//       isDialogOpen = false;
//       debugPrint('Internet is ethernet');
//     } else if (result.contains(ConnectivityResult.none)) {
//       isDialogOpen = true;
//       debugPrint('Internet is gone #1');
//       // showDisconnectedDialog(context);
//     } else {
//       if (isDialogOpen) {
//         debugPrint('Internet is gone #2');
//         // Navigator.of(context, rootNavigator: true).pop();
//         isDialogOpen = false;
//       }
//     }
//   });
// }

// Future<void> showDisconnectedDialog(BuildContext context) async {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('No Internet Connection'),
//         content: SizedBox(
//           width: 100.w,
//           height: 100.w,
//           child: AspectRatio(
//             aspectRatio: 1 / 1,
//             child: Image.network(
//               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoMjTej17jyKAPjSPj9WUba4nxOaXh5_rIz-aoWffQ1aPO_REI',
//             ),
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Refresh'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
