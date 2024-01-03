import 'package:flutter/material.dart';

class CommonBackground extends StatelessWidget {
  final Widget child; // Content of the screen
  const CommonBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/common_background.png',
            fit: BoxFit.cover,
          ),
        ),
        // Screen Content
        Positioned.fill(child: child),
      ],
    );
  }
}
