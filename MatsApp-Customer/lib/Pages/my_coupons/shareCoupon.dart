import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matsapp/Modeles/ShareCouponVerifiyModel.dart';
import 'package:matsapp/Network/ShareCouponVerifiyRepo.dart';
import 'package:matsapp/Network/ShareCoupounRepo.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';

import 'package:matsapp/Pages/my_coupons/my_coupons_page.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/services/base_service.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ShareCoupon extends StatefulWidget {
  final String couponId;
  final String couponType;
  final int id;
  ShareCoupon(this.couponId, this.couponType, this.id);

  @override
  _ShareCouponState createState() => _ShareCouponState();
}

class _ShareCouponState extends State<ShareCoupon> {
  TextEditingController MobileControler = new TextEditingController();
  Future<ShareCouponVerifiyModel> futurestoreDetailes;

  String userName;

  String apiKey;
  final _form = GlobalKey<FormState>();
  String mobileNumber;
  final passwordFocus = FocusNode();

  bool isload = false;
  @override
  void dispose() {
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight =
        MediaQuery.of(context).size.height - kTextTabBarHeight;
    AppBar appbar = AppBar(
      backgroundColor: Colors.white,
      title: Text("Share Coupon",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.25,
              fontSize: 18,
              color: Colors.blueGrey)),
      centerTitle: true,
      leading: InkWell(
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainHomePage()));
        },
      ),
    );
    return Scaffold(
      appBar: appbar,
      body: Container(
        width: ScreenWidth,
        height: ScreenHeight,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: ScreenWidth,
                //height: ScreenHeight / 15,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: Text(
                          "Enter a Mobile Number !",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 0.9),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                //width: ScreenWidth,
                // height: ScreenHeight * .10,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: ScreenWidth * .60,
                        height: ScreenHeight * .10,
                        child: Form(
                          key: _form,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            maxLength: 10,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: Validators.compose([
                              Validators.minLength(10, 'Invalid Mobile Number'),
                              Validators.maxLength(10, 'Max Length is 10'),
                              Validators.required('Mobile no is required'),
                            ]),
                            controller: MobileControler,
                            autofocus: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixText: '+91\r',
                              prefixStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              filled: false,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 1.0, top: 5.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(5.0)),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ElevatedButton(
                          child: Text(
                            'Verifiy',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            apiKey = await BaseService().getApiKey;
                            mobileNumber = await BaseService().getMobileNo();
                            if (_form.currentState.validate()) {}
                            setState(() {
                              if (MobileControler.text != mobileNumber) {
                                futurestoreDetailes = verifiyCouponFetch(
                                    MobileControler.text, apiKey);
                              } else {
                                GeneralTools().createSnackBarCommon(
                                    "Please Enter different Number ", context);
                              }
                            });
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(
                                  10), //Defines Elevation
                              shadowColor: MaterialStateProperty.all(
                                  AppColors.kAccentColor),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              textStyle: MaterialStateProperty.all(TextStyle(
                                  fontSize: 16, color: Colors.white))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<ShareCouponVerifiyModel>(
                  future: futurestoreDetailes,
                  builder: (BuildContext context,
                      AsyncSnapshot<ShareCouponVerifiyModel> snapshot) {
                    if (snapshot.hasData) {
                      userName = snapshot.data.result.username ?? "";
                      if (snapshot.data.apiKeyStatus) {
                        return Card(
                          elevation: 5,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              snapshot.data.result.photoUrl,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 80.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              CircleAvatar(
                                                  radius: 50,
                                                  child: Icon(Icons.image)),
                                          errorWidget: (context, url, error) =>
                                              CircleAvatar(
                                                  radius: 50,
                                                  child: Icon(Icons.image)),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: ScreenWidth * .50,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "${snapshot.data.result.username ?? ""}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            "+91\r${snapshot.data.result.mobile ?? ""}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          snapshot.data.result.location != null
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: AppColors
                                                          .kAccentColor,
                                                      size: 20,
                                                    ),
                                                    Text(
                                                        snapshot.data.result
                                                                .location ??
                                                            "",
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                    Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                      size: 20,
                                                    )
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 60,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: ScreenWidth * .90,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Container(
                                          width: ScreenWidth * .50,
                                          child: InkWell(
                                            child: DottedBorder(
                                                color: AppColors.kAccentColor,
                                                strokeWidth: 2.5,
                                                radius: new Radius.circular(10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.share,
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                      "Share Your Coupon",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    )
                                                  ],
                                                )),
                                            onTap: () {
                                              alertDialogShareCoupon(
                                                  context, userName);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: DottedBorder(
                              color: Colors.red,
                              strokeWidth: 2.5,
                              radius: new Radius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  "Invalid Mobile number ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Container(
                        child: DottedBorder(
                          color: Colors.red,
                          strokeWidth: 2.5,
                          radius: new Radius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              " Mobile Number is Unavilable ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future alertDialogShareCoupon(BuildContext context, String user) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return Center(
            child: AlertDialog(
              // backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(vertical: 100),
              content: ModalProgressHUD(
                progressIndicator: CircularProgressIndicator(),
                inAsyncCall: isload,
                dismissible: false,
                opacity: 1,
                child: Container(
                  width: width * .60,
                  height: height / 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "You are Sharing this Coupon to",
                        style: TextStyle(fontSize: 16),
                      ),
                      Expanded(
                          child: Text(
                        user,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ))
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                Center(
                  child: Container(
                    width: width * .75,
                    height: height / 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: DottedBorder(
                            color: Colors.red,
                            strokeWidth: 2.5,
                            radius: new Radius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "Cancel",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        InkWell(
                          child: DottedBorder(
                            color: Colors.green,
                            strokeWidth: 2.5,
                            radius: new Radius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "Proceed",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              isload = true;
                            });
                            shareCouponTomobile(
                                    mobileNumber,
                                    MobileControler.text.toString(),
                                    apiKey,
                                    widget.couponType,
                                    widget.couponId,
                                    widget.id)
                                .then((value) => {
                                      if (value.result == 1)
                                        {
                                          setState(() {
                                            isload = false;
                                          }),
                                          alertDialogSuccess(context)
                                              .whenComplete(() =>
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MainHomePage())))
                                        }
                                      else
                                        {
                                          setState(() {
                                            isload = false;
                                          }),
                                          GeneralTools().createSnackBarFailed(
                                              'Sharing failed!', context)
                                        }
                                    });
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Future alertDialogSuccess(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          Future.delayed(Duration(seconds: 3), () {
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
                          "Successfully Shared !",
                          style: TextStyle(
                              fontSize: 22,
                              color: AppColors.success_color,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 10),
                        SvgPicture.asset(
                          AppVectors.success_svg,
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

  Future showSnackbar(BuildContext context) async {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 8),
      content: Center(
        child: Container(
          color: Colors.white,
          width: 350,
          height: 380,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Successfully Shared !",
                style: TextStyle(
                    fontSize: 22,
                    color: AppColors.success_color,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10),
              SvgPicture.asset(
                AppVectors.success_svg,
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
      ),
    ));
  }
}
