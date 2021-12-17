import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Modeles/coupon_generate/voucher_model.dart';
import 'package:matsapp/Pages/_partials/app_loading_spinner.dart';
import 'package:matsapp/Pages/_views/success_dialog.dart';
import 'package:matsapp/Pages/my_coupons/_partials/coupon_widget.dart';
import 'package:matsapp/Pages/my_coupons/_partials/voucher_item.dart';
import 'package:matsapp/Pages/qr_scanner/qr_code_scanner.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/redux/actions/my_coupons/my_coupons_action.dart';
import 'package:matsapp/redux/models/my_coupon_model.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/my_coupons/redeem_coupon_view_model.dart';
import 'package:matsapp/utilities/app_number_formatter.dart';
import 'package:shimmer/shimmer.dart';

class BillAmountPageVoucher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Bill Amount")),
        body: Builder(
          builder: (context) => StoreConnector<AppState, RedeemCouponViewModel>(
              onInitialBuild: (viewModel) {
                viewModel.getVouchers();
              },
              converter: (store) => RedeemCouponViewModel.fromStore(store),
              onDispose: (store) => store.dispatch(RedeemClearAction()),
              onWillChange: (old, viewModel) async {
                if (old.isLoading && viewModel.hasError) {
                  final snackBar =
                      SnackBar(content: Text(viewModel.loadingError ?? ""));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (!old.isRedeemed && viewModel.isRedeemed) {
                  await showSuccessDialog(context);
                  viewModel.onClear();
                  Navigator.pop(context);
                }
              },
              onDidChange: (old, viewModel) async {},
              builder: (context, viewModel) {
                if (viewModel.isLoading) return AppLoadingSpinner(size: 64);

                return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _getChild(viewModel));
              }),
        ));
  }

  Widget _getChild(RedeemCouponViewModel viewModel) {
    return Builder(
      builder: (BuildContext context) {
        if (viewModel.redeemState.isBillScreen) {
          return CouponBill(
            hasCoupons: viewModel.comboCoupons.isNotEmpty,
            hasVouchers: viewModel.comboVouchers.isNotEmpty,
            discountAmount: viewModel.getDiscountValue(),
            billAmount: viewModel.billAmount,
            onBillAmountChange: viewModel.onBillChange,
            onSubmit: (val) {
              scanQR(context, viewModel);
            },
            changeVoucher: viewModel.onChangeVoucher,
          );
        } else if (viewModel.redeemState.isComboScreen) {
          return Padding(
            padding: const EdgeInsets.only(
                bottom: 8.0, top: 14.0, right: 8, left: 12),
            child: AddOnSelectionWidget(
              coupons: viewModel.comboCoupons,
              vouchers: viewModel.comboVouchers,
              selectedComboVoucher: viewModel.voucher,
              onVoucherSelect: viewModel.onComboVoucherSelect,
              onCouponSelect: viewModel.onComboCouponSelect,
              selectedComboCoupon: viewModel.coupon,
              onCombine: viewModel.onCombineVoucher,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(
                bottom: 8.0, top: 14.0, right: 8, left: 12),
            child: AddOnBillPage(
              coupon: viewModel.coupon,
              voucher: viewModel.voucher,
              onChangeVoucher: viewModel.onChangeVoucher,
              billAmount: viewModel.billAmount,
              onBillAmountChange: viewModel.onBillChange,
              onConfirm: (val) {
                scanQR(context, viewModel);
              },
            ),
          );
        }
      },
    );
  }

  void scanQR(BuildContext context, RedeemCouponViewModel viewModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return QRCodeScanner(
              onResult: (code) {
                Navigator.pop(context);
                viewModel.onRedeem(code);
              },
            );
          },
          fullscreenDialog: true,
        ));
  }
}

class AddOnBillPage extends StatelessWidget {
  final VoucherModel voucher;
  final CouponModel coupon;
  final VoidCallback onChangeVoucher;
  final Function(double) onConfirm;
  final Function(double) onBillAmountChange;
  final double billAmount;

