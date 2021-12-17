import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_vectors.dart';

Future<T> showSuccessDialog<T>(
  BuildContext context,
) {
  return showDialog(
      //barrierColor: Colors.tr,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SuccessDialog(),
        );
      });
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Congrats!",
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
          ElevatedButton(
              /*style:
                  ButtonStyle(backgroundColor: AppColors.kPrimaryColor.value),*/
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Continue",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
