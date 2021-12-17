import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_vectors.dart';

class EmptyView extends StatelessWidget {
  final String title;
  final String caption;
  final String message;

  const EmptyView({
    Key key,
    this.message = 'You don\'t have any notification',
    this.title = 'No notification',
    this.caption = 'Info !',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final TextStyle theme = Theme.of(context).textTheme.bodyText2;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          AppVectors.empty_svg,
        ),
        const SizedBox(height: 8.0),
        Text(
          caption,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.kAccentColor,
            letterSpacing: 0.4,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: AppColors.lightGreyWhite,
            letterSpacing: 0.24,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.0),
        Text(
          message,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.kAccentColor,
            height: 3.111111111111111,
          ),
          textHeightBehavior:
              TextHeightBehavior(applyHeightToFirstAscent: false),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
