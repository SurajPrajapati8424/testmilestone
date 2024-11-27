/**
 * make import 'package:tab_switcher/animated_grid.dart' as grid;
 * TabSwitcherTabGrid
 */
import 'package:flutter/material.dart';
import 'package:tab_switcher/tab_count_icon.dart';
import 'package:tab_switcher/tab_switcher.dart';

class DemoSettings {
  static bool openTabsInForeground = true;
  static Brightness brightness = Brightness.light;
  static VoidCallback rebuildRootWidget = () {};
}

class TabswitcherExample extends StatelessWidget {
  const TabswitcherExample({super.key});

  @override
  Widget build(BuildContext context) => StatefulBuilder(
        builder: (context, setState) {
          DemoSettings.rebuildRootWidget = () => setState(() {});
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                brightness: DemoSettings.brightness),
            home: const TabSwitchTest(),
            debugShowCheckedModeBanner: false,
          );
        },
      );
}

class TabSwitchTest extends StatefulWidget {
  const TabSwitchTest({super.key});

  @override
  State<TabSwitchTest> createState() => TabSwitchTestState();
}

class TabSwitchTestState extends State<TabSwitchTest> {
  @override
  void initState() {
    super.initState();
    controller = TabSwitcherController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabSwitcherWidget(
        controller: controller,
        appBarBuilder: (context, tab) => tab != null
            ? AppBar(
                elevation: 0,
                title: Text(tab.getTitle()),
                actions: [
                  TabCountIcon(controller: controller),
                  DemoSettingsPopupButton(controller: controller),
                ],
              )
            : AppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Theme.of(context).textTheme.bodyLarge!.color,
                titleSpacing: 8,
                title: NewTabButton(controller: controller),
                actions: [
                  TabCountIcon(controller: controller),
                  DemoSettingsPopupButton(controller: controller),
                ],
              ),
      ),
    );
  }

  late TabSwitcherController controller;
}

class NewTabButton extends StatelessWidget {
  const NewTabButton({
    super.key,
    required this.controller,
  });

  final TabSwitcherController controller;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: MaterialButton(
        visualDensity: VisualDensity.compact,
        child: const Row(
          children: [
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('New tab'),
          ],
        ),
        onPressed: () => controller.pushTab(CounterTab(),
            foreground: DemoSettings.openTabsInForeground),
      ),
    );
  }
}

class DemoSettingsPopupButton extends StatelessWidget {
  const DemoSettingsPopupButton({required this.controller, super.key});

  final TabSwitcherController controller;

  @override
  Widget build(BuildContext context) => PopupMenuButton(
        itemBuilder: (BuildContext context) => [
          PopupMenuItem<String>(
            value: 'foreground',
            child: Text(
                'Open tabs in background: ${!DemoSettings.openTabsInForeground}'),
          ),
          const PopupMenuItem<String>(
            value: 'theme',
            child: Text('Toggle theme'),
          ),
        ],
        onSelected: (v) {
          if (v == "theme") {
            DemoSettings.brightness = DemoSettings.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark;
            DemoSettings.rebuildRootWidget();
          }
          if (v == "foreground") {
            DemoSettings.openTabsInForeground =
                !DemoSettings.openTabsInForeground;
          }
        },
      );
}

// CounterTab //

class CounterTab extends TabSwitcherTab {
  CounterTab() {
    totalCounterTabs++;
    tabInstanceNumber = totalCounterTabs;
  }

  @override
  Widget build(TabState state) => StatefulBuilder(
        builder: (context, setState) => Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      counter++;
                    });
                  },
                  child: const Text('+'),
                )
              ],
            ),
          ),
        ),
      );

  @override
  String getTitle() => 'Counter';

  @override
  String? getSubtitle() => 'Counter tab $tabInstanceNumber';

  @override
  void onSave(TabState state) {}

  int counter = 0;

  int tabInstanceNumber = 0;
  static int totalCounterTabs = 0;
}
