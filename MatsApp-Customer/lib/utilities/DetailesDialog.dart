import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/size_config.dart';

class Dialoges {
  Future detaiesDialogSuccess(
    BuildContext context,
    String termsConditions,
  ) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(20),
              //insetPadding: EdgeInsets.symmetric(vertical: 100),
              content: Container(
                  width: SizeConfig.widthMultiplier * 90,
                  // height: screenHeight * .90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: AppColors.kPrimaryColor, width: 2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Column(children: [
                    Container(
                        color: AppColors.kPrimaryColor,
                        padding: EdgeInsets.only(left: 6),
                        // padding: const EdgeInsets.symmetric(
                        //     horizontal: 8.0, vertical: 4),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Terms and Conditions",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
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
                                child: Html(
                              data: termsConditions,
                              style: {
                                "body": Style(
                                  fontSize: FontSize(14.0),
                                ),
                              },
                            ))))
                  ])));
        });
  }
}
