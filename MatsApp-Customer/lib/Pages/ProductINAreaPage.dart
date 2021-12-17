import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/ProductINAreaModel.dart';
import 'package:matsapp/Network/ProductINAreaRest.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';

import 'package:matsapp/widgets/Categorywidgets/CategoryWidgetAdd1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductINAreaPage extends StatefulWidget {
  @override
  _ProductINAreaPageState createState() => _ProductINAreaPageState();
}

class _ProductINAreaPageState extends State<ProductINAreaPage> {
  PageController _pageController;
  int _currentIndex = 0;
  Future FutureProductInArea;
  String appbarTitleString;
  ProductInAreaModel _productInAreaModel;

  Text appBarTitleText;

  int selectedIndex = 0;

  SharedPreferences prefs;

  String townSelectedStore;

  Position _currentPosition;

  double userLatitude;

  double userLogitude;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].location;
            FutureProductInArea = fetchTopProductInArea(
                userLatitude, userLogitude, townSelectedStore);
          }),

          // prefcheck(
          //     value[0].mobilenumber, value[0].location, value[0].apitoken),
          // // GeneralTools().prefsetLoginInfo(
          // //     ),
        });

    // .then((value) => _productInAreaModel = value.result);
  }

  @override
  Widget build(BuildContext context) {
    BottomNavigationBar bottamNavigationBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFFFCFCFC),
      selectedItemColor: Colors.orange[400],
      unselectedItemColor: Colors.black,
      currentIndex: _currentIndex,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(

            // ignore: deprecated_member_use
            title: Text('Home'),
            icon: ImageIcon(
              const AssetImage(
                'assets/images/home.png',
              ),
              size: 50,
              color: Colors.orange[400],
            )),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Explore'),
            icon: ImageIcon(
              const AssetImage(
                'assets/images/compass.png',
              ),
              size: 50,
              color: Colors.orange[400],
            )),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Search'),
            icon: ImageIcon(
              const AssetImage(
                'assets/images/search.png',
              ),
              size: 50,
              color: Colors.orange[400],
            )),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Profile'),
            icon: ImageIcon(
              const AssetImage(
                'assets/images/profile-user.png',
              ),
              size: 50,
              color: Colors.orange[400],
            )),
      ],
    );

    // List<Widget> tabPages = [
    //   HomePage(),
    //   ExplorePage(),
    //   //details_page(),
    // ];

    AppBar appbar = new AppBar(
      title: Text(
        "Top Products in your Area",
        style: TextStyle(fontSize: 17),
      ),
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.filter_list,
            color: Colors.black,
          ),
          onPressed: () {
            //Scaffold.of(context).openDrawer();
          },
        )
      ],
    );

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;

    return Scaffold(
      bottomNavigationBar: bottamNavigationBar,
      appBar: appbar,
      body: Container(
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Container(
                    width: screenWidth,
                    //height: 60,
                    child: Card(
                      shadowColor: Colors.orange,
                      borderOnForeground: true,
                      elevation: 5,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Align(
                        //alignment: Alignment.topCenter,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          //controller: userNameController,
                          decoration: const InputDecoration(
                            hintText: 'Search here...',
                            hintStyle: TextStyle(color: Colors.grey),
                            suffixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth,
                  height: screenHeight * .40,
                  child: CategoryWidgetAdd1(),
                ),
                Container(
                  //height: screenHeight * .90,
                  //width: screenWidth,
                  child: FutureBuilder<ProductInAreaModel>(
                      future: FutureProductInArea,
                      builder: (context,
                          AsyncSnapshot<ProductInAreaModel> snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.result.length,
                            physics: ScrollPhysics(),
                            primary: true,
                            //physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: CachedNetworkImage(
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              fit: BoxFit.contain,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              width: 120,
                                              height: 120,
                                              imageUrl: snapshot.data
                                                  .result[index].productImage,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  snapshot.data.result[index]
                                                      .productName,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Container(
                                                  width: 60,
                                                  height: 20,
                                                  child: TextButton(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          new Text(
                                                            "4.0",
                                                            style: TextStyle(
                                                                fontSize: 11),
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            size: 12,
                                                            color: Colors
                                                                .orange[400],
                                                          )
                                                        ],
                                                      ),
                                                      onPressed: () {},
                                                      style:
                                                          TextButton.styleFrom(
                                                        primary: Colors.teal,
                                                        side: BorderSide(
                                                            color: Colors.red,
                                                            width: 5),
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            //mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  "Rs ${snapshot.data.result[index].productPrice}/",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough))
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                    "Rs ${snapshot.data.result[index].matsSpclPrice}/"),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      size: 10,
                                                    ),
                                                    Text(
                                                      "${snapshot.data.result[index].distanceInKm}Km Away",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .30,
                                                height: 27,
                                                // MediaQuery.of(context).size.height *
                                                //.10,
                                                //height: 30,
                                                child: Card(
                                                    color: Colors.orange[400],
                                                    child: Center(
                                                        child: Text(
                                                            "Save ${snapshot.data.result[index].percentageSaved}%"))),
                                              ))
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.favorite_border,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                //Scaffold.of(context).openDrawer();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
                Container(
                  width: screenWidth,
                  height: screenHeight * .30,
                  child: CategoryWidgetAdd1(),
                ),
                Container(
                  //height: screenHeight * .90,
                  //width: screenWidth,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: dummyData.length,
                    physics: ScrollPhysics(),
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
                          child: Stack(
                            children: [
                              Column(
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
                                          // ignore: deprecated_member_use
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
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Rs 1200/",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                  ),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .40,
                                        height: 27,
                                        // MediaQuery.of(context).size.height *
                                        //.10,
                                        //height: 30,
                                        child: Card(
                                            color: Colors.orange[400],
                                            child: Center(
                                                child: Text("Save 20%"))),
                                      ))
                                ],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    //Scaffold.of(context).openDrawer();
                                  },
                                ),
                              ),
                            ],
                          ));
                    },
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
      'image_url': 'assets/images/bluetoothspeaker.png'
    },
    {
      'id': '4',
      'Name': 'Sony Cybershot',
      'image_url': 'assets/images/sonycybershot.jpeg'
    },
    {'id': '5', 'Name': 'Watch', 'image_url': 'assets/images/mangobake.jpg'},
    {
      'id': '6',
      'Name': 'Watch',
      'image_url': 'assets/images/sonycybershot.jpeg'
    },
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
  prefcheck() async {
    // ignore: invalid_use_of_visible_for_testing_member
    //SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    setState(() {
      townSelectedStore = prefs.getString('Selected_Town');
    });
    print("selected town @@@@@@@@@@@@@@@$townSelectedStore");
  }

  void onPageChanged(int page) {
    setState(() {
      this._currentIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  _getCurrentLocation() {
    //fetchdata();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        userLatitude = position.latitude;
        userLogitude = position.longitude;
      });

      print('${position.latitude}');
      print('${position.longitude}');
      // print(' ${position.}');
    }).catchError((e) {
      print(e);
    });
  }
}
