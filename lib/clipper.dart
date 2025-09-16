import 'package:flutter/material.dart';

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 40) // Start from the top-left corner
      ..lineTo(size.width, size.height) // Line to the bottom-right corner
      ..lineTo(size.width, 0); // Line to the top-right corner

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
