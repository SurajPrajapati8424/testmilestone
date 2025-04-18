// // ignore_for_file: prefer_conditional_assignment, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings, unnecessary_to_list_in_spreads

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:secure_application/secure_application.dart';

// class SecureAppScreen extends StatefulWidget {
//   const SecureAppScreen({super.key});
//   @override
//   SecureAppScreenState createState() => SecureAppScreenState();
// }

// class SecureAppScreenState extends State<SecureAppScreen> {
//   bool failedAuth = false;
//   double blurr = 20;
//   double opacity = 0.6;
//   StreamSubscription<bool>? subLock;
//   List<String> history = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     subLock?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width * 0.8;
//     return MaterialApp(
//       home: SecureApplication(
//         nativeRemoveDelay: 1000,
//         onNeedUnlock: (secure) async {
//           print(
//               'need unlock maybe use biometric to confirm and then sercure.unlock() or you can use the lockedBuilder');
//           // var authResult = authMyUser();
//           // if (authResul) {
//           //  secure.unlock();
//           //  return SecureApplicationAuthenticationStatus.SUCCESS;
//           //}
//           // else {
//           //  return SecureApplicationAuthenticationStatus.FAILED;
//           //}
//           return null;
//         },
//         onAuthenticationFailed: () async {
//           // clean you data
//           setState(() {
//             failedAuth = true;
//           });
//           print('auth failed');
//         },
//         onAuthenticationSucceed: () async {
//           // clean you data

//           setState(() {
//             failedAuth = false;
//           });
//           print('auth success');
//         },
//         child: Builder(builder: (context) {
//           if (subLock == null)
//             subLock = SecureApplicationProvider.of(context, listen: false)
//                 ?.lockEvents
//                 .listen((s) => history.add(
//                     '${DateTime.now().toIso8601String()} - ${s ? 'locked' : 'unlocked'}'));
//           return SecureGate(
//             blurr: blurr,
//             opacity: opacity,
//             lockedBuilder: (context, secureNotifier) => Center(
//                 child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 ElevatedButton(
//                   child: const Text('UNLOCK'),
//                   onPressed: () => secureNotifier?.authSuccess(unlock: true),
//                 ),
//                 ElevatedButton(
//                   child: const Text('FAIL AUTHENTICATION'),
//                   onPressed: () => secureNotifier?.authFailed(unlock: true),
//                 ),
//               ],
//             )),
//             child: Scaffold(
//               appBar: AppBar(
//                 title: const Text('Secure Window Example'),
//               ),
//               body: Center(
//                 child: Builder(builder: (context) {
//                   var valueNotifier = SecureApplicationProvider.of(context);
//                   if (valueNotifier == null)
//                     throw Exception(
//                         'Unable to find secure application context');
//                   return ListView(
//                     children: <Widget>[
//                       const Text('This is secure content'),
//                       ValueListenableBuilder<SecureApplicationState>(
//                         valueListenable: valueNotifier,
//                         builder: (context, state, _) => state.secured
//                             ? Column(
//                                 children: <Widget>[
//                                   ElevatedButton(
//                                     onPressed: () => valueNotifier.open(),
//                                     child: const Text('Open app'),
//                                   ),
//                                   state.paused
//                                       ? ElevatedButton(
//                                           onPressed: () =>
//                                               valueNotifier.unpause(),
//                                           child: const Text('resume security'),
//                                         )
//                                       : ElevatedButton(
//                                           onPressed: () =>
//                                               valueNotifier.pause(),
//                                           child: const Text('pause security'),
//                                         ),
//                                 ],
//                               )
//                             : ElevatedButton(
//                                 onPressed: () => valueNotifier.secure(),
//                                 child: const Text('Secure app'),
//                               ),
//                       ),
//                       failedAuth
//                           ? const Text(
//                               'Auth failed we cleaned sensitive data',
//                               style: TextStyle(color: Colors.red),
//                             )
//                           : const Text(
//                               'Auth success',
//                               style: TextStyle(color: Colors.green),
//                             ),
//                       FlutterLogo(
//                         size: width,
//                       ),
//                       StreamBuilder(
//                         stream: valueNotifier.authenticationEvents,
//                         builder: (context, snapshot) =>
//                             Text('Last auth status is: ${snapshot.data}'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () => valueNotifier.lock(),
//                         child: const Text('manually lock'),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: <Widget>[
//                             const Text('Blurr:'),
//                             Expanded(
//                               child: Slider(
//                                   value: blurr,
//                                   min: 0,
//                                   max: 100,
//                                   onChanged: (v) => setState(() => blurr = v)),
//                             ),
//                             Text(blurr.floor().toString()),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: <Widget>[
//                             const Text('opacity:'),
//                             Expanded(
//                               child: Slider(
//                                   value: opacity,
//                                   min: 0,
//                                   max: 1,
//                                   onChanged: (v) =>
//                                       setState(() => opacity = v)),
//                             ),
//                             Text((opacity * 100).floor().toString() + "%"),
//                           ],
//                         ),
//                       ),
//                       ...history.map<Widget>((h) => Text(h)).toList(),
//                     ],
//                   );
//                 }),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
