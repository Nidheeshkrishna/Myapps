import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/ChangeLocation/DistictModel.dart';
import 'package:matsapp/Modeles/ChangeLocation/TownModel.dart';


import 'package:matsapp/Modeles/SqlLiteTableDataModel.dart';

import 'package:matsapp/Network/ChangeLocationRepo.dart';
import 'package:matsapp/Network/DistricttModeRest.dart';
import 'package:matsapp/Network/TownMoidelRest.dart';

import 'package:matsapp/Pages/HomePages/MainHomePage.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInLocation extends StatefulWidget {
  final String userMobile, apiKey, userType;
  final int userId;
  //final LoginModel user;

  LogInLocation(
    this.userId,
    this.userMobile,
    this.apiKey,
    this.userType,
    // this.user,
  );

  @override
  _ChooseYourLocationState createState() => _ChooseYourLocationState();
}

class _ChooseYourLocationState extends State<LogInLocation> {
  Position _currentPosition;
  String _currentAddress;

  // ignore: non_constant_identifier_names
  String chosenValue_City;

  // ignore: non_constant_identifier_names
  String chosenValue_Town;
  var currentTown;
  var selected_state;

  String selectedCity;

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

  Future townFuture, stateFuture;
  Future districtFuture;

  String mobileNumber;

  String apiKey;

  bool isload = false;

  Future<DistrictModel> futergetDistrict;

  var chosenTown;

  String chosenValueDistict, district;

  DatabaseHelper dbHelper = new DatabaseHelper();

  var selectedTownId;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      SharedPreferences sharedPrefs;
      setState(() => sharedPrefs = prefs);
      setState(() {
        //townSelectedStore = sharedPrefs.getString('SELECTED_TOWN');
        mobileNumber = sharedPrefs.getString('USER_MOBILE');
        apiKey = sharedPrefs.getString('USER_API_KEY');
        futergetDistrict = getDistrict("Kerala");
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    townsearchController.clear();
    chosenValue_City = null;
    chosenValue_Town = null;
    currentLocalityController.clear();
    cityController.clear();
    townsearchController.clear();

    // prefs.clear();

    super.dispose();
  }

  //
  // List<String> _states = ['Kerala'];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    UserInfo userinfo;
    WidgetsFlutterBinding.ensureInitialized();
    return ModalProgressHUD(
      progressIndicator:
          Center(child: SpinKitHourGlass(color: Color(0xffFFB517))),
      inAsyncCall: isload,
      dismissible: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("Choose Location"),
          // leading: new IconButton(
          //     onPressed: () => Navigator.of(context).pop(),
          //     icon: new Icon(Icons.arrow_back_rounded)),
        ),
        body: Form(
          key: _form,
          child: Center(
            child: Container(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                      height: SizeConfig.heightMultiplier * 45,
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
                              // padding: EdgeInsets.only(
                              //     bottom: 0, left: .75, right: .75),
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
                                  future: futergetDistrict,
                                  builder: (context,
                                      AsyncSnapshot<DistrictModel> snapshot) {
                                    //if (snapshot.hasData) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Colors.white,
                                      ),
                                      child: DropdownButtonFormField(
                                        value: chosenValueDistict,
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
                                                selectedCity = value1.district;
                                                return DropdownMenuItem<String>(
                                                  value: value1 != null
                                                      ? value1.disPkDistrict
                                                      : null,
                                                  child: Text(value1.district,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 14)),
                                                );
                                              }).toList()
                                            : null,
                                        onChanged: (value2) {
                                          setState(() {
                                            chosenValueDistict = value2;
                                            chosenTown = null;
                                            selectedCity = value2;
                                            //print(chosenValueDistict);
                                            district = chosenValueDistict;

                                            // chosenValue_City = null;
                                          });
                                          townFuture = getTowndata(value2);
                                        },
                                        // value: chosenValue_Town,
                                      ),
                                    );
                                    // } else {
                                    //   return Container();
                                    // }
                                  })),
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
                                      value: chosenTown,
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
                                              return DropdownMenuItem<String>(
                                                onTap: () {
                                                  setState(() {
                                                    selectedTown = value.town;
                                                  });

                                                  print(selectedTown);
                                                },
                                                value: value != null
                                                    ? value.pkTown
                                                    : null,
                                                child: Text(
                                                  value.town ?? "",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            }).toList()
                                          : null,
                                      onChanged: (value) {
                                        setState(() {
                                          chosenTown = value;
                                          selectedTownId = value;

                                          //_chosenValue_Town = null;
                                        });
                                        //townFuture = getTowndata(value);
                                      },
                                      //value: chosenValue_City,
                                      //     ? chosenValue_City
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
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: Text(
                  //         "Or",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 18),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       width: screenWidth * .90,
                  //       //height: 100,
                  //       child: Container(
                  //         // padding:
                  //         //     EdgeInsets.only(bottom: 5, left: .75, right: .75),
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
                  //                     print("klhghghfgf$_currentAddress");
                  //                   }),

                  //               contentPadding: EdgeInsets.symmetric(
                  //                   horizontal: 40, vertical: 15),
                  //               //Change this value to custom as you like
                  //               isDense: true,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FloatingActionButton(
                          onPressed: () {
                            if (chosenValueDistict != null) {
                              if (chosenTown != null) {
                                dbHelper.initDb();
                                //userid TEXT PRIMARY KEY, mobilenumber TEXT,location TEXT, selected_town TEXT,selected_state TEXT,selected_district TEXT,apitoken Text,islogeddIn bool
                                userinfo = UserInfo(
                                  userid: widget.userId,
                                  mobilenumber: widget.userMobile,
                                  location: selectedTown,
                                  selectedTown: chosenTown,
                                  state: "Kerala",
                                  district: district.toString(),
                                  apitoken: widget.apiKey,
                                  islogeddIn: "true",
                                  userType: widget.userType,
                                );
                                dbHelper.saveUser(userinfo);
                                //dbHelper.getAll(),
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainHomePage()),
                                );
                                setState(() {
                                  chosenValue_City = null;
                                  chosenValue_Town = null;
                                });
                              } else {
                                GeneralTools().createSnackBarFailed(
                                    "Please select Town", context);
                              }
                            } else {
                              GeneralTools().createSnackBarFailed(
                                  "Please select District", context);
                            }
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

  Future<void> prefsetLocation(String selectedTown) async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    await prefs.setString("SELECTED_TOWN", selectedTown.toString());

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
        print("${place.street}");
        print("${place.locality}");
        print("${place.administrativeArea}");
        print("${place.subAdministrativeArea}");
      });
    } catch (e) {
      print(e);
    }
  }
}
