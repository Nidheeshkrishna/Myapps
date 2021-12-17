import 'dart:async';

import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/PaymentModels/paymentOrderIDModel.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Network/Payment/paymentOrderIdRepo.dart';

class PayMentHomePage extends StatefulWidget {
  final CouponModel coupon;
  PayMentHomePage(this.coupon);

  @override
  _PayMentHomePageState createState() => _PayMentHomePageState();
}

class _PayMentHomePageState extends State<PayMentHomePage> {
  TextEditingController textEditingController = new TextEditingController();

  StreamController<PaymentOrderIdModel> _userController;
  int orderid1;
  @override
  void initState() {
    super.initState();

    fetchOrderId(
            widget.coupon.couponId,
            widget.coupon.purchaseValue,
            widget.coupon.couponValue,
            widget.coupon.purchaseLimit,
            "1",
            widget.coupon.couponType)
        .then((value) => {
              setState(() {
                orderid1 = value.result.ucId;
              }),
              print(widget.coupon.purchaseValue),
            });
    // _userController = new StreamController();
    // loadDetails().then((value) => {
    //       setState(() {
    //         orderid1 = value;
    //       }),
    //       print("{KKJJSKDKKSSK$orderid1}"),
    //     });
    // razorpay = new Razorpay();

    // razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    // razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    // openCheckout();
  }

  @override
  void dispose() {
    super.dispose();
    // razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razor Pay Tutorial"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: "amount to pay"),
            ),
            SizedBox(
              height: 12,
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                "Donate Now",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                //openCheckout();
              },
            )
          ],
        ),
      ),
    );
  }

  Future loadDetails() async {
    fetchOrderId(
            widget.coupon.couponId,
            widget.coupon.purchaseValue,
            widget.coupon.couponValue,
            widget.coupon.purchaseLimit,
            "1",
            widget.coupon.couponType)
        .then((res) async {
      //print('LoadDetails of ${res.fname}');
      //_userController.sink.close();

      _userController.add(res);
      // if (_isDisposed) {

      //   return res;
      // }
      return res;
    });
  }
}
