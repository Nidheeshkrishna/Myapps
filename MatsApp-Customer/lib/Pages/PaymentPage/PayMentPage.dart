import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:matsapp/Pages/StorePage/StorePageProduction.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayMentPage extends StatefulWidget {
  final int orderId;
  final double purchaseValue;

  final String businessName;
  final int businessId;

  PayMentPage(
      this.orderId, this.purchaseValue, this.businessName, this.businessId,
      {Key key})
      : super(key: key);

  @override
  _PayMentPageState createState() => _PayMentPageState();
}

class _PayMentPageState extends State<PayMentPage> {
  var _url;
  // final _key = UniqueKey();
  int usrId;
  var mob;
  var apiKey;

  String selectedtown;
  // final GlobalKey webViewKey = GlobalKey();
  // @override
  void initState() {
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    getUrl(widget.purchaseValue, widget.orderId);
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
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => StorePageProduction(
                      widget.businessId, selectedtown, widget.businessName)));
        },
      ),
    );
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => StorePageProduction(
                    widget.businessId, selectedtown, widget.businessName)));
      },
      child: Scaffold(
          appBar: appbar,
          resizeToAvoidBottomInset: true,
          body: InAppWebView(
            initialOptions: options,
            initialUrlRequest: URLRequest(url: Uri.parse(_url)),
            onWebViewCreated: (controller) {
              controller.addJavaScriptHandler(
                handlerName: 'handlerFoo',
                callback: (List<dynamic> arguments) {
                  //print(arguments);
                },
              );
              JavascriptChannel(
                  name: 'closeForm',
                  onMessageReceived: (JavascriptMessage message) {
                    print(message.message);
                  });
              controller.addJavaScriptHandler(
                  handlerName: 'closeForm',
                  callback: (args) {
                    //Navigator.of(context).pop();
                    Navigator.popAndPushNamed(context, "/mycouponspage");
                    //print(args);
                    // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                  });
            },
          )),
    );
  }

  Future<void> getUrl(double purchaseValue, int orderId) async {
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    setState(() async {
      usrId = await userData().getUserId();
      mob = await userData().getMobileNo();
      apiKey = await userData().getApiKey;
    });

    setState(() {
      _url = Urls.paymentcheckout +
          "?" +
          "OrderId=" +
          "$orderId" +
          "&" +
          "UserID=" +
          "$usrId" +
          "&" +
          "TotalAmount=$purchaseValue";
      //"UserID"=user.getUserId()} & "Mobile"=&api_key=await userData().getApiKey};
    });
  }
}
