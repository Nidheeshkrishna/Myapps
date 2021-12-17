import 'package:flutter/material.dart';
import 'package:matsapp/constants/app_style.dart';

class EmptyResultView extends StatelessWidget {
  const EmptyResultView({
    Key key,
    this.message = "No results",
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    final TextStyle theme = Theme.of(context).textTheme.bodyText2;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.equalizer,
          color: kPrimaryColor,
          size: 48.0,
        ),
        const SizedBox(height: 8.0),
        Text(
          message,
          style: theme,
        )
      ],
    );
  }
}
