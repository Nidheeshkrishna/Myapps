
import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double screenwidth = 0;
  static double screenheight = 0;
  static double textMultiplier = 0;
  static double imageSizeMultiplier = 0;
  static double heightMultiplier = 0;
  static double widthMultiplier = 0;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  static double blockSizeHorizontal;

  static double blockSizeVertical;
  static double _safeAreaHorizontal;
			static double _safeAreaVertical;
			static double safeBlockHorizontal;
			static double safeBlockVertical;

  void init(BoxConstraints constraints, Orientation orientation,BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenHeight = constraints.maxHeight;
      _screenWidth = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;
    blockSizeHorizontal = screenwidth / 100;
    blockSizeVertical = screenheight / 100;
    screenwidth = _screenWidth;
    screenheight = _screenHeight;
    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

_safeAreaHorizontal = _mediaQueryData.padding.left + 
					_mediaQueryData.padding.right;
				_safeAreaVertical = _mediaQueryData.padding.top +
					_mediaQueryData.padding.bottom;
				safeBlockHorizontal = (screenwidth -
					_safeAreaHorizontal) / 100;
				safeBlockVertical = (screenheight -
					_safeAreaVertical) / 100;

    
  }
}
