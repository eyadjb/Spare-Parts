// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class ShadowedBorder extends StatelessWidget {
  final Widget child;
  final BorderSide borderSide;
  final double spreadRadius;
  final double blurRadius;
  final Color shadowColor;

  const ShadowedBorder({
    Key? key,
    required this.child,
    this.borderSide = BorderSide.none,
    this.spreadRadius = 2.0,
    this.blurRadius = 3.0,
    this.shadowColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          top: -spreadRadius -
              blurRadius, // Cut off the shadow above the control
          child: ClipPath(
            clipper: _BorderClipper(borderSide.width),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: borderSide,
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.8),
                    spreadRadius: spreadRadius,
                    blurRadius: blurRadius,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BorderClipper extends CustomClipper<Path> {
  final double borderWidth;

  _BorderClipper(this.borderWidth);

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, borderWidth)
      ..lineTo(size.width, borderWidth)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(_BorderClipper oldClipper) => false;
}
