import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';

import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_vectors.dart';

class ShareCouponSuccesDialog extends StatefulWidget {
  @override
  _ShareCouponSuccesDialogState createState() =>
      _ShareCouponSuccesDialogState();
}

class _ShareCouponSuccesDialogState extends State<ShareCouponSuccesDialog> {
  String townSelectedStore;

  bool status = false;

  bool loginStatus = false;

  @override
  void initState() {
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    Timer(
        Duration(seconds: 8),
        () => //Navigator.pushNamed(context, '/passwordsettingpage')
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainHomePage())));

    //'/login',
    ///productinarea
    // /storepageproduction
    ///mycouponspage
    ///googlelocationpage
    ////allcategoriesPage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Successfully paid !",
                      style: TextStyle(
                          fontSize: 22,
                          color: AppColors.success_color,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 14),
                    SvgPicture.asset(
                      AppVectors.success_svg,
                      height: 150,
                      width: 150,
                    ),
                    SizedBox(height: 14),
                    Text(
                      "Shop Again",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
