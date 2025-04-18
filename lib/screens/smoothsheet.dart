import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class BasicScrollableSheetExample extends StatelessWidget {
  const BasicScrollableSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Typically, you would use a Stack to place the sheet
      // on top of another widget.
      home: Stack(
        children: [
          Scaffold(
            // appBar: AppBar(),
            body: Column(
              children: [
                Container(width: 200, height: 200, color: Colors.deepOrange),
              ],
            ),
          ),
          const MySheet(),
        ],
      ),
    );
  }
}

class MySheet extends StatelessWidget {
  const MySheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a content whatever you want.
    // ScrollableSheet works with any scrollable widget such as
    // ListView, GridView, CustomScrollView, etc.
    final content = ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item $index'),
        );
      },
    );

    // Just wrap the content in a ScrollableSheet!
    final sheet = ScrollableSheet(
      child: buildSheetBackground(context, content),
      // Optional: Comment out the following lines to add multiple stop positions.
      //
      // minPosition: const SheetAnchor.proportional(0.2),
      // physics: BouncingSheetPhysics(
      //   parent: SnappingSheetPhysics(
      //     snappingBehavior: SnapToNearest(
      //       snapTo: [
      //         const SheetAnchor.proportional(0.2),
      //         const SheetAnchor.proportional(0.5),
      //         const SheetAnchor.proportional(1),
      //       ],
      //     ),
      //   ),
      // ),
    );

    return SafeArea(bottom: false, child: sheet);
  }

  Widget buildSheetBackground(BuildContext context, Widget content) {
    // Add background color, circular corners and material shadow to the sheet.
    // This is just an example, you can customize it however you want.
    return Material(
      color: Theme.of(context).colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: content,
    );
  }
}
