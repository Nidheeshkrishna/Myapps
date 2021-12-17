import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Pages/_partials/app_loading_spinner.dart';
import 'package:matsapp/Pages/_partials/tc_dialog.dart';
import 'package:matsapp/Pages/my_coupons/_partials/coupon_widget.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/generate_coupon/generate_coupon_view_model.dart';
import 'package:matsapp/utilities/app_number_formatter.dart';

import 'buy_coupon_dialog.dart';

class CouponGeneratePage extends StatelessWidget {
  final String type;
  final String couponId;
  final String couponType;

  const CouponGeneratePage({
    Key key,
    this.type,
    this.couponId,
    this.couponType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: _buildAppBar(),
      ),
      body: Builder(
        builder: (context) => StoreConnector<AppState, GenerateCouponViewModel>(
          onInitialBuild: (viewModel) => viewModel.initialise(couponId, type),
          converter: (store) => GenerateCouponViewModel.fromStore(store),
          onDispose: (store) =>
              store.dispatch(OnClearAction(type: "generatecoupon")),
          onDidChange: (old, viewModel) {
            if (old.isLoading && viewModel.hasError) {
              final snackBar =
                  SnackBar(content: Text(viewModel.loadingError ?? ""));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, _viewModel) {
            if (_viewModel.isLoading) return AppLoadingSpinner();

            return Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 18),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          'Create Your Discount coupon',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            color: AppColors.kAccentColor,
                            letterSpacing: 0.6,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                          height: 230.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black_shadow_color,
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: CouponWidget(coupon: _viewModel.coupon)),
                      SizedBox(height: 16),
                      CouponPurchase(
                        coupon: _viewModel.coupon,
                        // onMultiplierChanged: _viewModel.onMultiplierChanged,
                        // multiplier: _viewModel.multiplier,
                      ),
                      SizedBox(height: 16),
                      TextButton(
                          style: TextButton.styleFrom(
                              primary: AppColors.info_color),
                          onPressed: showTermsAndConditionsDialog(
                              context, _viewModel.coupon?.termsAndConditions),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Coupon Details',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Icon(Icons.chevron_right, size: 17),
                                Icon(Icons.chevron_right, size: 17)
                              ])),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(child: BuyCouponDialog());
                                  });
                            },
                            child: Container(
                              height: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.warning_color,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.warning_color,
                                    offset: Offset(0, 7),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              child: Text(
                                'Generate Coupon',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  letterSpacing: 0.62,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return StoreBuilder<AppState>(builder: (context, store) {
      return Text(
          store.state.generateCouponState?.coupon?.businessName ?? "Store",
          textAlign: TextAlign.center);
    });
  }
}

class CouponPurchase extends StatelessWidget {
  final CouponModel coupon;

  //final ValueChanged<int> onMultiplierChanged;

  final int multiplier;

  const CouponPurchase({
    Key key,
    @required this.coupon,
    this.multiplier = 1,
    //@required this.onMultiplierChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.0,
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 23,
            child: Container(
              height: 230.0,
              child: DottedBorder(
                strokeWidth: 2,
                color: kPrimaryColor,
                radius: Radius.circular(10.0),
                borderType: BorderType.RRect,
                dashPattern: [6, 6, 6, 6],
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Text(
                      'Choose  your Purchase Limit',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.kAccentColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    SvgPicture.string(
                      AppVectors.BorderSvg,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: 12),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.kAccentColor,
                        ),
                        children: [
                          TextSpan(
                            text: 'Purchase Limit : \n',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Rs ${AppNumberFormat(coupon?.purchaseLimit ?? 0).currency} /-',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // coupon?.couponType == "Business"
                        //     ? IconButton(
                        //         onPressed: () =>
                        //         multiplier > 1
                        //             ? onMultiplierChanged(multiplier - 1)
                        //             : null,
                        //         icon: Icon(
                        //           Icons.remove,
                        //           size: 24,
                        //           color: AppColors.dar_hint_color,
                        //         ),
                        //       )
                        //     : Container(),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black_shadow_color,
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$multiplier',
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.kAccentColor,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // coupon?.couponType == "Business"
                        //     ? IconButton(
                        //         onPressed: (coupon?.maximumDenomination ?? 0) >=
                        //                 ((coupon?.purchaseLimit ?? 0) /
                        //                     multiplier *
                        //                     (1 + multiplier))
                        //             ? () => onMultiplierChanged(multiplier + 1)
                        //             : null,
                        //         color: AppColors.dar_hint_color,
                        //         disabledColor: Colors.grey.shade500,
                        //         icon: Icon(Icons.add, size: 24),
                        //       )
                        //     : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 28,
              left: 28,
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: LinearGradient(
                    begin: Alignment(-0.98, 0.0),
                    end: Alignment(0.8, 0.0),
                    colors: [const Color(0xfffd8e34), const Color(0xffffb11a)],
                    stops: [0.0, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x57ffac1e),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Purchase Value : ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${AppNumberFormat(coupon?.purchaseValue ?? 0).currency} /-',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class HoleClipper extends CustomClipper<Path> {
  final double holeRadius;

  HoleClipper({
    this.holeRadius = 20,
  });

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, holeRadius)
      ..arcToPoint(
        Offset(holeRadius, 0),
        clockwise: false,
        radius: Radius.circular(holeRadius),
      )
      ..lineTo(size.width - holeRadius, 0.0)
      ..arcToPoint(
        Offset(
          size.width,
          holeRadius,
        ),
        clockwise: false,
        radius: Radius.circular(holeRadius),
      );

    var curXPos = size.width;
    var curYPos = holeRadius;
    var increment = size.height / 40;
    while (curYPos < size.height - holeRadius) {
      curYPos += increment / 2;
      path.lineTo(size.width, curYPos);
      curYPos += increment;
      path.arcToPoint(
        Offset(curXPos, curYPos),
        radius: Radius.circular(1),
        clockwise: false,
      );
      curYPos += increment / 2;
      path.lineTo(size.width, curYPos);
    }

    path.arcToPoint(
      Offset(size.width - holeRadius, size.height),
      clockwise: false,
      radius: Radius.circular(holeRadius),
    );
    path.lineTo(holeRadius, size.height);

    path.arcToPoint(
      Offset(0, size.height - holeRadius),
      clockwise: false,
      radius: Radius.circular(holeRadius),
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(HoleClipper oldClipper) => true;
}
