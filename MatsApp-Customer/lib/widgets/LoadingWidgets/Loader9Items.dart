import 'package:flutter/material.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:shimmer/shimmer.dart';

class LoaderWidget9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 9,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 1,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                child: Shimmer.fromColors(
                    enabled: true,
                    child: Container(
                      color: Colors.white,
                      width: SizeConfig.widthMultiplier * 25,
                      height: SizeConfig.widthMultiplier * 25,
                    ),
                    baseColor: Colors.grey[200],
                    highlightColor: Colors.white),
              ));
        });
  }
}
