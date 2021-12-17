import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_vectors.dart';

class PayMentSuccesDialog {
  Future alertDialogSuccess(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });

          return AlertDialog(
            // insetPadding: EdgeInsets.symmetric(vertical: 100),
            content: Container(
              width: 350,
              height: 380,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Successfully Purchased !",
                          style: TextStyle(
                              fontSize: 22,
                              color: AppColors.success_color,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 10),
                        SvgPicture.asset(
                          'assets/vectors/thumbs_up.svg',
                          height: 150,
                          width: 150,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Shop Again",
                          style: TextStyle(color: AppColors.kAccentColor),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
