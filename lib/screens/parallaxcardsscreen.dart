import 'package:flutter/material.dart';
import 'package:parallax_image_ns/parallax_image.dart';

// LINKS //
const List<String> imagesList = [
  'https://lp-cms-production.imgix.net/2020-10/500pxRF_16641625.jpg',
  'https://imageio.forbes.com/specials-images/imageserve/675172642/pura-ulun-danu-bratan-temple-in-Bali-/960x0.jpg?format=jpg&width=960',
  'https://lp-cms-production.imgix.net/2020-10/500pxRF_16641625.jpg',
  'https://imageio.forbes.com/specials-images/imageserve/675172642/pura-ulun-danu-bratan-temple-in-Bali-/960x0.jpg?format=jpg&width=960',
  'https://imageio.forbes.com/specials-images/imageserve/466090186/Panoramic-view-of-the-Mosques-of-Sultan-Hassan-and-Al-Rifai/960x0.jpg?format=jpg&width=960',
  'https://imageio.forbes.com/specials-images/imageserve/466090186/Panoramic-view-of-the-Mosques-of-Sultan-Hassan-and-Al-Rifai/960x0.jpg?format=jpg&width=960',
  'https://lp-cms-production.imgix.net/2020-10/500pxRF_16641625.jpg',
];

const List<String> titlesList = [
  'Colosseum',
  'Florence',
  'Naples',
  'Machu Picchu',
  'Bali',
  'Cairo'
];

class ParallaxcardExample extends StatelessWidget {
  const ParallaxcardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              'Horizontal scroll parallax',
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            constraints: const BoxConstraints(maxHeight: 200.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6, // null safety  / harfang
              itemBuilder: _buildHorizontalChild,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              'Vertical scroll parallax',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6, // null safety / harfang
              itemBuilder: _buildVerticalChild,
            ),
          )
        ],
      ),
    );
  }

  // childs //
  Widget _buildVerticalChild(BuildContext context, int index) {
    index++;
    if (index > 6) return Container(); //  null safety / harfang
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          print('Tapped $index');
        },
        child: ParallaxImage(
          extent: 150.0,
          image: NetworkImage(imagesList[index]),
          // ExactAssetImage(
          //   'images/img$index.jpg',
          // ),
        ),
      ),
    );
  }

  Widget _buildHorizontalChild(BuildContext context, int index) {
    index++;
    if (index > 6) return Container(); // null safety safety

    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ParallaxImage(
        extent: 110.0,
        image: NetworkImage(imagesList[index]), //  null safety / harfang
        // ExactAssetImage(
        //   'images/img$index.jpg',
        // ),
      ),
    );
  }
}
