import 'package:flutter/material.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:shimmer/shimmer.dart';

class LoaderItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          child: Shimmer.fromColors(
              enabled: true,
              child: Container(
                color: Colors.white,
                width: SizeConfig.widthMultiplier * 90,
                height: SizeConfig.heightMultiplier * 25,
              ),
              baseColor: Colors.grey[200],
              highlightColor: Colors.white),
        ));
  }
}
