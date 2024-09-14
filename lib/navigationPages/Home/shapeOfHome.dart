// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ShapeOfHome extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    final fireCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        fireCurve.dx, fireCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondFireCurve = Offset(0, size.height - 20);
    final secondLastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondFireCurve.dx, secondFireCurve.dy,
        secondLastCurve.dx, secondLastCurve.dy);

    final thisFireCurve = Offset(size.width, size.height - 20);
    final thisLastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(
        thisFireCurve.dx, thisFireCurve.dy, thisLastCurve.dx, thisLastCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
