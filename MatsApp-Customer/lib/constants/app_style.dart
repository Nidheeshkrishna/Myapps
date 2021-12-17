import 'package:flutter/material.dart';
import 'package:matsapp/utilities/size_config.dart';

import 'app_colors.dart';

const Color kAccentColor = AppColors.kAccentColor;
const Color kPrimaryColor = AppColors.kPrimaryColor;
const Color kAccentLight = const Color(0xFF7e7e7e);
const Color kHintColor = const Color(0xFFAAAAAA);
const Color kDividerColor = const Color(0xFFBDBDBD);
const Color kBorderSideColor = const Color(0x66D1D1D1);
Color kTextBaseColor = AppColors.kAccentColor;
Color kTitleBaseColor = kTextBaseColor;
const Color kBackgroundBaseColor = Colors.white;
const Color kAppBarBackgroundColor = Colors.white;

const double kBaseScreenHeight = 896.0;
const double kBaseScreenWidth = 414.0;

const double kButtonHeight = 60.0;
const double kButtonMinWidth = 200.0;

const BorderRadius kBorderRadius = const BorderRadius.all(Radius.circular(4.0));

class AppTheme {
  ThemeData getAppTheme() {
    return ThemeData(

        //fontFamily: 'matsapp_font',
        brightness: Brightness.light,
        primaryColor: AppColors.kPrimaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.kAccentColor, // Your accent color
        ),
        primarySwatch: AppColors.primarySwatch,
        backgroundColor: AppColors.kBackColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
            
            titleTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.blueGrey,
              letterSpacing: 0.25,
              fontWeight: FontWeight.w600,
            ),
            titleSpacing: 0.3));
  }
}

class AppTextStyle extends TextStyle {
  AppTextStyle.appFont({
    double fontSize,
    FontWeight fontWeight,
    Color color,
  }) : super(
          inherit: false,
          color: color ?? kTextBaseColor,
          fontSize: fontSize,
          fontWeight: fontWeight ?? AppTextStyle.regular,
          // wordSpacing: -2.5,
          // letterSpacing: -0.5,
          textBaseline: TextBaseline.alphabetic,
        );
  AppTextStyle.titleFont1({
    double fontSize,
    FontWeight fontWeight,
    Color color,
  }) : super(
          inherit: false,
          color: color ?? kPrimaryColor,
          fontSize: 20,
          fontWeight: fontWeight ?? AppTextStyle.semibold,
          textBaseline: TextBaseline.alphabetic,
        );
  AppTextStyle.titleFont({
    double fontSize,
    FontWeight fontWeight,
    Color color,
  }) : super(
          inherit: false,
          color: color ?? kPrimaryColor,
          fontSize: 20,
          fontWeight: fontWeight ?? AppTextStyle.semibold,
          textBaseline: TextBaseline.alphabetic,
        );

  AppTextStyle.homeCatsFont({
    double fontSize,
    FontWeight fontWeight,
    Color color,
  }) : super(
          inherit: false,
          color: color ?? Colors.black,
          fontSize: fontSize ?? SizeConfig.widthMultiplier * 5.2,
          fontWeight: fontWeight ?? AppTextStyle.semibold,
          textBaseline: TextBaseline.alphabetic,
        );

  AppTextStyle.homeViewAllFont({
    double fontSize,
    FontWeight fontWeight,
    Color color,
  }) : super(
          inherit: false,
          color: color ?? AppColors.kSecondaryDarkColor,
          fontSize: 14,
          fontWeight: fontWeight ?? FontWeight.w500,
          textBaseline: TextBaseline.alphabetic,
        );
  AppTextStyle.homeViewAllWhite({
    double fontSize,
    FontWeight fontWeight,
    Color color,
  }) : super(
          inherit: false,
          color: color ?? Colors.white,
          fontSize: 14,
          fontWeight: fontWeight ?? FontWeight.w500,
          textBaseline: TextBaseline.alphabetic,
        );

  AppTextStyle.profileFont({
    double fontSize,
    FontWeight fontWeight,
    Color color,
  }) : super(
          inherit: false,
          color: color ?? AppColors.kSecondaryDarkColor,
          fontSize: SizeConfig.safeBlockHorizontal * 4,
          fontWeight: fontWeight ?? FontWeight.bold,
          textBaseline: TextBaseline.alphabetic,
        );

