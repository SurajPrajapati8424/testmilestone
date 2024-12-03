import 'package:flutter/material.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class ScrollLoopExample extends StatefulWidget {
  const ScrollLoopExample({super.key});

  @override
  State<ScrollLoopExample> createState() => ScrollLoopExampleState();
}

class ScrollLoopExampleState extends State<ScrollLoopExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Example 01
                const Text(
                  '# Expample 01 : left to right scroll',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                const ScrollLoopAutoScroll(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    'Very long text that bleeds out of the rendering space',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                //Example 02
                const Text(
                  '# Expample 02 : righ to left scroll',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                const ScrollLoopAutoScroll(
                  scrollDirection: Axis.horizontal,
                  reverseScroll: true,
                  child: Text(
                    'Very long text that bleeds out of the rendering space',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                //Example 03
                const Text(
                  '# Expample 03 : Vertical Scroll Direction',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 199,
                  child: ScrollLoopAutoScroll(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width - 40,
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: const Text(
                            'ONE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width - 40,
                          color: Colors.red,
                          alignment: Alignment.center,
                          child: const Text(
                            'FOR',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width - 40,
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: const Text(
                            'ALL',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width - 40,
                          color: Colors.orange,
                          alignment: Alignment.center,
                          child: const Text(
                            'AND',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width - 40,
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: const Text(
                            'ALL',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width - 40,
                          color: Colors.red,
                          alignment: Alignment.center,
                          child: const Text(
                            'FOR',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width - 40,
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: const Text(
                            'ONE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                //Example 04
                const Text(
                  '# Expample 04 : Horizontal Scroll Direction',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: ScrollLoopAutoScroll(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width / 2,
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: const Text(
                            'ONE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width / 2,
                          color: Colors.red,
                          alignment: Alignment.center,
                          child: const Text(
                            'FOR',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width / 2,
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: const Text(
                            'ALL',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width / 2,
                          color: Colors.orange,
                          alignment: Alignment.center,
                          child: const Text(
                            'AND',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width / 2,
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: const Text(
                            'ALL',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width / 2,
                          color: Colors.red,
                          alignment: Alignment.center,
                          child: const Text(
                            'FOR',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width / 2,
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: const Text(
                            'ONE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