  const AddOnBillPage({
    Key key,
    this.voucher,
    this.coupon,
    this.onChangeVoucher,
    this.onConfirm,
    this.billAmount,
    this.onBillAmountChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
            child: SingleChildScrollView(
                child: Column(children: [
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 20,
                color: AppColors.kAccentColor,
              ),
              children: [
                TextSpan(
                  text: 'You have Combined',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                    text: ' 1 Coupon ',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                if (voucher != null)
                  TextSpan(
                      text: '& 1 Vouchers',
                      style: TextStyle(fontWeight: FontWeight.w700))
              ],
            ),
            textAlign: TextAlign.left,
          ),
          CouponWidget(coupon: coupon),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Icon(Icons.add, size: 36)),
          InkWell(
            child: VoucherListItem(voucher: voucher),
            onTap: onChangeVoucher,
          ),
          SizedBox(height: 20),
          Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 19,
                  color: const Color(0xff000000),
                ),
                children: [
                  TextSpan(
                    text: 'Total Purchase Discount : ',
                  ),
                  TextSpan(
                    text:
                        'Rs ${AppNumberFormat((coupon?.couponValue ?? 0) + (voucher?.voucherValue ?? 0)).currency}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center),
          SizedBox(height: 12),
          VoucherSubmitWidget(
            billAmount: billAmount,
            onSubmit: onConfirm,
            onChange: onBillAmountChange,
            discountAmount:
                (coupon?.couponValue ?? 0) + (voucher?.voucherValue ?? 0),
          )
        ]))));
  }
}

class VoucherSubmitWidget extends StatefulWidget {
  final Function(double) onSubmit;
  final Function(double) onChange;
  final double billAmount;
  final double discountAmount;

  const VoucherSubmitWidget({
    Key key,
    this.onSubmit,
    this.billAmount,
    this.discountAmount = 0,
    this.onChange,
  }) : super(key: key);

  @override
  _VoucherSubmitWidgetState createState() => _VoucherSubmitWidgetState();
}

class _VoucherSubmitWidgetState extends State<VoucherSubmitWidget> {
  double _billAmount;
  GlobalKey<FormState> _submissionFormKey;

  @override
  void initState() {
    _billAmount = widget.billAmount ?? widget.discountAmount;
    _submissionFormKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
            key: _submissionFormKey,
            child: Column(children: [
              Text(
                'Enter your Final Bill Amount and Scan the QR',
                style: TextStyle(
                  fontSize: 12,
                  color: const Color(0xff707070),
                  letterSpacing: 0.24,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: AppColors.kPrimaryColor),
                      color: const Color(0xffffecd1),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x96ffac1e),
                            offset: Offset(0, 3),
                            blurRadius: 6)
                      ]),
                  child: TextFormField(
                      initialValue: "$_billAmount",
                      keyboardType: TextInputType.number,
                      validator: _fieldValidation,
                      // onChanged: (val) {
                      //   _formValidation();
                      //   widget.onChange?.call(double.tryParse(val));
                      // },
                      onSaved: (val) =>
                          setState(() => _billAmount = double.parse(val)),
                      style: TextStyle(
                          letterSpacing: 0.56,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightGreyWhite),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: "",
                          suffixText: "",
                          prefixText: "Rs   ",
                          hintStyle: TextStyle(
                              letterSpacing: 0.56,
                              fontSize: 22,
                              fontWeight: FontWeight.w600)))),
              SizedBox(height: 18),
              InkWell(
                onTap: _onFormSubmission,
                child: Container(
                    alignment: Alignment.center,
                    height: 46,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: const Color(0xffff4646),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x82ff4646),
                          offset: Offset(0, 7),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: Text('Confirm',
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color(0xffffffff),
                            letterSpacing: 0.496,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left)),
              )
            ])));
  }

  void _onFormSubmission() {
    var state = _submissionFormKey.currentState;
    if (state.validate()) {
      state.save();
      widget.onSubmit(_billAmount);
    }
  }

  bool _formValidation() {
    return _submissionFormKey.currentState.validate();
  }

  String _fieldValidation(String value) {
    // double _amount;

    if (value.contains("0.0") || value.isEmpty) {
      return "Please enter bill amount";
    } else {
      return null;
    }
  }
}

class AddOnSelectionWidget extends StatelessWidget {
  final List<VoucherModel> vouchers;
  final List<CouponModel> coupons;
  final VoucherModel selectedComboVoucher;
  final CouponModel selectedComboCoupon;
  final ValueSetter<VoucherModel> onVoucherSelect;
  final ValueSetter<CouponModel> onCouponSelect;
  final VoidCallback onCombine;

