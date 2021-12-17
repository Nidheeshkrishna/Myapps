import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Pages/_partials/app_choice_dialog.dart';
import 'package:matsapp/constants/app_colors.dart';

dynamic showTermsAndConditionsDialog(
    BuildContext context, String termsAndConditions, 
    {VoidCallback onCancel}) {
  if (termsAndConditions?.isNotEmpty ?? false)
    return () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: TermsConditionView(
              termsConditions: termsAndConditions,
              onCancel: onCancel,
            ),
          );
        });
  else
    return null;
}

class TermsConditionView extends StatelessWidget {
  final String termsConditions;
  final VoidCallback onCancel;

  const TermsConditionView({Key key, this.termsConditions, this.onCancel})
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
                      if (onCancel != null)
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 12, right: 12.0, left: 12.00),
                        child: ElevatedButton(
                            onPressed: () async {
                              bool result = await showChoiceDialog(
                                  context, "Cancel coupon?",
                                  content: Text(
                                      "Are you sure want to cancel this coupon? This action can't be undone."));
                              if (result) {
                                Navigator.pop(context);
                                onCancel.call();
                              }
                              Navigator.pop(context);
                            },
                            child: Text("Cancel Coupon",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ))),
                      )
                    ],
                  ))))
        ]));
  }
}
