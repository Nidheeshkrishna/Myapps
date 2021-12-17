import 'package:flutter/material.dart';

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matsapp/Pages/Login/Login_Location.dart';

class GooglelocationPage extends StatefulWidget {
  final double latitude;
  final double logitude;
  final String businessname;
  GooglelocationPage(this.latitude, this.logitude, this.businessname);

  @override
  State<GooglelocationPage> createState() => GooglelocationPageState();
}

class GooglelocationPageState extends State<GooglelocationPage> {
  static double lat;
  static double log;
  @override
  void initState() {
    super.initState();

    setState(() {
      lat = widget.latitude;
      log = widget.logitude;
    });
    _goToTheLake();
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(lat, log),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 10.5276,
      target: LatLng(lat, log),
      tilt: 59.440717697143555,
      
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      backgroundColor: Colors.white,
      title: Text(widget.businessname,
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
          Navigator.pop(context);
        },
      ),
    );
    return new Scaffold(
      appBar: appbar,
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
