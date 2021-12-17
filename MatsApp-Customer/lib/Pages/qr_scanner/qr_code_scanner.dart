import 'dart:io';

import 'package:flutter/material.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanner extends StatelessWidget {
  final Function(String) onResult;

  QRCodeScanner({
    Key key,
    this.onResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyWhite.withOpacity(0.9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: _ScannerWidget(
            onResult: onResult,
          )),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0),
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
            child: Text(
              'SCAN CODE',
              style: TextStyle(
                fontSize: 18,
                color: const Color(0xffffffff),
                letterSpacing: 1.71,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26.0),
                border: Border.all(width: 1.0, color: const Color(0xffffffff)),
              ),
              child: Text(
                'Cancel Scanning',
                style: TextStyle(
                  fontSize: 18,
                  color: const Color(0xffffffff),
                  letterSpacing: 1.71,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScannerWidget extends StatefulWidget {
  final Function(String) onResult;

  const _ScannerWidget({Key key, this.onResult}) : super(key: key);

  @override
  __ScannerWidgetState createState() => __ScannerWidgetState();
}

class __ScannerWidgetState extends State<_ScannerWidget> {
  GlobalKey qrKey;
  QRViewController controller;
  bool isScanned;

  @override
  void initState() {
    super.initState();
    qrKey = GlobalKey();
    isScanned = false;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.flash_on,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (controller != null) {
                      controller.toggleFlash();
                    }
                  }),
              IconButton(
                  icon: Icon(
                    Icons.flip_camera_android_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (controller != null) {
                      controller.flipCamera();
                    }
                  }),
            ],
          ),
        ),
        Expanded(
          child: QRView(
            key: qrKey,
            onQRViewCreated: onControllerCreated,
            overlay: QrScannerOverlayShape(
                borderColor: AppColors.kPrimaryColor,
                borderRadius: 8,
                borderLength: 20,
                borderWidth: 8,
                cutOutSize: scanArea),
          ),
        ),
      ],
    );
  }

  void onControllerCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null && !isScanned) {
        widget.onResult(scanData.code);
        setState(() {
          isScanned = true;
        });
      }
    });
  }

  @override
  void dispose() {
    if (controller != null) {
      controller.dispose();
    }
    super.dispose();
  }
}
