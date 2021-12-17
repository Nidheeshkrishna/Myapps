import 'package:flutter/cupertino.dart';

import 'package:matsapp/Pages/CategoryPages/CategoryPage.dart';
import 'package:matsapp/Pages/HomePages/splashScreenpage.dart';
import 'package:matsapp/Pages/SignUp/oldsignup/SignUpPage1.dart';
import 'package:matsapp/Pages/SignUp/SignUpPage2.dart';
import 'package:matsapp/Pages/explore/explore_page.dart';

import 'package:matsapp/Pages/ForgotPassword/ForgotPassWordPage.dart';

import 'package:matsapp/Pages/HomePages/MainHomePage.dart';

import 'package:matsapp/Pages/SignUp/OtpAndPasswordPage.dart';
import 'package:matsapp/Pages/ProductINAreaPage.dart';
import 'package:matsapp/Pages/RenewPassword.dart';
import 'package:matsapp/Pages/feedBack.dart';

import 'package:matsapp/Pages/find/find_page.dart';

import 'package:matsapp/Pages/my_coupons/bill_amount_page.dart';
import 'package:matsapp/Pages/my_coupons/my_coupons_page.dart';
import 'package:matsapp/Pages/my_coupons/vouchers/bill_amount_page_Voucher.dart';
import 'package:matsapp/Pages/notifications/notifications_page.dart';
import 'package:matsapp/Pages/referrals/claim.dart';
import 'package:matsapp/Pages/referrals/claim_Selection.dart';
import 'package:matsapp/Pages/referrals/referral_page.dart';

import 'package:matsapp/widgets/HomeWidgets/MainHomePageBottambar1.dart';

class AppRoutes {
  Map<String, Widget Function(BuildContext)> get route => {
        // When navigating to the "/" route, build the FirstScreen widget.
        // '/': (context) => MainHomePage(),
        '/': (context) => SplashScreenpage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/homepage': (context) => MainHomePage(),
        //'/login': (context) => LoginPage(),
        '/signUp1': (context) => SignUpPage1(),
        '/signUp2': (context) => SignUpPage2(),
        '/categorypage': (context) => CategoryPage(),
        //'/chooseyourlocation': (context) => ChooseYourLocation(),
        '/otppage': (context) =>
            OtpAndPasswordPage(ModalRoute.of(context).settings.arguments),
        // '/passwordsettingpage': (context) =>
        //     PasswordSettingPage(ModalRoute.of(context).settings.arguments),
        '/renewpassword': (context) => RenewPassword(),
        '/productinarea': (context) => ProductINAreaPage(),
        //'/storsinyourarea': (context) => StorsInyourArea(),
        '/mainHomepagebottambar1': (context) => MainHomePageBottambar1(),
        //'/allcategoriespage': (context) => AllCategoriesPage(),
        '/forgotpasswordpage': (context) => ForgotPassWordPage(),
        // '/storepageproduction': (context) =>            StorePageProduction(ModalRoute.of(context).settings.arguments),
        '/mycouponspage': (context) => MyCouponsPage(),
        '/refer': (context) => ReferralPage(),
        '/mycouponspage/redeem': (context) => BillAmountPage(),
        '/mycouponspage/redeem/Voucher': (context) => BillAmountPageVoucher(),

        //'/mycouponspage/redeem': (context) => BillAmountPage(),

        //"/googlelocationpage": (context) => GooglelocationPage(),
        "/notification": (context) => NotificationsPage(),
        "/find": (context) => FindPage(),
        "/explore": (context) => ExplorePage(),
        '/claim': (context) => ClaimPage(),
        '/feedBack': (context) => FeedBackPage(),
        '/claimSelection': (context) => ClaimSelectionPage(),
        //"/storeproductpage": (context) => StoreProductPage(),
        // '/scan_qr':(context)=>QRScannerPage(),
      };
}
