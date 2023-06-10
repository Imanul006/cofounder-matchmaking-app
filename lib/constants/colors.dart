import 'package:flutter/material.dart';

class AppColor {
  // Primary Colors
  static const Color primaryColor = Color(0xFFEB6047);
  static const Color backgroundColor = Color(0xFFE5E5E5);
  static const Color secondaryColor = Color(0xFFFD0E42);

  //additional colors
  static const Color navBarColor = Colors.white;
  static const Color buttonColor = primaryColor;
  static Color inputFieldBackground = Colors.grey.shade200;
  static Color inputFieldBlueishBackground = const Color(0XFFEDF5F4);
  static const Color errorColor = Colors.red;
  static const Color lightBlueBkg = Color.fromARGB(50, 65, 132, 243);

  static const Color primaryText = Color.fromARGB(255, 0, 0, 0);
  static const Color subtitleText = Color.fromARGB(120, 0, 0, 0);
  static const Color blurText = Color.fromARGB(32, 0, 0, 0);

  static const Color buttonText = Color.fromARGB(255, 255, 255, 255);
  

  static const Color black = Color(0xff20262C);


  static const Color iconColor = Color(0xffa8a09b);

  //gradients
  static const LinearGradient discoverHeaderGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryColor, secondaryColor]);
  
}
