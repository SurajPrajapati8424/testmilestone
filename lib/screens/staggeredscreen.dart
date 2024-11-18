// ignore_for_file: use_super_parameters, sized_box_for_whitespace
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StaggeredScreen extends StatelessWidget {
  const StaggeredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated List/Grid/Column'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('List Card Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CardListScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Grid Card Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CardGridScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Column Card Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CardColumnScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardColumnScreen extends StatefulWidget {
  const CardColumnScreen({Key? key}) : super(key: key);

  @override
  State<CardColumnScreen> createState() => _CardColumnScreenState();
}

class _CardColumnScreenState extends State<CardColumnScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoRefresh(
      duration: const Duration(milliseconds: 2000),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: MediaQuery.of(context).size.width / 2,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    EmptyCard(
                      width: MediaQuery.of(context).size.width,
                      height: 166.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          EmptyCard(height: 50.0, width: 50.0),
                          EmptyCard(height: 50.0, width: 50.0),
                          EmptyCard(height: 50.0, width: 50.0),
                        ],
                      ),
                    ),
                    const Row(
                      children: [
                        Flexible(child: EmptyCard(height: 150.0)),
                        Flexible(child: EmptyCard(height: 150.0)),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Flexible(child: EmptyCard(height: 50.0)),
                          Flexible(child: EmptyCard(height: 50.0)),
                          Flexible(child: EmptyCard(height: 50.0)),
                        ],
                      ),
                    ),
                    EmptyCard(
                      width: MediaQuery.of(context).size.width,
                      height: 166.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardGridScreen extends StatefulWidget {
  const CardGridScreen({Key? key}) : super(key: key);
  @override
  State<CardGridScreen> createState() => _CardGridScreenState();
}

class _CardGridScreenState extends State<CardGridScreen> {
  @override
  Widget build(BuildContext context) {
    var columnCount = 3;

    return AutoRefresh(
      duration: const Duration(milliseconds: 2000),
      child: Scaffold(
        body: SafeArea(
          child: AnimationLimiter(
            child: GridView.count(
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(8.0),
              crossAxisCount: columnCount,
              children: List.generate(
                100,
                (int index) {
                  return AnimationConfiguration.staggeredGrid(
                    columnCount: columnCount,
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: const ScaleAnimation(
                      scale: 0.5,
                      child: FadeInAnimation(
                        child: EmptyCard(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardListScreen extends StatefulWidget {
  const CardListScreen({Key? key}) : super(key: key);

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoRefresh(
      duration: const Duration(milliseconds: 2000),
      child: Scaffold(
        body: SafeArea(
          child: AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 44.0,
                    child: FadeInAnimation(
                      child: EmptyCard(
                        width: MediaQuery.of(context).size.width,
                        height: 88.0,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Automatically rebuild [child] widget after the given [duration]
class AutoRefresh extends StatefulWidget {
  final Duration duration;
  final Widget child;

  const AutoRefresh({
    super.key,
    required this.duration,
    required this.child,
  });

  @override
  State<AutoRefresh> createState() => _AutoRefreshState();
}

class _AutoRefreshState extends State<AutoRefresh> {
  int? keyValue;
  ValueKey? key;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    keyValue = 0;
    key = ValueKey(keyValue);

    _recursiveBuild();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }

  void _recursiveBuild() {
    _timer = Timer(
      widget.duration,
      () {
        setState(() {
          keyValue = keyValue! + 1;
          key = ValueKey(keyValue);
          _recursiveBuild();
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class EmptyCard extends StatelessWidget {
  final double? width;
  final double? height;

  const EmptyCard({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
    );
  }
}

// class CardListScreen extends StatelessWidget {
//   const CardListScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       body: ListView.builder(
//         itemCount: 100,
//         itemBuilder: (BuildContext context, int index) {
//           return AnimationConfiguration.staggeredList(
//             position: index,
//             duration: const Duration(milliseconds: 375),
//             child: SlideAnimation(
//               verticalOffset: 50.0,
//               child: FadeInAnimation(
//                 child: Card(
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text('DUMMY $index'),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class CardGridScreen extends StatelessWidget {
//   const CardGridScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 100,
//       itemBuilder: (BuildContext context, int index) {
//         return AnimationConfiguration.staggeredGrid(
//           columnCount: 3,
//           position: index,
//           duration: const Duration(milliseconds: 375),
//           child: SlideAnimation(
//             verticalOffset: 50.0,
//             child: FadeInAnimation(
//               child: Card(
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('DUMMY $index'),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class CardColumnScreen extends StatelessWidget {
//   const CardColumnScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 100,
//       itemBuilder: (BuildContext context, int index) {
//         return AnimationConfiguration.staggeredList(
//           position: index,
//           duration: const Duration(milliseconds: 375),
//           child: SlideAnimation(
//             verticalOffset: 50.0,
//             child: FadeInAnimation(
//               child: Card(
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('DUMMY $index'),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
