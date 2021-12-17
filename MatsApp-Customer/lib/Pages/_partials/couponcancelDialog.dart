import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Pages/_partials/app_choice_dialog.dart';
import 'package:matsapp/constants/app_colors.dart';

dynamic couponcancelDialog(
    BuildContext context, String termsAndConditions, CouponModel coupon,
    {VoidCallback onCancel, Text content}) {
  if (termsAndConditions?.isNotEmpty ?? false)
    return () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: TermsConditionView(
              termsConditions: termsAndConditions,
              onCancel: onCancel,
              coupoun: coupon,
            ),
          );
        });
  else
    return null;
}

class TermsConditionView extends StatelessWidget {
  final String termsConditions;
  final VoidCallback onCancel;
  final CouponModel coupoun;

  const TermsConditionView(
      {Key key, this.termsConditions, this.onCancel, this.coupoun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.kPrimaryColor, width: 2),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Column(children: [
          Container(
              color: AppColors.kPrimaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Terms and Conditions",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: AppColors.kBackColor,
                          ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.close,
                          color: AppColors.kBackColor,
                        ),
                        onPressed: () => Navigator.pop(context))
                  ])),
          Expanded(
              child: CupertinoScrollbar(
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Html(data: termsConditions),
                      //if (onCancel != null)
                      if (coupoun.shareFlag.isNotEmpty)
                        coupoun.shareFlag.contains("true" ?? false)
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 12, right: 12.0, left: 12.00),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      await showChoiceDialogCancel(
                                          context, "Cancel coupon?", coupoun,
                                          content: Text(
                                              "Are you sure want to cancel this coupon? This action can't be undone."));
                                      // if (result) {
                                      //   Navigator.pop(context);
                                      //   onCancel.call();
                                      // }
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel Coupon",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ))),
                              )
                            : Container()
                    ],
                  ))))
        ]));
  }
}
