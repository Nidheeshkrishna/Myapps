import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  ColorProvider();
  bool isPressed = true;

  Color color = Colors.black;

  changeColor() {
    if (isPressed == true) {
      color = Colors.green;
      isPressed = false;
    } else {
      color = Colors.black;
      isPressed = true;
    }
    notifyListeners();
    return isPressed;
  }
}
