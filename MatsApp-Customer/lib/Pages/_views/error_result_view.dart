import 'package:flutter/material.dart';
import 'package:matsapp/constants/app_style.dart';

class ErrorResultView extends StatelessWidget {
  const ErrorResultView({
    Key key,
    this.message = "Error occured",
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error_outline,
            color: kPrimaryColor,
            size: 50.0,
          ),
          const SizedBox(height: 16.0),
          Text(
            message,
          )
        ],
      ),
    );
  }
}
