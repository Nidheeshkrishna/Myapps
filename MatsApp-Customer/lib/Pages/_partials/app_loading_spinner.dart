import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matsapp/constants/app_style.dart';

class AppLoadingSpinner extends StatelessWidget {
  const AppLoadingSpinner({Key key, this.color, this.size})
      : value = null,
        super(key: key);

  const AppLoadingSpinner.withValue(
      {Key key, this.color, this.size, this.value})
      : super(key: key);

  final Color color;
  final double size;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: value != null
          ? CircularProgressIndicator(
              value: value,
              backgroundColor: color ?? kPrimaryColor,
              semanticsValue: '$value',
              semanticsLabel: '$value',
            )
          : SpinKitHourGlass(
              color: color ?? kPrimaryColor,
              size: size ?? 32.0,
            ),
    );
  }

  // Widget _box(Color color) {
  //   return DecoratedBox(
  //     decoration: BoxDecoration(color: color),
  //   );
  // }
}
