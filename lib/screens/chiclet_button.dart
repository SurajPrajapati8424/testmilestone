import 'package:flutter/material.dart';
import 'package:chiclet/chiclet.dart';
import 'package:smooth_corner/smooth_corner.dart';

class ChicletExample extends StatelessWidget {
  const ChicletExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChicletOutlinedAnimatedButton(
                      onPressed: () {},
                      height: 64,
                      borderRadius: 0,
                      child: const Icon(Icons.keyboard_return)),
                  ChicletAnimatedButton(
                      onPressed: () {},
                      height: 64,
                      borderRadius: 0,
                      child: const Icon(Icons.keyboard_return)),
                  ChicletAnimatedButton(
                      onPressed: () {},
                      height: 64,
                      width: 140,
                      borderRadius: 0,
                      child: const Icon(Icons.keyboard_return)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChicletOutlinedAnimatedButton(
                      onPressed: () {},
                      height: 64,
                      child: const Icon(Icons.keyboard_return_rounded)),
                  ChicletAnimatedButton(
                      onPressed: () {},
                      height: 64,
                      child: const Icon(Icons.keyboard_return_rounded)),
                  ChicletAnimatedButton(
                      onPressed: () {},
                      height: 64,
                      width: 140,
                      child: const Icon(Icons.keyboard_return_rounded)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChicletOutlinedAnimatedButton(
                      onPressed: () {},
                      height: 64,
                      buttonType: ChicletButtonTypes.circle,
                      child: const Icon(Icons.keyboard_return_rounded)),
                  ChicletAnimatedButton(
                      onPressed: () {},
                      height: 64,
                      buttonType: ChicletButtonTypes.circle,
                      child: const Icon(Icons.keyboard_return_rounded)),
                  ChicletAnimatedButton(
                      onPressed: () {},
                      width: 140,
                      height: 64,
                      borderRadius: 64,
                      buttonType: ChicletButtonTypes.roundedRectangle,
                      child: const Icon(Icons.keyboard_return_rounded)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChicletOutlinedAnimatedButton(
                      onPressed: () {},
                      height: 50,
                      width: 65,
                      buttonType: ChicletButtonTypes.oval,
                      child: const Icon(Icons.keyboard_return_rounded)),
                  ChicletAnimatedButton(
                      onPressed: () {},
                      height: 50,
                      width: 65,
                      buttonType: ChicletButtonTypes.oval,
                      child: const Icon(Icons.keyboard_return_rounded)),
                  ChicletAnimatedButton(
                      onPressed: () {},
                      height: 50,
                      width: 140,
                      buttonType: ChicletButtonTypes.oval,
                      child: const Icon(Icons.keyboard_return_rounded)),
                ],
              ),
              ChicletSegmentedButton(
                height: 66,
                buttonHeight: 6,
                padding: EdgeInsets.zero,
                children: [
                  ChicletButtonSegment(
                    onPressed: () {},
                    child: const Icon(Icons.shuffle_rounded),
                  ),
                  ChicletButtonSegment(
                    onPressed: () {},
                    child: const Icon(Icons.skip_previous_rounded),
                  ),
                  ChicletButtonSegment(
                    onPressed: () {},
                    child: const Icon(Icons.play_arrow),
                  ),
                  ChicletButtonSegment(
                    onPressed: () {},
                    child: const Icon(Icons.skip_next_rounded),
                  ),
                  ChicletButtonSegment(
                    onPressed: () {},
                    child: const Icon(Icons.repeat_rounded),
                  ),
                ],
              ),
              ChicletSegmentedButton(
                width: 330,
                height: 66,
                buttonHeight: 6,
                children: [
                  Expanded(
                    child: ChicletButtonSegment(
                      onPressed: () {},
                      child: const Text("Submit"),
                    ),
                  ),
                  ChicletButtonSegment(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: const Icon(Icons.edit_rounded),
                  ),
                ],
              ),
              // test with smooth_corner
              SmoothClipRRect(
                smoothness: 1.0,
                borderRadius: BorderRadius.circular(20),
                child: ChicletSegmentedButton(
                  width: 330,
                  height: 66,
                  buttonHeight: 6,
                  children: [
                    Expanded(
                      child: ChicletButtonSegment(
                        onPressed: () {},
                        child: const Text("Submit"),
                        borderRadius: 20,
                      ),
                    ),
                    ChicletButtonSegment(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      child: const Icon(Icons.edit_rounded),
                    ),
                  ],
                ),
              ),
              const ChicletButton(
                child: Text('test'),
                buttonColor: Color(0xFF00C85C),
                isPressed: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
