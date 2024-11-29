// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:advstory/advstory.dart';

// Test data for the stories.
const userNames = [
  'Esther W Roberts',
  'Virgil T Vogel',
  'Paula A Dixon',
  'Barbara W Yanez',
  'Johnny N Hayes',
];
const profilePics = [
  'https://www.fakepersongenerator.com/Face/female/female1023053261475.jpg',
  'https://www.fakepersongenerator.com/Face/male/male1085513896637.jpg',
  'https://www.fakepersongenerator.com/Face/female/female20131023576348938.jpg',
  'https://www.fakepersongenerator.com/Face/female/female1021769569641.jpg',
  'https://www.fakepersongenerator.com/Face/male/male20161086415248322.jpg',
];
const videoUrls = [
  'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-man-under-multicolored-lights-1237-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
];
const imageUrls = [
  'https://images.unsplash.com/photo-1651979822227-31948d6c83bc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  'https://images.unsplash.com/photo-1641978909561-015aaa540119?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  'https://images.unsplash.com/photo-1652007682665-e06a8ac589dd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  'https://images.unsplash.com/photo-1641981601596-39a7403ebf47?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
  'https://images.unsplash.com/photo-1593642634443-44adaa06623a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1325&q=80',
  'https://images.unsplash.com/photo-1641982661987-351363e6785e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80',
  'https://images.unsplash.com/photo-1641982705401-1f0ed07ff5d0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=699&q=80',
];

class AdvStoryDemo extends StatefulWidget {
  const AdvStoryDemo({super.key});

  @override
  State<AdvStoryDemo> createState() => _AdvStoryDemoState();
}

