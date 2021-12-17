import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ComplaintRegisteration extends StatefulWidget {
  ComplaintRegisteration({Key key}) : super(key: key);

  @override
  _ComplaintRegisterationState createState() => _ComplaintRegisterationState();
}

class _ComplaintRegisterationState extends State<ComplaintRegisteration> {
  var _url;
  // final _key = UniqueKey();

  // final GlobalKey webViewKey = GlobalKey();
  // @override
  void initState() {
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    getUrl();
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
    );

    AppBar appbar = AppBar(
      backgroundColor: Colors.white,
      title: Text("Complaint Registration",
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: srcwidth * .90,
                height: srcHeight,
                child: InAppWebView(
                  initialOptions: options,
                  
                  initialUrlRequest: URLRequest(url: Uri.parse(_url)),
                  onWebViewCreated: (controller) {
                    controller.addJavaScriptHandler(
                      handlerName: 'handlerFoo',
                      callback: (List<dynamic> arguments) {
                        
                        //print(arguments);
                      },
                    );

                    controller.addJavaScriptHandler(
                        handlerName: 'handlerFooWithArgs',
                        callback: (args) {
                          //print(args);
                          // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                        });
                  },
                )),
          ),
        ));
  }

  Future<void> getUrl() async {
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }

    var usrId = await userData().getUserId();
    var mob = await userData().getMobileNo();
    var apiKey = await userData().getApiKey;
    setState(() {
      _url = Urls.complaintRegistration +
          "?" +
          "UserID=" +
          "$usrId" +
          "&" +
          "Mobile=" +
          "$mob" +
          "&" +
          "api_key=" +
          "$apiKey";
      //"UserID"=user.getUserId()} & "Mobile"=&api_key=await userData().getApiKey};
    });
  }
}
