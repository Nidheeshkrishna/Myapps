import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matsapp/Pages/CategoryPages/CategoryAllpage.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/widgets/Categorywidgets/GetStorebyCategory.dart';

class HomepagCatogoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //double screenwidth = MediaQuery.of(context).size.width;
    // double screenhight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        //height: MediaQuery.of(context).size.height * .40,
        //width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Categories",
                          style: AppTextStyle.homeCatsFont()),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                ConstrainedBox(
                  constraints: new BoxConstraints(
                    minHeight: 25.0,
                    maxHeight: 110.0,
                  ),
                  //color: Colors.deepPurpleAccent,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: dummyData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Container(
                            width: 80,
                            child: Column(
                              children: [
                                Card(
                                  shape: CircleBorder(),
                                  //clipBehavior: Clip.antiAlias,
                                  elevation: 3.0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 30,
                                    child: SvgPicture.asset(
                                        dummyData[index]["image_url"],
                                        width: 0,
                                        height: 50),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(dummyData[index]["title"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ))),
                              ],
                            ),
                          ),
                          onTap: () {
                            if (index == 5) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryAllpage()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GetStorebyCategory(
                                        dummyData[index]["id"],
                                        dummyData[index]["title"]),
                                  ));
                            }
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
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
      'id': 36,
      'image_url': 'assets/CategoryImages/saloon_spa.svg',
      'title': "Beauty & Spa",
      "product": "Fasion"
    },
    {
      'id': 18,
      'image_url': 'assets/CategoryImages/Food&Dining.svg',
      'title': "Food Dining",
      "product": "Fasion"
    },
    {
      'id': 6,
      'image_url': 'assets/vectors/ic_viewall.svg',
      'title': "All",
      "product": "Fasion"
    },
  ];
}
