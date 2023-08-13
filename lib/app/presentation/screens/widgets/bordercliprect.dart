import 'package:flutter/material.dart';

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.2; // desirable value for corners side

    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..lineTo(0, 0)
      ..lineTo(0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..lineTo(0, sh)
      ..lineTo(cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..lineTo(sw, sh)
      ..lineTo(sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..lineTo(sw, 0)
      ..lineTo(sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}

class BorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.2;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..lineTo(0, 0)
      ..lineTo(0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..lineTo(0, sh)
      ..lineTo(cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..lineTo(sw, sh)
      ..lineTo(sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..lineTo(sw, 0)
      ..lineTo(sw - cornerSide, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
