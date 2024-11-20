import 'package:flutter/material.dart';

import '../widgets/button.dart';
import 'slidetoastscreen.dart';

class PopScopeScreen extends StatefulWidget {
  const PopScopeScreen({super.key});

  @override
  State<PopScopeScreen> createState() => _PopScopeScreenState();
}

class _PopScopeScreenState extends State<PopScopeScreen> {
  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Are you sure you want to leave this page?'),
          actions: [
            TextButton(
              child: const Text('Nevermind'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: const Text('Leave'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          popToast(
            context: context,
            text: 'Popped Successsfully',
            toastAlignment: Alignment.topCenter,
            onTapped: () {},
            onDisposed: () {},
          );
          print('Popped');
        } else {
          print('Cannot Pop');
          final bool shouldPop = await _showBackDialog() ?? false;
          if (context.mounted && shouldPop) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button(
              text: 'Go Back',
              onTap: () async {
                final bool shouldPop = await _showBackDialog() ?? false;
                if (context.mounted && shouldPop) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        )),
      ),
    );
  }
}
