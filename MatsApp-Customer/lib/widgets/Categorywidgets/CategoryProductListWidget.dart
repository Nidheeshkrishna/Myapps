import 'package:flutter/material.dart';

class CategoryProductListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Container(
                      //height: screenHeight * .90,
                      //width: screenWidth,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: dummyData.length,
                        //ßphysics: ScrollPhysics(),
                        primary: true,
                        //physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:
                              MediaQuery.of(context).size.height / 800,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              elevation: 5,
                              //clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    dummyData[index]["image_url"],
                                    fit: BoxFit.contain,
                                    width: 120,
                                    height: 120,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(dummyData[index]["Name"]),
                                        Container(
                                          width: 60,
                                          height: 20,
                                          child: OutlineButton(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  new Text(
                                                    "4.0",
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 12,
                                                    color: Colors.orange[400],
                                                  )
                                                ],
                                              ),
                                              onPressed: () {},
                                              borderSide: BorderSide(
                                                  color: Colors.orange[400]),
                                              shape: new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          8.0))),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text("Rs 1200/",
                                            style: TextStyle(
                                                decoration: TextDecoration
                                                    .lineThrough)),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text("Rs 800/"),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 10,
                                          ),
                                          Text(
                                            "3Km Away",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        //width: MediaQuery.of(context).size.width *
                                        //.30,
                                        //height: MediaQuery.of(context).size.height * .10,
                                        //height: 30,
                                        child: Card(
                                            color: Colors.orange[400],
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text("Save 20%"),
                                            )),
                                      ))
                                ],
                              ));
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  final List<Map<String, Object>> dummyData = [
    {
      'id': '1',
      'Name': 'JBL Box Media',
      'image_url': 'assets/images/jblsp.png',
    },
    {
      'id': '2',
      'Name': 'Watch',
      'image_url': 'assets/images/applewatch.jpg',
    },
    {
      'id': '3',
      'Name': 'Combo Offer',
      'image_url': 'assets/PRODUCT/BluetoothSpeaker.jpeg'
    },
    {
      'id': '4',
      'Name': 'Sony Cybershot',
      'image_url': 'assets/images/sonycybershot.jpeg'
    },
    {'id': '5', 'Name': 'Watch', 'image_url': 'assets/images/mangobake.jpg'},
    {'id': '6', 'Name': 'Watch', 'image_url': 'assets/images/R-c.jpg'},
    {
      'id': '7',
      'Name': 'Headset',
      'image_url': 'assets/PRODUCT/headphones.jpeg'
    },
    {
      'id': '8',
      'Name': 'Oven',
      'image_url': 'assets/images/microvWaveOven.jpg'
    },
    {'id': '9', 'Name': 'Watch', 'image_url': 'assets/PRODUCT/watch.jpeg'},
  ];
}
