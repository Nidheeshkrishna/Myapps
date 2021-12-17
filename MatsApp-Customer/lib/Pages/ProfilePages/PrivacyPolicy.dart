import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final feedBackformKey = GlobalKey<FormState>();
  var _url;
  // final _key = UniqueKey();

  // final GlobalKey webViewKey = GlobalKey();
  // @override
  void initState() {
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

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
      title: Text("Privacy and Policy",
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
                  initialUrlRequest:
                      URLRequest(url: Uri.parse(Urls.privacyPolicyurl)),
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
}