class _AdvStoryDemoState extends State<AdvStoryDemo> {
  int _selectedIndex = 0;
  late final items = const [
    TrayShowcase(),
    StoryTypeShowcase(),
    FooterHeaderShowcase(),
    ControllerUsage(),
    Player(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: "Trays",
            icon: Icon(Icons.palette_outlined),
          ),
          BottomNavigationBarItem(
            label: "Contents",
            icon: Icon(Icons.extension),
          ),
          BottomNavigationBarItem(
            label: "Footer &\nHeader",
            icon: Icon(Icons.unfold_more_outlined),
          ),
          BottomNavigationBarItem(
            label: "Controller",
            icon: Icon(Icons.signpost_outlined),
          ),
          BottomNavigationBarItem(
            label: "Player",
            icon: Icon(Icons.play_circle_rounded),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}

// TrayShowcase //
class TrayShowcase extends StatefulWidget {
  const TrayShowcase({super.key});

  @override
  State<TrayShowcase> createState() => _TrayShowcaseState();
}

class _TrayShowcaseState extends State<TrayShowcase> {
  bool _isHorizontal = true;

  Widget _title(String title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blueGrey.shade400,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('AdvStory Demo'),
        backgroundColor: Colors.deepOrangeAccent.withOpacity(.8),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Flex(
          direction: _isHorizontal ? Axis.vertical : Axis.horizontal,
          children: [
            AdvStoryTrayCustomization(isHorizontal: _isHorizontal),
            const Spacer(),
            if (_isHorizontal) _title("Animated Custom Tray"),
            SizedBox(
              height: _isHorizontal ? 100 : double.maxFinite,
              width: _isHorizontal ? double.maxFinite : 100,
              child: AdvStory(
                // Disable story build on scroll to increasing animation
                // duration.
                buildStoryOnTrayScroll: false,
                style: AdvStoryStyle(
                  trayListStyle: TrayListStyle(
                    direction: _isHorizontal ? Axis.horizontal : Axis.vertical,
                  ),
                ),
                storyCount: userNames.length,
                storyBuilder: (index) {
                  return Story(
                    contentCount: 3,
                    contentBuilder: (contentIndex) {
                      return contentIndex % 2 == 0
                          ? VideoContent(url: videoUrls[contentIndex])
                          : ImageContent(url: imageUrls[contentIndex]);
                    },
                  );
                },
                trayBuilder: (index) => CustomAnimatedTray(
                  profilePic: profilePics[index],
                ),
              ),
            ),
            const Spacer(),
            if (_isHorizontal) _title("Non Animated Custom Tray"),
            SizedBox(
              height: _isHorizontal ? 80 : double.maxFinite,
              width: _isHorizontal ? double.maxFinite : 80,
              child: AdvStory(
                style: AdvStoryStyle(
                  trayListStyle: TrayListStyle(
                    direction: _isHorizontal ? Axis.horizontal : Axis.vertical,
                  ),
                ),
                storyCount: userNames.length,
                storyBuilder: (index) {
                  return Story(
                    contentCount: 3,
                    contentBuilder: (contentIndex) {
                      return contentIndex % 2 == 0
                          ? VideoContent(url: videoUrls[contentIndex])
                          : ImageContent(url: imageUrls[contentIndex]);
                    },
                  );
                },
                trayBuilder: (index) => Center(
                  child: CustomNonAnimatedTray(
                    profilePic: profilePics[index],
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent.withOpacity(.8),
        onPressed: () {
          setState(() {
            _isHorizontal = !_isHorizontal;
          });
        },
        child: const Icon(Icons.rotate_90_degrees_cw_outlined),
      ),
    );
  }
}

/// [AdvStoryTray].
class AdvStoryTrayCustomization extends StatefulWidget {
  const AdvStoryTrayCustomization({
    required this.isHorizontal,
    super.key,
  });

  /// Story list direction
  final bool isHorizontal;

  @override
  State<AdvStoryTrayCustomization> createState() =>
      _AdvStoryTrayCustomizationState();
}

class _AdvStoryTrayCustomizationState extends State<AdvStoryTrayCustomization> {
  double _width = 85;
  double _height = 85;
  double _radius = 50;
  double _strokeWidth = 2;
  double _gapSize = 3;
  bool _showUserNames = false;

  final _defaultBorderColors = [
    const Color(0xaf405de6),
    const Color(0xaf5851db),
    const Color(0xaf833ab4),
    const Color(0xafc13584),
    const Color(0xafe1306c),
    const Color(0xaffd1d1d),
    const Color(0xaf405de6),
  ];
  late List<Color> _selectedColors = _defaultBorderColors;

  double _lerp = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.isHorizontal ? _height + 60 : double.maxFinite,
      width: widget.isHorizontal ? double.maxFinite : _width + 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "AdvStoryTray Customization",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey.shade400,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      barrierColor: Colors.black.withOpacity(.1),
                      builder: (context) {
                        return _controls();
                      },
                    );
                  },
                  child: const Icon(Icons.settings),
                ),
              ],
            ),
          ),
          Expanded(
            child: AdvStory(
              storyCount: userNames.length,
              storyBuilder: (index) async {
                return Story(
                  contentCount: 3,
                  contentBuilder: (contentIndex) => contentIndex % 2 == 0
                      ? ImageContent(url: imageUrls[contentIndex])
                      : VideoContent(url: videoUrls[contentIndex]),
                  header: StoryHeader(
                    url: profilePics[index],
                    text: userNames[index],
                  ),
                  footer: const MessageBox(),
                );
              },
              style: AdvStoryStyle(
                trayListStyle: TrayListStyle(
                  direction:
                      widget.isHorizontal ? Axis.horizontal : Axis.vertical,
                ),
              ),
              trayBuilder: (index) {
                return AdvStoryTray(
                  url: profilePics[index],
                  size: Size(_width, _height),
                  shape: BoxShape.rectangle,
                  borderRadius: index % 2 == 0 ? _radius : _radius / 2,
                  borderGradientColors: _selectedColors,
                  strokeWidth: _strokeWidth,
                  gapSize: _gapSize,
                  username: _showUserNames
                      ? Text(
                          userNames[index],
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 11,
                          ),
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _controls() {
    return StatefulBuilder(builder: (context, setModalState) {
      void set(VoidCallback callback) {
        setModalState(callback);
        setState(callback);
      }

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Show user names"),
                  const SizedBox(width: 5),
                  Checkbox(
                    checkColor: Colors.white,
                    value: _showUserNames,
                    onChanged: (bool? value) {
                      set(() {
                        _showUserNames = !_showUserNames;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          _buildSlider(
            title: "Width: ",
            value: _width,
            min: 35,
            onChanged: (double value) {
              set(() {
                _width = value;
              });
            },
          ),
          _buildSlider(
            title: "Height: ",
            value: _height,
            min: 35,
            onChanged: (double value) {
              set(() {
                _height = value;
              });
            },
          ),
          _buildSlider(
            title: "Radius: ",
            value: _radius,
            min: 0,
            onChanged: (double value) {
              set(() {
                _radius = value;
              });
            },
          ),
          _buildSlider(
            title: "Gap size: ",
            value: _gapSize * 10,
            min: 0,
            onChanged: (double value) {
              set(() {
                _gapSize = value / 10;
              });
            },
          ),
          _buildSlider(
            title: "Stroke width: ",
            value: _strokeWidth * 10,
            min: 0,
            onChanged: (double value) {
              set(() {
                _strokeWidth = value / 10;
              });
            },
          ),
          _buildSlider(
            title: "Border gradient: ",
            value: _lerp,
            min: 0,
            onChanged: (double value) {
              final newColors = <Color>[];

              for (int i = 0; i < _defaultBorderColors.length; i++) {
                var rnd = math.Random();
                var r = rnd.nextInt(16) * 16;
                var g = rnd.nextInt(16) * 16;
                var b = rnd.nextInt(16) * 16;

                newColors.add(Color.fromARGB(255, r, g, b));
              }

              set(() {
                _selectedColors = newColors;
                _lerp = value;
              });
            },
          ),
        ],
      );
    });
  }

  Widget _buildSlider({
    required String title,
    required double value,
    required ValueChanged<double> onChanged,
    required double min,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Text(title),
          const SizedBox(width: 5),
          Expanded(
            child: Slider(
              value: value,
              max: 200,
              min: min,
              label: value.round().toString(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

/// Creates a dumb textfield as a placeholder.
class MessageBox extends StatelessWidget {
  const MessageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      margin: const EdgeInsets.only(bottom: 25),
      color: Colors.transparent,
      child: TextField(
        cursorRadius: const Radius.circular(20.0),
        decoration: InputDecoration(
          fillColor: Colors.white10,
          filled: true,
          suffixIcon: Icon(
            Icons.send_outlined,
            size: 20,
            color: Colors.grey.shade300,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          hintText: 'Message',
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Colors.white60,
          ),
        ),
      ),
    );
  }
}

class CustomAnimatedTray extends AnimatedTray {
  const CustomAnimatedTray({
    required this.profilePic,
    super.key,
  });

  final String profilePic;

  @override
  AnimatedTrayState<AnimatedTray> createState() => CustomAnimatedTrayState();
}

class CustomAnimatedTrayState extends AnimatedTrayState<CustomAnimatedTray>
    with TickerProviderStateMixin {
  // Create a controller for the tray animation and define properties.
  // Use curves, tweens etc. if you want.
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
    reverseDuration: const Duration(milliseconds: 1000),
    value: 1,
    lowerBound: 1,
    upperBound: 1.1,
  );

  // This function called every time the tray is tapped.
  //
  // When you return a class that extends AnimatedTray from tray builder,
  // AdvStory knows that it should prepare story and its content before it is
  // shown. On animated tray tap, AdvStory calls this function and starts
  // preparing the story, builds story, fetchs media file from internet and
  // initializes VideoController if content is a video.
  //
  // Start your animation in this function.
  @override
  void startAnimation() {
    _controller.repeat(reverse: true);
  }

  // When story built and it's content ready to be shown, AdvStory calls this
  // function and opens story view.
  //
  // Stop your animation in this function.
  @override
  void stopAnimation() {
    _controller.reset();
    _controller.stop();
  }

  @override
  void dispose() {
    // Dispose controller as usual.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _controller,
        child: SizedBox(
          width: 85,
          height: 85,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                widget.profilePic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// [AdvStoryTray]
class CustomNonAnimatedTray extends StatelessWidget {
  /// Creates a custom tray to use in story list.
  const CustomNonAnimatedTray({
    required this.profilePic,
    super.key,
  });

  final String profilePic;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 85,
      height: 85,
      child: Center(
        child: ClipPath(
          clipper: TrayClipper(6),
          child: Image.network(
            profilePic,
          ),
        ),
      ),
    );
  }
}

/// Clips a star shape.
class TrayClipper extends CustomClipper<Path> {
  /// Creates a clipper instance
  TrayClipper(this.points);

  /// The number of points of the star
  final int points;

  // Degrees to radians conversion
  double _degreeToRadian(double deg) => deg * (math.pi / 180.0);

  @override
  Path getClip(Size size) {
    Path path = Path();
    double max = 2 * math.pi;

    double width = size.width;
    double halfWidth = width / 2;

    double wingRadius = halfWidth;
    double radius = halfWidth / 2;

    double degreesPerStep = _degreeToRadian(360 / points);
    double halfDegreesPerStep = degreesPerStep / 2;

    path.moveTo(width, halfWidth);

    for (double step = 0; step < max; step += degreesPerStep) {
      path.lineTo(halfWidth + wingRadius * math.cos(step),
          halfWidth + wingRadius * math.sin(step));
      path.lineTo(halfWidth + radius * math.cos(step + halfDegreesPerStep),
          halfWidth + radius * math.sin(step + halfDegreesPerStep));
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    TrayClipper starClipper = oldClipper as TrayClipper;
    return points != starClipper.points;
  }
}
//////////////////////////////////////////////////////////////////////////////////

class StoryTypeShowcase extends StatelessWidget {
  const StoryTypeShowcase({super.key});

  Widget _text(String value) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 8, top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.black38,
            width: 4,
          ),
        ),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 13,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Column(
                children: [
                  _text("image_story_content.dart"),
                  const Expanded(child: ImageStoryContent()),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  _text("video_story_content.dart"),
                  const Expanded(child: VideoStoryContent()),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  _text(
                    "simple_custom_story_content.dart",
                  ),
                  const Expanded(child: SimpleCustomStoryContent()),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  _text(
                    "advanced_custom_story_content.dart",
                  ),
                  const Expanded(child: AdvancedCustomStoryContent()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageStoryContent extends StatelessWidget {
  /// Creates [AdvStory] view for image content example.
  const ImageStoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AdvStory(
      storyCount: 5,
      storyBuilder: (storyIndex) {
        return Story(
          contentCount: 5,
          contentBuilder: (contentIndex) {
            return ImageContent(
              // Story image url
              url: imageUrls[contentIndex % imageUrls.length],
              // Story duration, default is 10 seconds
              duration: const Duration(seconds: 10),
              // Story content cache key, default is null
              cacheKey: imageUrls[contentIndex % imageUrls.length],
              // Story content request headers, default is null
              requestHeaders: const {
                "Authorization": "Bearer 12345",
              },
              // Story content header, default is null
              header: const Text(
                "Header",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
              // Story content footer, default is null
              footer: const Text(
                "Footer",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
              // Story content timeout, default is null
              timeout: const Duration(seconds: 5),
              // Error view builder.
              errorBuilder: () {
                /// You can create a timer here to skip next content using
                /// AdvStoryController.
                return const Center(
                  child: Text("An error occured!"),
                );
              },
            );
          },
        );
      },
      trayBuilder: (storyIndex) {
        return Center(
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent.withOpacity(.85),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Image Content\n$storyIndex",
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

/// Example of video content.
class VideoStoryContent extends StatelessWidget {
  /// Creates [AdvStory] view for video content example.
  const VideoStoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AdvStory(
      storyCount: 5,
      // This example creates only video contents, video sizes are large.
      // Disable story preload.
      preloadStory: false,
      storyBuilder: (storyIndex) {
        return Story(
          contentCount: 2,
          contentBuilder: (contentIndex) {
            return VideoContent(
              // Story video url
              url: videoUrls[contentIndex % videoUrls.length],
              // Story content cache key, default is null
              cacheKey: videoUrls[contentIndex % videoUrls.length],
              // Story content request headers, default is null
              requestHeaders: const {
                "Authorization": "Bearer 12345",
              },
              // Story content header, default is null
              header: const Text(
                "Header",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
              // Story content footer, default is null
              footer: const Text(
                "Footer",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
              // Story content timeout, default is null
              timeout: const Duration(seconds: 10),
              // Error view builder.
              errorBuilder: () {
                /// You can create a timer here to skip next content using
                /// AdvStoryController.
                return const Center(
                  child: Text("An error occured!"),
                );
              },
            );
          },
        );
      },
      trayBuilder: (storyIndex) {
        return Center(
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent.withOpacity(.85),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Video Content\n$storyIndex",
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

/// Example of simple custom content.
class SimpleCustomStoryContent extends StatelessWidget {
  /// Creates [AdvStory] view for simple custom content example.
  const SimpleCustomStoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AdvStory(
      storyCount: 5,
      storyBuilder: (storyIndex) {
        return Story(
          contentCount: 4,
          header: const Text(
            "Header",
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
          footer: const Text(
            "Footer",
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
          contentBuilder: (contentIndex) {
            return SimpleCustomContent(
              // Use story header for every 3rd content.
              useStoryHeader: contentIndex % 3 == 0,
              // Use story footer for every 2nd content.
              useStoryFooter: contentIndex % 2 == 0,
              // Start 10 second countdown for content skipping.
              duration: const Duration(seconds: 10),
              builder: (context) {
                return Center(
                  child: SizedBox.expand(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent.withOpacity(.85),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text("My story content for $contentIndex"),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      trayBuilder: (storyIndex) {
        return Center(
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.greenAccent.withOpacity(.85),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Text(
              "Simple Content\n$storyIndex",
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

/// Example of advanced custom story contents.
class AdvancedCustomStoryContent extends StatelessWidget {
  /// Creates [AdvStory] view for advanced custom content example.
  const AdvancedCustomStoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AdvStory(
      storyCount: 5,
      storyBuilder: (storyIndex) {
        return Story(
          contentCount: 3,
          contentBuilder: (contentIndex) {
            return MyCustomContent(contentIndex: contentIndex);
          },
        );
      },
      trayBuilder: (storyIndex) {
        return Center(
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amberAccent.withOpacity(.85),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              "Advanced Content\n$storyIndex",
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

// Story logic must be controlled by developer in this type of content.
class MyCustomContent extends StoryContent {
  const MyCustomContent({
    required this.contentIndex,
    super.key,
  });

  final int contentIndex;

  @override
  StoryContentState<MyCustomContent> createState() =>
      MyCustomStoryContentState();
}

/// See [StoryContent] for more information.
class MyCustomStoryContentState extends StoryContentState<MyCustomContent> {
  File? _myImage;

  /// Do your async stuff and to notify [AdvStory] by calling [markReady]
  /// when content is ready to be displayed.
  Future<void> doMyAsyncStuff() async {
    /// Fetch and cache your file.
    final myImageFile = await loadFile(
      url: imageUrls[position.content % imageUrls.length],
    );

    setState(() {
      _myImage = myImageFile;
    });

    // Send story duration parameter to the markReady. AdvStory will use this
    // duration to start skip countdown.
    markReady(duration: const Duration(seconds: 15));
  }

  /// If you wonder why using initContent is better, see implementation of
  /// this method in [StoryContent].
  @override
  void initContent() {
    doMyAsyncStuff();
    // Set a time limit to load this content.
    setTimeout(const Duration(seconds: 10));
  }

  @override
  void onTimeout() {
    // Show a message to user if content couldn't be displayed in desired time.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Content couldn't be displayed in time."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // loadingScreen is your defined loading screen or AdvStory default one.
    // Check if this content should show a loading screen and return value
    // accordingly.
    if (_myImage == null) {
      return shouldShowLoading ? loadingScreen : const SizedBox();
    }

    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(_myImage!),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.deepOrange.withOpacity(.6),
              child: Text(
                "My story content for ${position.toString()}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FooterHeaderShowcase extends StatelessWidget {
  const FooterHeaderShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCustomHeaderFooterExample(context),
        ],
      ),
    );
  }

  Widget _buildCustomHeaderFooterExample(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 5,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "This view shows specific footer and header for every two"
                      " content. Other contents use story header and footer.",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: CustomHeaderFooter(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomHeaderFooter extends StatelessWidget {
  const CustomHeaderFooter({super.key});

  /// Provides custom header and footer to every 2 story. Others use the
  /// the default header and footer.
  Widget? _getStoryComponent(int index, String type, BuildContext context) {
    return index % 2 == 0
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .1,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent.withOpacity(.85),
              borderRadius: BorderRadius.vertical(
                top: type == "footer" ? const Radius.circular(20) : Radius.zero,
                bottom:
                    type == "header" ? const Radius.circular(20) : Radius.zero,
              ),
            ),
            child: Text("Custom $type for story $index"),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return AdvStory(
      storyCount: userNames.length,
      storyBuilder: (storyIndex) {
        return Story(
          contentCount: 3,
          // Creates default header for story.
          header: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .1,
            color: Colors.green.withOpacity(.5),
            alignment: Alignment.center,
            child: const Text("Default story header"),
          ),
          // Creates default footer for story.
          footer: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .1,
            color: Colors.green.withOpacity(.5),
            alignment: Alignment.center,
            child: const Text("Default story footer"),
          ),
          contentBuilder: (contentIndex) {
            final header = _getStoryComponent(contentIndex, "header", context);
            final footer = _getStoryComponent(contentIndex, "footer", context);

            return ImageContent(
              url: imageUrls[contentIndex],
              header: header,
              footer: footer,
            );
          },
        );
      },
      trayBuilder: (index) {
        return AdvStoryTray(
          url: profilePics[index],
          username: Text(
            userNames[index],
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 11,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          size: const Size(80, 80),
        );
      },
    );
  }
}

class ControllerUsage extends StatefulWidget {
  const ControllerUsage({super.key});

  @override
  State<ControllerUsage> createState() => _ControllerUsageState();
}

class _ControllerUsageState extends State<ControllerUsage> {
  final AdvStoryController _controller = AdvStoryController();

  // This is created to display snackbars about events. No need to
  // use any key for AdvStory.
  final _key = GlobalKey();

  /// Shows snackbars about events.
  void _showSnackbar(StoryEvent event, StoryPosition position) {
    void show(BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.none,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 50,
              right: 20,
              left: 20,
            ),
            content: Text(
              "Event: ${event.name}, story: ${position.story}, "
              "content: ${position.content}",
            ),
          ),
        );
      });
    }

    if (event == StoryEvent.close) {
      show(context);
    } else if (_key.currentState?.context != null &&
        _key.currentState?.mounted == true) {
      show(_key.currentState!.context);
    }
  }

  Widget _buildActionFooter() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 50),
      color: Colors.grey[200],
      child: Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        children: [
          IconButton(
            onPressed: _controller.toPreviousStory,
            icon: const Icon(Icons.undo),
          ),
          IconButton(
            onPressed: _controller.toPreviousContent,
            icon: const Icon(Icons.skip_previous),
          ),
          IconButton(
            onPressed: _controller.pause,
            icon: const Icon(Icons.pause),
          ),
          IconButton(
            onPressed: _controller.resume,
            icon: const Icon(Icons.play_arrow),
          ),
          IconButton(
            onPressed: _controller.toNextContent,
            icon: const Icon(Icons.skip_next),
          ),
          IconButton(
            onPressed: _controller.toNextStory,
            icon: const Icon(Icons.redo),
          ),
          IconButton(
            onPressed: _controller.disableGestures,
            icon: const Icon(Icons.do_not_touch_rounded),
          ),
          IconButton(
            onPressed: _controller.enableGestures,
            icon: const Icon(Icons.touch_app),
          ),
          IconButton(
            onPressed: _controller.hideComponents,
            icon: const Icon(Icons.visibility_off),
          ),
          IconButton(
            onPressed: _controller.showComponents,
            icon: const Icon(Icons.visibility),
          ),
          IconButton(
            onPressed: () => _controller.jumpTo(story: 0, content: 0),
            icon: const Icon(Icons.navigation),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptions() {
    Widget desc(IconData icon, String desc) {
      return Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(width: 5),
            Text(desc),
          ],
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 6,
      children: [
        desc(Icons.undo, "To previous story"),
        desc(Icons.redo, "To next story"),
        desc(Icons.skip_previous, "To previous content"),
        desc(Icons.skip_next, "To next content"),
        desc(Icons.pause, "Pause"),
        desc(Icons.play_arrow, "Resume"),
        desc(Icons.do_not_touch_rounded, "Disable gestures"),
        desc(Icons.touch_app, "Enable gestures"),
        desc(Icons.visibility_off, "Hide components"),
        desc(Icons.visibility, "Show components"),
        desc(Icons.navigation, "Jump to position"),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_showSnackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Controller Usage Example',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                child: AdvStory(
                  key: _key,
                  controller: _controller,
                  storyCount: userNames.length,
                  storyBuilder: (index) => Story(
                    footer: _buildActionFooter(),
                    contentCount: 3,
                    contentBuilder: (contentIndex) {
                      return SimpleCustomContent(
                        useStoryFooter: true,
                        builder: (context) {
                          return Container(
                            color: Colors.deepOrangeAccent,
                            child: Center(
                              child: Text(
                                "Content $contentIndex",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  trayBuilder: (index) => AdvStoryTray(
                    url: profilePics[index],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 15),
                child: Text(
                  "Icon Descriptions:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(child: _buildDescriptions()),
              const Expanded(child: Interceptor()),
            ],
          ),
        ),
      ),
    );
  }
}

class Interceptor extends StatefulWidget {
  const Interceptor({super.key});

  @override
  State<Interceptor> createState() => _InterceptorState();
}

class _InterceptorState extends State<Interceptor> {
  final _controller = AdvStoryController();

  @override
  void initState() {
    _controller.setTrayTapInterceptor((trayIndex) {
      if (trayIndex == 0) {
        return StoryPosition(2, 2);
      }

      return null;
    });

    _controller.setInterceptor((event) {
      if (event == StoryEvent.nextContent) {
        return () => print(
              'StoryEvent.nextContent blocked and printed this log instead.',
            );
      }

      return null;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Interceptor Example',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'This example,\n'
                '- Blocks next content event and prints a log message '
                'instead.\n'
                '- Opens story view at story 2 and content 2 when tray 0 '
                'tapped.',
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: AdvStory(
            controller: _controller,
            storyCount: profilePics.length,
            storyBuilder: (index) => Story(
              contentCount: 3,
              contentBuilder: (contentIndex) => SimpleCustomContent(
                builder: (context) {
                  return Center(
                    child: SizedBox.expand(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent.withOpacity(.85),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text("Story $index, Content: $contentIndex"),
                      ),
                    ),
                  );
                },
              ),
            ),
            trayBuilder: (index) => AdvStoryTray(url: profilePics[index]),
          ),
        ),
      ],
    );
  }
}

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final _controller = AdvStoryPlayerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'AdvStory.player builds a story view without a tray list.'
                        ' Custom open animation, size, position and anything'
                        ' desired can be applied to the story view. \n',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Player Example'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: const Text('Open'),
                          onPressed: () =>
                              _controller.open(StoryPosition(2, 2)),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          child: const Text('Close'),
                          onPressed: () => _controller.close(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  height: MediaQuery.of(context).size.height * .5,
                  child: AdvStory.player(
                    storyCount: profilePics.length,
                    controller: _controller,
                    style: const AdvStoryStyle(
                      indicatorStyle: IndicatorStyle(
                        padding: EdgeInsets.all(8),
                      ),
                    ),
                    storyBuilder: (storyIndex) => Story(
                      contentCount: 3,
                      contentBuilder: (contentIndex) {
                        return SimpleCustomContent(
                          builder: (context) {
                            return Container(
                              color: Colors.blueAccent,
                              alignment: Alignment.center,
                              child: const Text('😎'),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
