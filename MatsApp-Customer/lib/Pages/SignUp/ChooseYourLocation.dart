import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/ChangeLocation/DistictModel.dart';
import 'package:matsapp/Modeles/ChangeLocation/TownModel.dart';
import 'package:matsapp/Modeles/LocationModels/GetSubTownsModel.dart';
import 'package:matsapp/Network/DistricttModeRest.dart';
import 'package:matsapp/Network/GetSubtownsRepo.dart';
import 'package:matsapp/Network/TownMoidelRest.dart';
import 'package:matsapp/Pages/SignUp/PasswodSettingPage.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseYourLocation extends StatefulWidget {
  final String mobileNumberPassed;

  ChooseYourLocation(this.mobileNumberPassed);
  static var userNameController;

  @override
  _ChooseYourLocationState createState() => _ChooseYourLocationState();
}

class _ChooseYourLocationState extends State<ChooseYourLocation> {
  Position _currentPosition;
  String _currentAddress;
  // ignore: non_constant_identifier_names
  String chosenValue_Town;
  // ignore: non_constant_identifier_names
  String chosenValue_District;
  var currentTown;
  var selected_state;

  String selectedDistrict;
  // ignore: non_constant_identifier_names
  String selectedTown;
  //List data = List();
  DistrictModel districtModel;
  TownModel townModel;
  TextEditingController cityController = TextEditingController();

  TextEditingController townController = TextEditingController();
  TextEditingController citysearchController = TextEditingController();
  TextEditingController currentLocalityController = TextEditingController();

  TextEditingController townsearchController = TextEditingController();
  final _form = GlobalKey<FormState>();

  SharedPreferences prefs;

  Future townFuture, stateFuture, subtownsFuture;
  Future districtFuture;

  var chosenSubTown;

  var selectedSubTown;

  String locationName;

  @override
  void initState() {
    // getDistrict("Kerala").then((districtModel) => setState(() {
    //       districtModel = districtModel;
    //     }));

    super.initState();
  }

  @override
  void dispose() {
    townsearchController.clear();
    chosenValue_Town = null;
    chosenValue_District = null;
    currentLocalityController.clear();
    cityController.clear();
    townsearchController.clear();

    // prefs.clear();

    super.dispose();
  }

