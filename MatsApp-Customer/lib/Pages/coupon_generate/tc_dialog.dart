import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsConditionView extends StatelessWidget {
  final String termsConditions;

  const TermsConditionView({Key key, this.termsConditions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Html(
        data: termsConditions,
      )),
    );
  }
}
