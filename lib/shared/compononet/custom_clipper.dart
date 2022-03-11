import 'package:flutter/material.dart';

class FullTicketClipper extends CustomClipper<Path> {
  final double radius;
  final double top;
  FullTicketClipper(
    this.radius,
    this.top,
  );

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, top - radius);
    path.conicTo(
      radius,
      top - radius,
      radius,
      top,
      2.0,
    );
    path.conicTo(
      radius,
      top + radius,
      0,
      top + radius,
      1.0,
    );

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width, top + radius);
    path.conicTo(
      size.width - radius,
      top + radius,
      size.width - radius,
      top,
      2.0,
    );
    path.conicTo(
      size.width - radius,
      top - radius,
      size.width,
      top - radius,
      1.0,
    );

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
