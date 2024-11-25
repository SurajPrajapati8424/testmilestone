import 'package:flutter/material.dart';
import 'package:scroll_to_top/scroll_to_top.dart';

class ScrolltotopExample extends StatelessWidget {
  const ScrolltotopExample({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(),
      body: ScrollToTop(
        btnColor: const Color(0xFF00C85C),
        txtColor: Colors.black,
        scrollOffset: 400,
        scrollController: scrollController,
        child: ListView.builder(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: 50,
          itemBuilder: (context, index) {
            return testCard(context, '$index', 60);
          },
        ),
      ),
    );
  }
}

Widget testCard(BuildContext context, String value, double height) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: height,
    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black12, blurRadius: 4.0, offset: Offset(0.0, 4.0)),
      ],
    ),
    child: Center(
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Index $value",
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    ),
  );
}
