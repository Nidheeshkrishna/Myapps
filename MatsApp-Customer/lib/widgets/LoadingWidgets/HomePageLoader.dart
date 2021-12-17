import 'package:flutter/material.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:shimmer/shimmer.dart';

class HomePageLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.white70,
        highlightColor: Colors.grey[300],
        direction: ShimmerDirection.ltr,
        child: Container(
          color: Colors.blueAccent,
          width: SizeConfig.screenwidth * 95,
          height: SizeConfig.screenheight,
        ));
  }
}
