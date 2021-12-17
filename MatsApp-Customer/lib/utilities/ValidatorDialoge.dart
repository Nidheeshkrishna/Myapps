import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matsapp/constants/app_colors.dart';

class ValidatorDialoge {
  Future validatorPasswordDialoge(
    BuildContext context,
  ) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.white,
              //insetPadding: EdgeInsets.symmetric(vertical: 100),
              content: SingleChildScrollView(
                child: Container(
                    // width: double.maxFinite,
                    // height: 200,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: AppColors.kPrimaryColor, width: 2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Container(
                      child: Column(children: [
                        Container(
                            color: AppColors.kPrimaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Password Guidelines",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                            color: AppColors.kBackColor,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: AppColors.kBackColor,
                                      ),
                                      onPressed: () => Navigator.pop(context))
                                ])),
                        SingleChildScrollView(
                          child: Container(
                            // height: 200.0, // Change as per your requirement
                            // width: 300.0,
                            child: ListView(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.stars_outlined,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "Minimum 1 Upper case",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.stars_outlined,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "Minimum 1 lowercase",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.stars_outlined,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "Minimum 1 Numeric Number",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.stars_outlined,
                                    color: Colors.red,
                                  ),
                                  title: Text("Minimum 1 Special Character",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.stars_outlined,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "Common Allow Characters ( ! @ # \$ \& * ~ )",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.stars_outlined,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "Minimum 8 Characters",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    )),
              ));
        });
  }
}
