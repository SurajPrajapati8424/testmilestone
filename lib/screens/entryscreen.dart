import 'dart:math';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';

/// Custom card used for every example
class CustomCard extends StatelessWidget {
  const CustomCard(this.label, {super.key});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.grey[300],
        width: 128,
        height: 128,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

/// Example app widget
class EntryappExample extends StatefulWidget {
  const EntryappExample({super.key});

  @override
  State<EntryappExample> createState() => EntryappExampleState();
}

class EntryappExampleState extends State<EntryappExample> {
  /// List of the tabs titles
  final tabs = [
    "Constructors",
    "Entry combinations",
    "Staggered builds",
    "Randomization"
  ];

  /// Random instance
  final random = Random();

  var visible = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: TabBar(
              isScrollable: true,
              tabs: [
                for (var tab in tabs)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      tab,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
              ],
            ),
            body: TabBarView(
              children: [
                // Constructors
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: [
                        Entry.all(
                          visible: visible,
                          duration: const Duration(seconds: 1),
                          child: const CustomCard("Entry.all()"),
                        ),
                        Entry.opacity(
                          visible: visible,
                          duration: const Duration(seconds: 1),
                          child: const CustomCard("Entry.opacity()"),
                        ),
                        Entry.scale(
                          visible: visible,
                          duration: const Duration(seconds: 1),
                          child: const CustomCard("Entry.scale()"),
                        ),
                        Entry.offset(
                          visible: visible,
                          duration: const Duration(seconds: 1),
                          child: const CustomCard("Entry.offset()"),
                        ),
                      ],
                    ),
                    Center(
                        child: ElevatedButton(
                      onPressed: () => setState(() => visible = !visible),
                      child: Text("visible : $visible"),
                    )),
                  ],
                ),
                // Entry combinations
                const Center(
                  child: Wrap(
                    children: [
                      // Example 1
                      Entry(
                        xOffset: -1000,
                        scale: 20,
                        delay: Duration(milliseconds: 300),
                        duration: Duration(milliseconds: 700),
                        curve: Curves.ease,
                        child: Entry(
                          opacity: .5,
                          angle: 3.1415,
                          scale: .5,
                          delay: Duration(milliseconds: 900),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.decelerate,
                          child: CustomCard("Example 1"),
                        ),
                      ),
                      // Example 2
                      Entry(
                        delay: Duration(milliseconds: 300),
                        duration: Duration(milliseconds: 300),
                        opacity: 0,
                        yOffset: -1000,
                        curve: Curves.easeInOutCubic,
                        child: Entry(
                          delay: Duration(milliseconds: 450),
                          duration: Duration(milliseconds: 600),
                          curve: Curves.decelerate,
                          scale: 0.5,
                          angle: 1.5707,
                          child: CustomCard("Example 2"),
                        ),
                      ),
                      // Example 3
                      Entry(
                        delay: Duration(milliseconds: 300),
                        duration: Duration(milliseconds: 700),
                        yOffset: 1000,
                        xOffset: 1000,
                        angle: -4.1415,
                        curve: Curves.fastOutSlowIn,
                        child: Entry(
                          delay: Duration(milliseconds: 1000),
                          duration: Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                          opacity: 0.5,
                          scale: 0.5,
                          child: CustomCard("Example 3"),
                        ),
                      ),
                    ],
                  ),
                ),

                // Staggered builds
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    itemCount: 100,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => Entry.all(
                      delay: Duration(milliseconds: (200 * (index % 3))),
                      child: CustomCard("Card n°$index"),
                    ),
                  ),
                ),
                // Randomization
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    itemCount: 100,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => Entry.all(
                      delay: Duration(milliseconds: random.nextInt(300)),
                      child: CustomCard("Card n°$index"),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: Builder(
              builder: (context) {
                return FloatingActionButton(
                  child: const Icon(Icons.refresh),
                  onPressed: () async {
                    // Re-initializes the whole page to show the animations again
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const EntryappExample(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
