import 'package:flutter/material.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:photo_view/photo_view.dart';

class ImageZommPage extends StatefulWidget {
  final String imgUrl;
  final String imgName;
  ImageZommPage(this.imgUrl, this.imgName);

  @override
  _ImageZommPageState createState() => _ImageZommPageState();
}

class _ImageZommPageState extends State<ImageZommPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kAccentColor,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            widget.imgName,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ),
      body: Center(
          child: PhotoView(
        imageProvider: NetworkImage(widget.imgUrl),
      )),
    );
  }
}