  List<String> _states = ['Kerala'];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Choose Location"),
      ),
      body: Center(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: Center(
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 10.0),
                  //       child: Container(
                  //         width: screenWidth * .90,
                  //         //height: 100,
                  //         child: Card(
                  //             shadowColor: Colors.orange,
                  //             elevation: 5,
                  //             clipBehavior: Clip.hardEdge,
                  //             shape: RoundedRectangleBorder(
                  //               side: BorderSide(
                  //                 color: Colors.white70,
                  //               ),
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //             child: DropdownButtonFormField(
                  //               validator: (value) {
                  //                 if (value == null) {
                  //                   return 'State is required';
                  //                 }
                  //                 return null;
                  //               },
                  //               value: selected_state,
                  //               hint: Text("--State--"),
                  //               decoration: InputDecoration(
                  //                 alignLabelWithHint: true,
                  //                 contentPadding:
                  //                     EdgeInsets.only(right: 8, left: 8),
                  //                 enabledBorder: UnderlineInputBorder(
                  //                   borderSide: BorderSide(
                  //                       color: Colors.orange[400],
                  //                       width: 10),
                  //                   //  when the TextFormField in focused
                  //                 ),
                  //                 focusedBorder: UnderlineInputBorder(
                  //                   borderSide: BorderSide(
                  //                       color: Colors.orange, width: 12),
                  //                   //  when the TextFormField in focused
                  //                 ),
                  //               ),
                  //               items: _states
                  //                   .map<DropdownMenuItem<String>>(
                  //                       (var value) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: value,
                  //                   child: Text(value),
                  //                 );
                  //               }).toList(),
                  //               onChanged: (value) {
                  //                 setState(() {
                  //                   selected_state = value;

                  //                   districtFuture = getDistrict(value);
                  //                   //_chosenValue_Town = null;
                  //                 });
                  //               },
                  //             )
                  //             // } else {
                  //             //   return Container();
                  //             // }

                  //             ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Container(
                      height: screenHeight * .30,
                      width: screenWidth,
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: Image.asset('assets/images/img_loation.png')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: screenWidth * .45,
                          //height: 100,
                          child: Container(
                            padding:
                                EdgeInsets.only(bottom: 0, left: 0, right: 0),
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
                            child: FutureBuilder<DistrictModel>(
                                future: getDistrict("Kerala"),
                                builder: (context,
                                    AsyncSnapshot<DistrictModel> snapshot) {
                                  //if (snapshot.hasData) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.white,
                                    ),
                                    child: DropdownButtonFormField(
                                      value: chosenValue_District,
                                      validator: (value) {
                                        if (value == null) {
                                          return 'District is required';
                                        }
                                        return null;
                                      },
                                      hint: Text("--District--"),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(left: 5),
                                      ),
                                      items: snapshot.hasData
                                          ? snapshot.data.result
                                              .map<DropdownMenuItem<String>>(
                                                  (var value1) {
                                              return DropdownMenuItem<String>(
                                                value: value1 != null
                                                    ? value1.disPkDistrict
                                                    : null,
                                                child: Text(value1.district,
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              );
                                            }).toList()
                                          : null,
                                      onChanged: (value2) {
                                        setState(() {
                                          chosenValue_District = value2;
                                          selectedTown = null;
                                          selectedDistrict = value2;
                                          chosenSubTown = null;
                                          chosenValue_Town = null;

                                          // chosenValue_Town = null;
                                        });
                                        townFuture =
                                            getTowndata(chosenValue_District);
                                      },
                                      // value: chosenValue_District,
                                    ),
                                  );
                                  // } else {
                                  //   return Container();
                                  // }
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: screenWidth * .45,
                          //height: 100,
                          child: Container(
                            // padding: EdgeInsets.only(
                            //     bottom: 5, left: .75, right: .75),
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
                            child: FutureBuilder<TownModel>(
                                future: townFuture,
                                builder: (context,
                                    AsyncSnapshot<TownModel> snapshot) {
                                  //if (snapshot.hasData) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.white,
                                    ),
                                    child: DropdownButtonFormField(
                                      value: chosenValue_Town,
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Town is required';
                                        }
                                        return null;
                                      },
                                      hint: Text("---Town---"),
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 5),
                                          border: InputBorder.none),
                                      items: snapshot.hasData
                                          ? snapshot.data.result
                                              .map<DropdownMenuItem<String>>(
                                                  (var value) {
                                              locationName = value.town;

                                              return DropdownMenuItem<String>(
                                                value: value != null
                                                    ? value.pkTown
                                                    : null,
                                                child: Text(
                                                  value.town ?? "---Town---",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            }).toList()
                                          : null,
                                      onChanged: (value) {
                                        setState(() {
                                          chosenValue_Town = value;
                                          selectedTown = value;
                                          chosenSubTown = null;
                                          selectedSubTown = null;
                                          //_chosenValue_Town = null;
                                        });
                                        //townFuture = getTowndata(value);
                                        subtownsFuture =
                                            getSubTowns(selectedTown);
                                      },
                                      //value: chosenValue_Town,
                                      //     ? chosenValue_Town
                                      //     : null,
                                    ),
                                  );
                                  // } else {
                                  //   return Container();
                                  // }
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text("Or"),
                  //     )
                  //   ],
                  // ),
                  subtowns(selectedTown),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       width: screenWidth * .90,
                  //       //height: 100,
                  //       child: Container(
                  //         // padding: EdgeInsets.only(
                  //         //     bottom: 5, left: .75, right: .75),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(5),
                  //           color: AppColors.kPrimaryColor,
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: const Color(0x12000000),
                  //               offset: Offset(0, 3),
                  //               blurRadius: 6,
                  //             ),
                  //           ],
                  //         ),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(5.0),
                  //             color: Colors.white,
                  //           ),
                  //           child: TextFormField(
                  //             readOnly: true,
                  //             textAlign: TextAlign.center,
                  //             validator: (value) => value.isEmpty
                  //                 ? 'Enter current location'
                  //                 : null,
                  //             controller: currentLocalityController,
                  //             decoration: InputDecoration(
                  //               border: InputBorder.none,
                  //               hintText: 'Use my current location',
                  //               hintStyle: TextStyle(color: Colors.grey),
                  //               suffixIcon: IconButton(
                  //                   //color: Colors.orange,
                  //                   icon: const Icon(
                  //                     Icons.location_on,
                  //                     color: Colors.orange,
                  //                   ),
                  //                   onPressed: () async {
                  //                     FocusScope.of(context)
                  //                         .requestFocus(FocusNode());
                  //                     _getCurrentLocation();
                  //                     //print("klhghghfgf$_currentAddress");
                  //                   }),

                  //               contentPadding: EdgeInsets.symmetric(
                  //                   horizontal: 40,
                  //                   vertical:
                  //                       15), //Change this value to custom as you like
                  //               isDense: true,
                  //               focusedBorder: UnderlineInputBorder(
                  //                 borderSide: BorderSide(
                  //                     color: Colors.orange, width: 10),
                  //                 //  when the TextFormField in focused
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Download Coupons & Vouchers (Premium Plan) will be added to your account based on your selected Home Location.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FloatingActionButton(
                          onPressed: () {
                            if (chosenValue_District != null) {
                              if (chosenValue_Town != null) {
                                if (selectedSubTown != null) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PasswordSettingPage(
                                              widget.mobileNumberPassed,
                                              chosenValue_District,
                                              chosenValue_Town,
                                              locationName,
                                              selectedSubTown,
                                              currentLocalityController
                                                  .text.isNotEmpty
                                                  .toString(),
                                            )),
                                  );
                                  // setState(() {
                                  //   chosenValue_Town = null;
                                  //   chosenValue_District = null;
                                  //   chosenSubTown = null;
                                  // });
                                } else {
                                  GeneralTools().createSnackBarFailed(
                                      "Please select Home location", context);
                                }
                              } else {
                                GeneralTools().createSnackBarFailed(
                                    "Please select Town", context);
                              }
                            } else {
                              GeneralTools().createSnackBarFailed(
                                  "Please select District", context);
                            }
                            // if (selectedSubTown != null &&
                            //     chosenValue_Town != null &&
                            //     chosenValue_District != null) {
                            //   //prefset(chosenValue_
                            //   //Town);

                            // } else {
                            //   GeneralTools().createSnackBarFailed(
                            //       "Please select City and Town", context);
                            // }
                          },
                          backgroundColor: Theme.of(context).accentColor,
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> prefset(String selected_Town) async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    await prefs.setString("Selected_Town", selected_Town.toString());

    // print("session$selected_Town");
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}";
        currentLocalityController.text = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget subtowns(String subtownid) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: screenWidth * .50,

        // padding: EdgeInsets.only(
        //     bottom: 5, left: .75, right: .75),
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
        child: FutureBuilder<GetSubTownsModel>(
            future: subtownsFuture,
            builder: (context, AsyncSnapshot<GetSubTownsModel> snapshot) {
              //if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  value: chosenSubTown,
                  validator: (value) {
                    if (value == null) {
                      return 'Home location is required';
                    }
                    return null;
                  },
                  hint: Text("--Home Location--"),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: InputBorder.none),
                  items: snapshot.hasData
                      ? snapshot.data.result
                          .map<DropdownMenuItem<String>>((var value) {
                          return DropdownMenuItem<String>(
                            value: value != null ? value.stId : null,
                            child: Text(
                              value.stSubTown,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }).toList()
                      : null,
                  onChanged: (value) {
                    setState(() {
                      chosenSubTown = value;
                      selectedSubTown = value;
                      //_chosenValue_Town = null;
                    });
                    //townFuture = getTowndata(value);
                  },
                  //value: chosenValue_Town,
                  //     ? chosenValue_Town
                  //     : null,
                ),
              );
              // } else {
              //   return Container();
              // }
            }),
      ),
    );
  }
}
