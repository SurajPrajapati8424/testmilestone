/**
 * ISSUE : 
E/flutter (10659): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Unsupported operation: Cannot modify an unmodifiable list
E/flutter (10659): #0      UnmodifiableListMixin.shuffle (dart:_internal/list.dart:154:5)
E/flutter (10659): #1      _AnimatedGradientState.build.<anonymous closure>.<anonymous closure> (package:animated_gradient/src/animated_gradient.dart:73:43)
E/flutter (10659): #2      State.setState (package:flutter/src/widgets/framework.dart:1203:30)

 */
import 'package:animated_gradient/animated_gradient.dart';
import 'package:flutter/material.dart';

class AnimatedGradientExample extends StatelessWidget {
  const AnimatedGradientExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: AnimatedGradient(
            // colors: [Colors.blue, Colors.red, Colors.green, Colors.purple],
            child: Center(
              child: Text(
                'DONE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