  AppTextStyle.commonFont({
    double fontSize,
    FontWeight fontWeight,
    Color color,
  }) : super(
          inherit: false,
          color: color ?? AppColors.kSecondaryDarkColor,
          fontSize: SizeConfig.safeBlockHorizontal * 3,
          fontWeight: fontWeight ?? FontWeight.normal,
          textBaseline: TextBaseline.alphabetic,
        );

  AppTextStyle.productNameFont({
    double fontSize,
    FontWeight fontWeight,
    Color color,
  }) : super(
          inherit: false,
          color: color ?? Colors.black,
          fontSize: SizeConfig.safeBlockHorizontal * 3.5,
          fontWeight: fontWeight ?? FontWeight.normal,
          textBaseline: TextBaseline.alphabetic,
        );

  AppTextStyle.productMRPFont(
      {double fontSize,
      FontWeight fontWeight,
      Color color,
      TextDecoration decoration})
      : super(
            inherit: false,
            color: color ?? AppColors.kSecondaryDarkColor,
            fontSize: SizeConfig.safeBlockVertical * 2.1,
            fontWeight: fontWeight ?? FontWeight.normal,
            textBaseline: TextBaseline.alphabetic,
            decoration: decoration ?? TextDecoration.none);
  AppTextStyle.productPriceFont({
    double fontSize,
    FontWeight fontWeight,
    Color color,
  }) : super(
          inherit: false,
          color: color ?? AppColors.mHomeGreen,
          fontSize: SizeConfig.safeBlockVertical * 2,
          fontWeight: fontWeight ?? FontWeight.bold,
          textBaseline: TextBaseline.alphabetic,
        );

  AppTextStyle.homeTitlesfont({
    double fontSize,
    FontWeight fontWeight,
    Color color,
  }) : super(
          inherit: false,
          color: color ?? Colors.black,
          fontSize: SizeConfig.widthMultiplier * 5.1,
          fontWeight: fontWeight ?? AppTextStyle.semibold,
          textBaseline: TextBaseline.alphabetic,
        );
  AppTextStyle.homeWhitefont({
    double fontSize,
    FontWeight fontWeight,
    Color color,
  }) : super(
          inherit: false,
          color: color ?? Colors.white,
          fontSize: SizeConfig.safeBlockHorizontal * 5.1,
          fontWeight: fontWeight ?? AppTextStyle.semibold,
          textBaseline: TextBaseline.alphabetic,
        );
  AppTextStyle.titleFont2({
    double fontSize,
    double letterspacing,
    FontWeight fontWeight,
    Color color,
  }) : super(
          inherit: false,
          color: color ?? kAccentLight,
          fontSize: 16,
          letterSpacing: 1,
          fontWeight: fontWeight ?? FontWeight.w500,
          textBaseline: TextBaseline.alphabetic,
        );

  static const FontWeight light = FontWeight.w200;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w600;
  static const FontWeight semibold = FontWeight.w700;
  static const FontWeight bold = FontWeight.w900;
}

TextStyle appFont(double fontSize, Color color) =>
    AppTextStyle.appFont(fontSize: fontSize, color: color);

TextStyle appFontSize(double fontSize) =>
    AppTextStyle.appFont(fontSize: fontSize);

TextStyle appFontColor(Color color) => AppTextStyle.appFont(color: color);

TextStyle appFontLight(double fontSize, [Color color]) => AppTextStyle.appFont(
      fontSize: fontSize,
      fontWeight: AppTextStyle.light,
      color: color ?? kTextBaseColor,
    );

TextStyle appFontRegular(double fontSize, [Color color]) =>
    AppTextStyle.appFont(
      fontSize: fontSize,
      fontWeight: AppTextStyle.regular,
      color: color ?? kTextBaseColor,
    );

TextStyle appFontMedium(double fontSize, [Color color]) => AppTextStyle.appFont(
      fontSize: fontSize,
      fontWeight: AppTextStyle.medium,
      color: color ?? kTextBaseColor,
    );

TextStyle appFontSemi(double fontSize, [Color color]) => AppTextStyle.appFont(
      fontSize: fontSize,
      fontWeight: AppTextStyle.semibold,
      color: color ?? kTextBaseColor,
    );

TextStyle appFontBold(double fontSize, [Color color]) => AppTextStyle.appFont(
      fontSize: fontSize,
      fontWeight: AppTextStyle.bold,
      color: color ?? kTextBaseColor,
    );
