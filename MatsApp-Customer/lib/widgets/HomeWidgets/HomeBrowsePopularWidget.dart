
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matsapp/Pages/CategoryPages/CategoryAllpage.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/widgets/Categorywidgets/GetStorebyCategory.dart';

class HomeBrowsePopularWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;

    // double screenheight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 13.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Browse Popular",
                style: AppTextStyle.homeCatsFont(),
              ),
              TextButton(
                // style: ElevatedButton.styleFrom(
                //     primary: Colors.white,
                //     elevation: 10,
                //     onPrimary: Colors.blue,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(7.0),
                //     )),
                child: Row(
                  children: [
                    Text("View All ", style: AppTextStyle.homeViewAllFont()),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.kSecondaryDarkColor,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryAllpage()));
                },
              )
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: dummyData.length,
          physics: ScrollPhysics(),
          //physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: MediaQuery.of(context).size.height / 600,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: InkWell(
                child: Column(
                  children: [
                    Card(
                      shape: (RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      elevation: 2,

                      //clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: SvgPicture.asset(
                          dummyData[index]["image_url"],
                          // width: 80,
                          height: 45,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(dummyData[index]["title"])
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetStorebyCategory(
                            dummyData[index]["id"], dummyData[index]["title"]),
                      ));
                },
              ),
            );
          },
        ),
      ],
    );
  }

  final List<Map<String, Object>> dummyData = [
    {
      'id': 10,
      'image_url': 'assets/CategoryImages/fashion.svg',
      'title': "Fashions",
      "product": "Microwave Oven"
    },
    {
      'id': 25,
      'image_url': 'assets/CategoryImages/Electronics.svg',
      'title': "Electronics",
      "product": "Watches"
    },
    {
      'id': 13,
      'image_url': 'assets/CategoryImages/HomeApplainces.svg',
      'title': "Home Appliance",
      "product": "Bluetooh Speaker"
    },
    {
      'id': 4,
      'image_url': 'assets/vectors/supermarket.svg',
      'title': "Super Market",
      "product": "Super Market"
    },
    {
      'id': 36,
      'image_url': 'assets/CategoryImages/saloon_spa.svg',
      'title': "Beauty & Spa",
      "product": "Fasion"
    },
    {
      'id': 18,
      'image_url': 'assets/CategoryImages/Food&Dining.svg',
      'title': "Food&Dining",
      "product": "Fasion"
    },
  ];
}
