import 'dart:io' show Platform;

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';

class VisitLocation extends StatefulWidget {
  final double toLatitude;
  final double toLogitude;
  final String fromLatitude;
  final String fromLogitude;
  final String businessname;
  VisitLocation(this.toLatitude, this.toLogitude, this.fromLatitude,
      this.fromLogitude, this.businessname,
      {Key key})
      : super(key: key);

  @override
  _visitLocationState createState() => _visitLocationState();
}

class _visitLocationState extends State<VisitLocation> {
  
  var fromlat;

  @override
  Widget build(BuildContext context) {
    String _url = "https://www.google.com/maps/dir/?api=1&destination=";
    final _key = UniqueKey();
    double srcwidth = MediaQuery.of(context).size.width;
    double srcHeight = MediaQuery.of(context).size.height;
    AppBar appbar = AppBar(
      backgroundColor: Colors.white,
      title: Text(widget.businessname,
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
        body: Container(
            width: srcwidth,
            height: srcHeight,
            child: WebView(
                key: _key,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: _url +
                    "${widget.fromLatitude},${widget.fromLogitude}/${widget.toLatitude},${widget.toLogitude}")));
  }

  void generateUrl() async {
    String destination ;

    String origin ;
    setState(() {
     destination = "${widget.toLatitude},${widget.toLogitude}";

   origin = "${widget.fromLatitude},${widget.fromLogitude}";
      
    });
    if (Platform.isAndroid) {
      final AndroidIntent intent = new AndroidIntent(
          action: 'action_view',
          data: Uri.encodeFull(
              "https://www.google.com/maps/dir/?api=1&origin=" +
                  "${widget.fromLatitude},${widget.fromLogitude}" +
                  "&destination=" +
                  "${widget.toLatitude},${widget.toLogitude}" +
                  "&travelmode=driving&dir_action=navigate"),
          package: 'com.google.android.apps.maps');
      intent.launch();
    } else {
      String url = "https://www.google.com/maps/dir/?api=1&origin=" +
          origin +
          "&destination=" +
          destination +
          "&travelmode=driving&dir_action=navigate";
      if (await canLaunch(url) != null) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
