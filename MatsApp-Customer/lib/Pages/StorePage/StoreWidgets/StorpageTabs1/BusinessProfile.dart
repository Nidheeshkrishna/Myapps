import 'package:flutter/material.dart';
import 'package:matsapp/constants/app_colors.dart';

class BusinessProfile extends StatefulWidget {
  final String businessDiscription;
  const BusinessProfile(this.businessDiscription, {Key key}) : super(key: key);

  @override
  _BusinessProfileState createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * .90,
        //height: MediaQuery.of(context).size.height * .30,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                child: Wrap(
                  children: [
                    Text(
                      widget.businessDiscription,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: .1,
                          wordSpacing: .3,
                          color: AppColors.kSecondaryDarkColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