  const AddOnSelectionWidget({
    Key key,
    this.vouchers,
    this.coupons,
    this.selectedComboVoucher,
    this.onVoucherSelect,
    this.onCouponSelect,
    this.onCombine,
    this.selectedComboCoupon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (vouchers.isNotEmpty)
        _AddonHeaderWidget(count: vouchers.length, isCoupon: false)
      else if (coupons.isNotEmpty)
        _AddonHeaderWidget(count: coupons.length, isCoupon: true),
      Expanded(
          child: Scrollbar(
              child: (vouchers.isNotEmpty)
                  ? ListView.builder(
                      itemCount: vouchers?.length ?? 0,
                      itemBuilder: (context, position) {
                        var voucher = vouchers.elementAt(position);
                        return AddonOptionItem(
                          child: VoucherListItem(voucher: voucher),
                          isSelected: voucher.userVoucherId ==
                              selectedComboVoucher?.userVoucherId,
                          onSelect: () => onVoucherSelect(voucher),
                        );
                      })
                  : ListView.builder(
                      itemCount: coupons?.length ?? 0,
                      itemBuilder: (context, position) {
                        var coupon = coupons.elementAt(position);

                        return AddonOptionItem(
                            child: CouponWidget(
                              coupon: coupon,
                              overlayColor: _getCouponOverlayColor(position),
                            ),
                            isSelected: coupon.userCouponId ==
                                selectedComboCoupon?.userCouponId,
                            onSelect: () => onCouponSelect(coupon));
                      }))),
      InkWell(
          onTap: onCombine,
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: LinearGradient(
                      begin: Alignment(-0.98, 0.0),
                      end: Alignment(0.8, 0.0),
                      colors: [
                        const Color(0xfffd8e34),
                        const Color(0xffffb11a)
                      ]),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x57ffac1e),
                        offset: Offset(0, 3),
                        blurRadius: 6)
                  ]),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(child: child, scale: animation),
                child: Text(
                    selectedComboVoucher != null
                        ? 'Combine Vouchers'
                        : 'Continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        letterSpacing: .75,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
              )))
    ]);
  }

  Color _getCouponOverlayColor(int position) {
    switch (position % 3) {
      case 0:
        return Color(0xffFC500C);
      case 1:
        return Color(0xff31B5DF);
      case 2:
        return Color(0xff0F1EA4);
      default:
        return Color(0xffFC500C);
    }
  }
}

class _AddonHeaderWidget extends StatelessWidget {
  final int count;
  final bool isCoupon;

  const _AddonHeaderWidget({Key key, this.count, this.isCoupon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 26,
                color: AppColors.kAccentColor,
              ),
              children: [
                TextSpan(
                  text: 'You have ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '$count ',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '${isCoupon ? "Discount Coupons" : "Cash Vouchers"}',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Choose any 1 ${isCoupon ? "discount coupons" : "cash vouchers"} ',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.lightGreyWhite,
                  letterSpacing: 1.4,
                ),
                textAlign: TextAlign.left,
              ),
              IconButton(icon: Icon(Icons.info_rounded), onPressed: () {})
            ],
          ),
        ],
      ),
    );
  }
}

class AddonOptionItem extends StatelessWidget {
  final bool isSelected;
  final Widget child;
  final VoidCallback onSelect;

  const AddonOptionItem({
    Key key,
    this.isSelected = false,
    this.onSelect,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSelect,
      child: Container(
        child: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: isSelected ? AppColors.success_color : Colors.white,
                  border: Border.all(color: AppColors.lightGreyWhite)),
            ),
            SizedBox(width: 12),
            Expanded(child: child)
          ],
        ),
      ),
    );
  }
}

class CouponBill extends StatelessWidget {
  final double discountAmount;
  final double billAmount;
  final bool hasVouchers;
  final bool hasCoupons;
  final Function(double) onSubmit;
  final Function(double) onBillAmountChange;

  final VoidCallback changeVoucher;

  const CouponBill({
    Key key,
    this.discountAmount,
    this.billAmount,
    this.onSubmit,
    this.changeVoucher,
    this.hasVouchers,
    this.hasCoupons,
    this.onBillAmountChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gradient = LinearGradient(
      colors: <Color>[
        const Color(0xffa34200),
        const Color(0xffb37d0c),
        const Color(0xffffb517),
        const Color(0xffac4700),
        const Color(0xff7c3302)
      ],
    );
    final Shader goldenGradientText =
        gradient.createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (hasCoupons || hasVouchers)
            InkWell(
              onTap: changeVoucher,
              child: Shimmer(
                gradient: gradient,
                child: Container(
                  alignment: Alignment.center,
                  height: 46,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.kPrimaryColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "You have pending ${hasVouchers ? "cash vouchers" : "coupons"}  ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      letterSpacing: 0.84,
                      foreground: Paint()..shader = goldenGradientText,
                    ),
                  ),
                ),
              ),
            ),
          SvgPicture.asset(AppVectors.savings_svg),
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 22,
                color: AppColors.kAccentColor,
              ),
              children: [
                TextSpan(text: 'Your savings will be '),
                TextSpan(
                    text: 'Rs ${AppNumberFormat(discountAmount).currency}/- \n',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: 'for this Purchase'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          VoucherSubmitWidget(
            billAmount: billAmount,
            discountAmount: discountAmount,
            onSubmit: onSubmit,
            onChange: onBillAmountChange,
          ),
        ],
      ),
    );
  }
}
