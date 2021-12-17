import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/GetSuggestionsModel.dart';

import 'package:matsapp/Network/GetSuggestionsRepo.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';
import 'package:matsapp/Pages/Providers/ConnectivityServices.dart';

import 'package:matsapp/Pages/Search/searchResultPage.dart';
import 'package:matsapp/Pages/Search/searchTop9Stores.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:provider/provider.dart';

class SearchMainPage extends StatefulWidget {
  @override
  _SearchMainPageState createState() => _SearchMainPageState();
}

class _SearchMainPageState extends State<SearchMainPage> {
  var selected_state;
  TextEditingController keyNameController = TextEditingController();

  // List<String> _states = ['Kerala'];
  StreamController<GetSuggestionsModel> _userController;
  double userLatitude;

  double userLogitude;

  var connectionStatus;

  bool networkStatus = false;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _userController = new StreamController();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top;

    connectionStatus = Provider.of<ConnectivityStatus>(context);
    checkNetwork();

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Search",
            style: TextStyle(fontSize: 17, color: Colors.black),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainHomePage()),
                  );
                },
                //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          )),
      body: WillPopScope(
        onWillPop: () {
          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainHomePage()),
          );
        },
        child: Container(
            child: SingleChildScrollView(
                child: networkStatus
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, top: 25, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("What are you looking for?",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.heightMultiplier * 3.2,
                                        color: kAccentColor,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth * .92,
                            height: screenHeight * .075,
                            //padding: EdgeInsets.only(bottom: 5, left: .75, right: .75),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.kPrimaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x12000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                  textInputAction: TextInputAction.search,
                                  onChanged: (_) {
                                    loadDetails(keyNameController.text);
                                    //fetchSuggestions(keyNameController.text);
                                  },
                                  onFieldSubmitted: (_) {
                                    if (keyNameController.text
                                        .toString()
                                        .isNotEmpty) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                searchResultPage(
                                                    userLatitude,
                                                    userLogitude,
                                                    keyNameController.text ??
                                                        "".toString())),
                                      );
                                    } else {
                                      GeneralTools().createSnackBarCommon(
                                          "Enter a Keyword", context);
                                    }
                                  },
                                  textAlign: TextAlign.center,
                                  controller: keyNameController,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                      letterSpacing: 1),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:
                                        'Stores, Offers, Discounts, Coupons ',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300),
                                    isDense: true,
                                    suffixIcon: IconButton(
                                      padding: EdgeInsets.only(top: 0),
                                      icon: Icon(
                                        Icons.search,
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        // if (keyNameController.text
                                        //     .toString()
                                        //     .isNotEmpty) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  searchResultPage(
                                                      userLatitude,
                                                      userLogitude,
                                                      keyNameController.text
                                                              .toString() ??
                                                          "")),
                                        );
                                        // } else {
                                        //   GeneralTools().createSnackBarCommon(
                                        //       "Enter a Keyword", context);
                                        // }
                                      },
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 3,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Text("Location"),
                          //     Container(
                          //       width: screenWidth * .50,
                          //       //height: 100,
                          //       child: Card(
                          //           shadowColor: Colors.orange,
                          //           elevation: 5,
                          //           clipBehavior: Clip.hardEdge,
                          //           shape: RoundedRectangleBorder(
                          //             side: BorderSide(
                          //               color: Colors.white70,
                          //             ),
                          //             borderRadius: BorderRadius.circular(8),
                          //           ),
                          //           child: DropdownButtonFormField(
                          //             validator: (value) {
                          //               if (value == null) {
                          //                 return 'Location is required';
                          //               }
                          //               return null;
                          //             },
                          //             value: selected_state,
                          //             hint: Text("Location"),
                          //             decoration: InputDecoration(
                          //               alignLabelWithHint: true,
                          //               contentPadding: EdgeInsets.only(right: 8, left: 8),
                          //               enabledBorder: UnderlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                     color: Colors.orange[400], width: 10),
                          //                 //  when the TextFormField in focused
                          //               ),
                          //               focusedBorder: UnderlineInputBorder(
                          //                 borderSide:
                          //                     BorderSide(color: Colors.orange, width: 12),
                          //                 //  when the TextFormField in focused
                          //               ),
                          //             ),
                          //             items:
                          //                 _states.map<DropdownMenuItem<String>>((var value) {
                          //               return DropdownMenuItem<String>(
                          //                 value: value,
                          //                 child: Text(value),
                          //               );
                          //             }).toList(),
                          //             onChanged: (value) {
                          //               setState(() {
                          //                 selected_state = value;
                          //                 //_chosenValue_Town = null;
                          //               });
                          //             },
                          //           )
                          //           // } else {
                          //           //   return Container();
                          //           // }

                          //           ),
                          //     ),
                          //   ],
                          // ),

                          Column(
                            children: [
                              StreamBuilder<GetSuggestionsModel>(
                                  stream: _userController.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data.result.length > 0) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Row(
                                                children: [
                                                  Text("Search Suggestions",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blueGrey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14))
                                                ],
                                              ),
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data.result.length,
                                                physics: ScrollPhysics(),
                                                //physics: NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return ListTile(
                                                    onTap: () {
                                                      keyNameController.text =
                                                          snapshot.data
                                                              .result[index];
                                                    },
                                                    leading: Icon(
                                                      Icons.access_time,
                                                      color: Colors.blue,
                                                    ),
                                                    title: Text(
                                                      snapshot
                                                          .data.result[index],
                                                      textScaleFactor: .8,
                                                    ),
                                                    //trailing: Icon(Icons.close),
                                                  );
                                                }),
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                    } else {
                                      return Container();
                                    }
                                  }),
                            ],
                          ),
                          searchTop9Stores(),
                        ],
                      )
                    : OfflineWidget(context))),
      ),
    );
  }

  _getCurrentLocation() {
    //fetchdata();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      if (mounted) {
        setState(() {
          //_currentPosition = position;
          userLatitude = position.latitude;
          userLogitude = position.longitude;
        });
      }

      print('${position.latitude}');
      print('${position.longitude}');
      // print(' ${position.}');
    }).catchError((e) {
      print(e);
    });
  }

  loadDetails(String keyword) async {
    fetchSuggestions(keyNameController.text).then((res) async {
      //print('LoadDetails of ${res.fname}');
      if (res != null) {
        _userController.add(res);
      }

      return res;
    });
  }

  Widget OfflineWidget(context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height - kToolbarHeight;
    return Center(
      child: Container(
        width: screenwidth * .60,
        height: screenhight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              color: AppColors.kAccentColor,
              size: 100,
            ),
            Text("You Are Offline",
                style: TextStyle(
                    color: AppColors.kAccentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }

  checkNetwork() {
    connectionStatus == ConnectivityStatus.Cellular ||
            connectionStatus == ConnectivityStatus.WiFi
        ? networkStatus = true
        : networkStatus = false;
  }
}
