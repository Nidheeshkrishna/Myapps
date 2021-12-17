import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matsapp/Modeles/coupon_generate/voucher_model.dart';
import 'package:matsapp/utilities/DetailesDialog.dart';

class VoucherListItem extends StatelessWidget {
  final VoucherModel voucher;
  final bool hasRightBorder;

  const VoucherListItem({Key key, this.voucher, this.hasRightBorder = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6)
                ]),
            child: IntrinsicHeight(
              child: Row(children: <Widget>[
                if (hasRightBorder)
                  Container(
                      width: 4,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              transform: GradientRotation(270),
                              tileMode: TileMode.clamp,
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                            const Color(0xffa34200),
                            const Color(0xffb37d0c),
                            const Color(0xffffb517),
                            const Color(0xffac4700),
                            const Color(0xff7c3302)
                          ]))),
                // SizedBox(width: 10),
                Flexible(flex: 4, child: _VoucherDetails(voucher: voucher)),
                Flexible(flex: 3, child: _VoucherProduct(voucher: voucher)),
              ]),
            )));
  }
}

class _VoucherDetails extends StatelessWidget {
  final VoucherModel voucher;

  const _VoucherDetails({Key key, this.voucher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Shader goldenGradientText = LinearGradient(
      colors: <Color>[
        const Color(0xffa34200),
        const Color(0xffb37d0c),
        const Color(0xffffb517),
        const Color(0xffac4700),
        const Color(0xff7c3302)
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text('${voucher?.name}'),
              Text('${voucher.businessName}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color(0xff707070),
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.w700,
                  )),
              SizedBox(height: 12),
              Text(
                'VOUCHER',
                // '${voucher.name}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.84,
                  foreground: Paint()..shader = goldenGradientText,
                ),
              ),
              // SizedBox(height: 2),
              // Text(
              //   'Rs ${AppNumberFormat(voucher?.voucherValue).currency}',
              //   style: TextStyle(
              //     fontSize: 15,
              //     letterSpacing: 1.44,
              //     fontWeight: FontWeight.w700,
              //     foreground: Paint()..shader = goldenGradientText,
              //   ),
              //   textAlign: TextAlign.left,
              // ),
              SizedBox(height: 12),
              Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xff6d6b6b),
                      letterSpacing: 0.48,
                      height: 1.25,
                    ),
                    children: [
                      TextSpan(
                        text: 'Valid till ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                          text: '${voucher.expiryDate}',
                          style: TextStyle(fontWeight: FontWeight.w400))
                    ],
                  ),
                  textAlign: TextAlign.center),
              SizedBox(height: 6),
              InkWell(
                child: Row(
                  children: [
                    Container(
                        // alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xff707070),
                          border: Border.all(
                              width: 1.0, color: const Color(0xff707070)),
                        ),
                        child: Text('Details',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              letterSpacing: 0.93,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center)),
                  ],
                ),
                onTap: () {
                  Dialoges().detaiesDialogSuccess(context, voucher?.tc);
                },
              )
            ]));
  }
}

class _VoucherProduct extends StatelessWidget {
  final VoucherModel voucher;

  const _VoucherProduct({Key key, this.voucher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        padding: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: voucher.logoUrl.length > 0
                    ? Image.network(
                        voucher.logoUrl,
                        height: 80,
                        width: 80,
                        fit: BoxFit.fill,
                      )
                    : Container(
                        height: 80,
                        width: 80,
                      ),
              ),
              Wrap(
                children: [
                  Text(
                    voucher?.name ?? "",
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xff6d6b6b),
                      letterSpacing: 0.42,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ]));
  }
}
