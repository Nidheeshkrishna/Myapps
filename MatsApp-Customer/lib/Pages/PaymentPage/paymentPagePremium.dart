import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';

class PayMentPagePremium extends StatefulWidget {
  final int orerId;
  final int pkgId;
  final double pkgAmount;
  PayMentPagePremium(this.orerId, this.pkgId, this.pkgAmount, {Key key})
      : super(key: key);

  @override
  _PayMentPagePremiumState createState() => _PayMentPagePremiumState();
}

class _PayMentPagePremiumState extends State<PayMentPagePremium> {
  var _url;
  // final _key = UniqueKey();
  int usrId;
  var mob;
  var apiKey;
  // final GlobalKey webViewKey = GlobalKey();
  // @override
  void initState() {
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    getUrl(widget.orerId, widget.pkgAmount, widget.pkgId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double srcwidth = MediaQuery.of(context).size.width;
    double srcHeight = MediaQuery.of(context).size.height;
    InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
        ),
        ios: IOSInAppWebViewOptions());

    AppBar appbar = AppBar(
      backgroundColor: Colors.white,
      title: Text("PayMent",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.25,
              fontSize: 18,
              color: Colors.black)),
      centerTitle: true,
      leading: InkWell(
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
    return Scaffold(
        appBar: appbar,
        body: InAppWebView(
          initialOptions: options,
          initialUrlRequest: URLRequest(url: Uri.parse(_url) ?? ""),
          onWebViewCreated: (controller) {
            controller.addJavaScriptHandler(
              handlerName: 'paymentStatus100',
              callback: (List<dynamic> arguments) {
                //print(arguments);
              },
            );

            controller.addJavaScriptHandler(
                handlerName: 'closeForm',
                callback: (args) {
                  // Navigator.popAndPushNamed(context, "/mycouponspage");
                  // Navigator.of(context).pop();
                  //print(args);
                  // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                });
          },
        ));
  }

  Future<void> getUrl(int orerId, double pkgAmount, int pkgId) async {
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    usrId = await userData().getUserId();
    mob = await userData().getMobileNo();
    apiKey = await userData().getApiKey;
    setState(() {
      _url = Urls.paymentcheckoutPremium +
          "?" +
          "UserID=" +
          "$usrId" +
          "&" +
          "PKG_ID=$pkgId" +
          "&" +
          "OrderId=" +
          "$orerId" +
          "&" +
          "Amount=$pkgAmount";
      //"UserID"=user.getUserId()} & "Mobile"=&api_key=await userData().getApiKey};
    });
  }
}
