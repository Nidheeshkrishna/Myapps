import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';
import 'package:matsapp/constants/app_vectors.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainHomePage()));
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text("Explore", textAlign: TextAlign.center),
            leading: InkWell(
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainHomePage()));
              },
            ),
          ),
          body: Builder(builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: ListView(
                children: [
                  // ExploreMenuItem(
                  //   title: "Find",
                  //   onTap: () {
                  //     Navigator.pushNamed(context, "/find");
                  //   },
                  //   icon: AppVectors.explore_find_icon,
                  // ),
                  // ExploreMenuItem(
                  //   title: "Recycle",
                  //   onTap: () {},
                  //   icon: AppVectors.explore_recycle_icon,
                  // ),
                  ExploreMenuItem(
                    title: "Info Service",
                    onTap: () {},
                    icon: AppVectors.explore_service_icon,
                  ),
                  ExploreMenuItem(
                    title: "All In One E-com",
                    onTap: () {},
                    icon: AppVectors.explore_ecom_icon,
                  ),
                ],
              ),
            );
          })),
    );
  }
}

class ExploreMenuItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String subTitle;
  final String icon;

  const ExploreMenuItem({
    Key key,
    @required this.onTap,
    @required this.title,
    this.subTitle,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0),
          gradient: LinearGradient(
            begin: Alignment(0.0, 0.99),
            end: Alignment(0.0, -0.99),
            colors: [
              const Color(0xffffb517),
              const Color(0xffffb517),
              const Color(0xffffae00)
            ],
            stops: [0.0, 0.468, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$title',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        color: const Color(0xffffffff),
                        letterSpacing: 0.36,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${subTitle ?? ""}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        color: const Color(0xffffffff),
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
              SizedBox(width: 16),
              SvgPicture.asset(
                icon,
                width: 80,
                height: 75,
              )
            ],
          ),
        ),
      ),
    );
  }
}
