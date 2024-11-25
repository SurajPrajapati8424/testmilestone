import 'package:flutter/material.dart';
import 'package:tiny_avatar/tiny_avatar.dart';

class TinyAvatarExample extends StatelessWidget {
  const TinyAvatarExample({super.key});

  @override
  Widget build(BuildContext context) {
    String value = 'aq quiz';
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Change colour scheme
            TinyAvatar(
              baseString: value,
              dimension: 150,
              colourScheme: TinyAvatarColourScheme.heated,
            ),
            // Circular option
            TinyAvatar(
              baseString: value,
              dimension: 150,
              circular: true,
            ),
            // Custom border radius
            TinyAvatar(
              baseString: value,
              dimension: 150,
              colourScheme: TinyAvatarColourScheme.seascape,
              borderRadius: 30,
            ),
            // Custom colour scheme
            TinyAvatar(
              baseString: value,
              dimension: 150,
              colourScheme: TinyAvatarColourScheme.summer,
              customColours: const [
                Colors.white,
                Colors.lime,
                Colors.cyanAccent,
              ],
            )
          ],
        ),
      ),
    );
  }
}
