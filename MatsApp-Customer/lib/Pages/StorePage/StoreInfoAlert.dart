import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/size_config.dart';

class AppDialoges {
  Future storeInfoAlert(
    BuildContext context,
    //String termsConditions,
  ) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              //insetPadding: EdgeInsets.symmetric(vertical: 100),
              content: Container(
                  //width: SizeConfig.screenwidth,
                  //height: SizeConfig.screenheight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: AppColors.kPrimaryColor, width: 2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Column(children: [
                    Container(
                        color: AppColors.kPrimaryColor,
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
                    ListView.builder(
                        shrinkWrap: true,
                        //itemExtent: 50,
                        itemCount: TermsAndConditions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            minLeadingWidth: 2,
                            leading: Icon(
                              Icons.fiber_manual_record,
                              color: AppColors.kAccentColor,
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                  TermsAndConditions[index]["Condition"],
                                  style: TextStyle(
                                      color: AppColors.kSecondaryDarkColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                            ),
                          );
                        }),
                  ])));
        });
  }

  couponInfoAlert(BuildContext context, String content) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Container(
              height: SizeConfig.heightMultiplier * 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(top: 8, right: 8),
                    width: SizeConfig.widthMultiplier * 75,
                    child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.pop(context)),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(content)),
                ],
              ),
            ),
          );
        });
  }

  static const List<Map<String, Object>> TermsAndConditions = [
    {
      'id': '1',
      'Condition':
          " All Offers displayed in the application are completely managed by the store owner.",
    },
    {
      'id': '2',
      'Condition':
          "User need to buy the Coupon to avail all the Exclusive offers displayed in the app. ",
    },
    {
      'id': '3',
      'Condition': " A user can avail only one coupon at a time. ",
    },
    {
      'id': '4',
      'Condition':
          "Before visiting the store, use the call option to confirm the availability of offers with the store owner. ",
    },
    {
      'id': '5',
      'Condition':
          "The Store owner is fully responsible, if the Offers goes out of stock. ",
    },
  ];
}
