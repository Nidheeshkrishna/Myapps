import 'package:flutter/material.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:shimmer/shimmer.dart';

class LoaderWidget4 extends StatefulWidget {
  final String caption;

  LoaderWidget4(this.caption);

  @override
  _LoaderWidget4State createState() => _LoaderWidget4State();
}

class _LoaderWidget4State extends State<LoaderWidget4> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.caption.length > 0
              ? Container(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                    widget.caption,
                    style: AppTextStyle.homeCatsFont(),
                  ),
                )
              : Container(),
          GridView.builder(
              itemCount: 4,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1.25,
                mainAxisSpacing: 5,
                crossAxisSpacing: 3,
                crossAxisCount: 2,
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
                          ),
                          baseColor: Colors.grey[200],
                          highlightColor: Colors.white),
                    ));
              }),
        ],
      ),
    );
  }
}
