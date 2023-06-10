import 'package:flutter/material.dart';

class AppbarClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height);
    path.quadraticBezierTo(width / 20, height - 55, width / 5, height - 55);
    path.lineTo(width, height - 55);
    // path.lineTo(width * (4/5), height - 55);
    // path.quadraticBezierTo(width * (19/20), height - 55, width, height);
    path.lineTo(width, 0);
    path.close();
    
    return path;
 }
  @override
    bool shouldReclip(CustomClipper oldClipper) {
    return true;
 }
}