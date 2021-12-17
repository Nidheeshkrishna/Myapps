import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Network/CoupounCancel/CoupounCancelRepo.dart';
import 'package:matsapp/Pages/my_coupons/my_coupons_page.dart';
import 'package:matsapp/utilities/GerneralTools.dart';

Future<bool> showChoiceDialog(
  BuildContext context,
  String title, {
  Widget content,
  String action1 = "Yes",
  String action2 = "No",
}) {
  return showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: content,
          actions: [
            CupertinoDialogAction(
                child: Text(action1),
                onPressed: () {
                  //coupouncancelService(coupounId, ucId)
                }),
            CupertinoDialogAction(
              child: Text(action2),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      });
}

Future<bool> showChoiceDialogCancel(
  BuildContext context,
  String title,
  CouponModel coupoun, {
  Widget content,
  String action1 = "Yes",
  String action2 = "No",
}) {
  return showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: content,
          actions: [
            CupertinoDialogAction(
                child: Text(action1),
                onPressed: () {
                  coupouncancelService(coupoun.couponId, coupoun.uCID)
                      .then((value1) async {
                    if (value1.result == "Success") {
                      GeneralTools().createSnackBarSuccess(
                          "Coupoun Is Cancelled ", context);
                      await Future.delayed(Duration(seconds: 1));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyCouponsPage()),
                      );
                    } else {
                      GeneralTools().createSnackBarFailed(
                          "Coupoun Cancel Failed! ", context);
                      await Future.delayed(Duration(seconds: 1));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyCouponsPage()),
                      );
                    }
                  });
                }),
            CupertinoDialogAction(
                child: Text(action2),
                onPressed: () => {Navigator.pop(context, false)}),
          ],
        );
      });
}
