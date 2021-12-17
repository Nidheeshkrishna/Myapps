import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matsapp/Pages/Login/LoginPage.dart';
import 'package:matsapp/Pages/LuckyDraw/luckyDrawPage.dart';
import 'package:matsapp/Pages/ProfilePages/PrivacyPolicy.dart';
import 'package:matsapp/Pages/ProfilePages/helpAndGuide.dart';
import 'package:matsapp/Pages/UpgradeToPremium/SubscribePremium.dart';
import 'package:matsapp/Pages/WishList/MyWishlistPage.dart';
import 'package:matsapp/Pages/feedBack.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  final String userType;
  final bool premiumUser;
  DrawerWidget(this.userType, this.premiumUser);
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String userType;
  bool premiumUser;
  DatabaseHelper dbHelper = new DatabaseHelper();
  @override
  void initState() {
    userType = widget.userType;
    premiumUser = widget.premiumUser;
    print(userType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height;
    WidgetsFlutterBinding.ensureInitialized();
    return Drawer(
      child: Container(
        height: SizeConfig.heightMultiplier * 100,
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  title: Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(right: 10, top: 10, bottom: 10),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: SizeConfig.heightMultiplier * 10,
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Text(
                        'Hi, User',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width * .30,
                  height: MediaQuery.of(context).size.height * .10,
                  child: Card(
                    elevation: 1,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    // borderOnForeground: true,
                    //shadowColor: Colors.orange[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(width: 1, color: Colors.orange[300])),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 0, left: 0, right: 5),
                            child: Image.asset(
                              "assets/images/img_crown.png",
                              width: 35,
                              height: 35,
                            ),
                          ),
                          Text(
                            premiumUser
                                ? 'Premium Member'
                                : 'Upgrade To Premium',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 2),
                          // Align(
                          //   //heightFactor: .20,
                          //   widthFactor: .90,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(bottom: 15),
                          //     child: Image.asset(
                          //       "assets/images/img_crown.png",
                          //       width: 35,
                          //       height: 35,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubscribePremium()));
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: Row(children: [
                    SvgPicture.asset(
                      'assets/vectors/basket_icon.svg',
                      color: AppColors.kAccentColor,
                      height: 22,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'My Shoppings',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/mycouponspage");
                  },
                ),
                ListTile(
                  title: Row(children: [
                    Icon(
                      Icons.favorite,
                      color: AppColors.kAccentColor,
                      size: 26,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'My Wishlist',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyWishlistPage()),
                    );
                  },
                ),
                userType == "Merchant"
                    ? ListTile(
                        title: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/vectors/icon_rupee.svg',
                              height: 27,
                              color: AppColors.kPrimaryColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Refer & Earn',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.popAndPushNamed(context, "/refer");
                        },
                      )
                    : SizedBox(
                        height: 0,
                      ),
                ListTile(
                  title: Row(children: [
                    Icon(
                      Icons.help_outlined,
                      color: AppColors.kAccentColor,
                      size: 26,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Help & Guide',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ]),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HelpAndGuide()));
                  },
                ),
                // ListTile(
                //   title: Row(children: [
                //     Icon(
                //       Icons.feedback,
                //       color: AppColors.kAccentColor,
                //       size: 26,
                //     ),
                //     SizedBox(width: 10),
                //     Text(
                //       'FeedBack',
                //       style: TextStyle(
                //           color: Colors.black87,
                //           fontSize: 15,
                //           fontWeight: FontWeight.bold),
                //     )
                //   ]),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => FeedBackPage()),
                //     );
                //   },
                // ),

                ListTile(
                  title: Row(children: [
                    Image.asset(
                      'assets/images/luckydrowicon.png',
                      height: SizeConfig.heightMultiplier * 5,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Lucky Draw',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LuckyDrawPage()),
                    );
                  },
                ),
                ListTile(
                  title: Row(children: [
                    Icon(
                      Icons.logout,
                      color: AppColors.kAccentColor,
                      size: 26,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ]),
                  onTap: () async {
                    GeneralTools().logOut(context);
                    dbHelper.deleteUser();
                    // SharedPreferences preferences =
                    //     await SharedPreferences.getInstance();
                    // await preferences.clear();
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                  },
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 12, left: 10),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Powered by',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 5),
                        Image.asset(
                          'assets/images/logo_ociuz.png',
                          height: SizeConfig.heightMultiplier * 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
