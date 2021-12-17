import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/ChangeLocation/DistictModel.dart';
import 'package:matsapp/Modeles/ChangeLocation/TownModel.dart';
import 'package:matsapp/Modeles/LocationModels/GetSubTownsModel.dart';
import 'package:matsapp/Modeles/SqlLiteTableDataModel.dart';
import 'package:matsapp/Network/ChangeLocationRepo.dart';
import 'package:matsapp/Network/DistricttModeRest.dart';
import 'package:matsapp/Network/GetSubtownsRepo.dart';
import 'package:matsapp/Network/TownMoidelRest.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageLocation extends StatefulWidget {
  // final String userMobile, apiKey, userType;
  // final int userId;
  //final LoginModel user;
  // final String user_dist;
  // final String user_town;
  // final String subtown;
  HomePageLocation();
  // HomePageLocation(
  //   this.userId,
  //   this.userMobile,
  //   this.apiKey,
  //   this.userType,
  //   // this.user,
  // );

  @override
  _HomePageLocationState createState() => _HomePageLocationState();
}

class _HomePageLocationState extends State<HomePageLocation> {
  Position _currentPosition;
  String _currentAddress;

  // ignore: non_constant_identifier_names
  String chosenValue_City;

  // ignore: non_constant_identifier_names
  String chosenValue_Town;
  var currentTown;
  var selected_state;

  String selectedCity;

  var selectedTown1;

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
  //subtownsFuture;
  Future districtFuture;

  String mobileNumber;

  String apiKey;

  bool isload = false;

  Future<DistrictModel> futergetDistrict;

  var selecteTown;

  String selectedDistrict, district;

  String sel_district, sel_town, sel_subtown;

  DatabaseHelper dbHelper = new DatabaseHelper();

  Future<GetSubTownsModel> subtownsFuture;

  var selectedSubTown;

  DistrictItem userSelectedDistrict;

  TownItem userSelectedTown;
  SubtownTownItem userSelectedSubtown;

  var chosenTown;

  String chosenValueDistict;

  int usID;

  var chosenSubTown;
  String selectedsubtown;

  bool boolvalue;

  @override
  void initState() {
    dbHelper.getAll().then((value2) => {
          if (mounted)
            {
              setState(() {
                usID = value2[0].userid;
                //   sel_town = value2[0].selectedTown;
                // sel_district = value2[0].district;
                if (value2.length == 0) {
                  // sel_district = value2[0].district;
                  // sel_subtown = value2[0].subtown;
                  // selectedDistrict = value2[0].district;
                } else {
                  sel_town = value2[0].selectedTown;
                  sel_district = value2[0].district;
                  sel_subtown = value2[0].subtown;
                  selectedDistrict = value2[0].district;
                  futergetDistrict = getDistrict("Kerala");
                  futergetDistrict.then((value) => {
                        userSelectedDistrict = value.result
                            .where((element) =>
                                element.disPkDistrict == sel_district)
                            .first,
                        if (userSelectedDistrict.disPkDistrict == sel_district)
                          {
                            townFuture =
                                getTowndata(userSelectedDistrict.disPkDistrict),
                            townFuture.then((valueTown) => {
                                  userSelectedTown = valueTown.result
                                      .where((element) =>
                                          element.pkTown == sel_town)
                                      .first,

                                  if (userSelectedTown.pkTown == sel_town)
                                    {
                                      subtownsFuture =
                                          getSubTowns(userSelectedTown.pkTown),
                                      subtownsFuture.then((valueSubtown) => {
                                            userSelectedSubtown = valueSubtown
                                                .result
                                                .where((element) =>
                                                    element.stId == sel_subtown)
                                                .first,
                                            if (userSelectedSubtown.stId ==
                                                sel_subtown)
                                              {
                                                setState(() {
                                                  userSelectedDistrict =
                                                      userSelectedDistrict;
                                                  userSelectedTown =
                                                      userSelectedTown;
                                                  userSelectedSubtown =
                                                      userSelectedSubtown;
                                                  chosenTown =
                                                      userSelectedTown.pkTown;
                                                  chosenValueDistict =
                                                      userSelectedDistrict
                                                          .disPkDistrict;
                                                  selectedTown =
                                                      userSelectedTown.town;
                                                  chosenSubTown =
                                                      userSelectedSubtown.stId;
                                                  selectedSubTown =
                                                      userSelectedSubtown
                                                          .stSubTown;
                                                }),
                                              }
                                          }),
                                    }
                                  else
                                    {
                                      getSubtown(userSelectedTown.pkTown),
                                    }

                                  // if (value2.length == 0) {
                                  //   userSelectedTown = valueTown.result;
                                  //   userSelectedDistrict = value.result.first;
                                  // } else {
                                  //   userSelectedDistrict = userSelectedDistrict;
                                  //   userSelectedTown = userSelectedTown;
                                  // }
                                })
                          }
                        else
                          {
                            setState(() {
                              userSelectedDistrict = userSelectedDistrict;
                              chosenValueDistict =
                                  userSelectedDistrict.disPkDistrict;
                            }),
                            townFuture.then((valueTown) => {
                                  userSelectedTown = valueTown.result
                                      .where((element) => element.pkTown)
                                      .first,
                                  setState(() {
                                    userSelectedTown = userSelectedTown;
                                    chosenTown = userSelectedTown.pkTown;
                                    selectedTown = userSelectedTown.town;
                                  }),
                                })
                          }
                      });
                }
              }),
              //_getCurrentLocation(),
            }
        });

    // SharedPreferences.getInstance().then((prefs) {
    //   SharedPreferences sharedPrefs;
    //   setState(() => sharedPrefs = prefs);
    //   setState(() {
    //     //townSelectedStore = sharedPrefs.getString('SELECTED_TOWN');
    //     mobileNumber = sharedPrefs.getString('USER_MOBILE');
    //     apiKey = sharedPrefs.getString('USER_API_KEY');
    //     futergetDistrict = getDistrict("Kerala");
    //   });
    // });

    super.initState();
  }

  void getSubtown(String selectedTown) {
    subtownsFuture = getSubTowns(selectedTown);
    subtownsFuture.then((valueSubtown) => {
          userSelectedSubtown = valueSubtown.result.first,
          setState(() {
            chosenSubTown = userSelectedSubtown.stId;
            selectedSubTown = userSelectedSubtown.stSubTown;
          })
        });
  }

  @override
  void dispose() {
    townsearchController.clear();
    chosenValue_City = null;
    chosenValue_Town = null;
    selectedDistrict = null;
    selecteTown = null;
    selectedSubTown = null;
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
          automaticallyImplyLeading: true,
          title: Text("Choose Location", style: TextStyle(fontSize: 17)),
          // leading: new IconButton(
          //     onPressed: () => Navigator.of(context).pop(),
          //     icon: new Icon(Icons.arrow_back_rounded)),
        ),
        body: Form(
          key: _form,
          child: Center(
            child: Container(
              width: screenWidth,
              height: screenHeight * 10,
              child: SingleChildScrollView(
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
                        height: SizeConfig.heightMultiplier * 30,
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                          // top: 10,
                          // left: 20,
                          // right: 20,
                          bottom: 30,
                        ),
                        child: Image.asset(
                          'assets/images/img_loation.png',
                          fit: BoxFit.cover,
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 5),
                          child: Container(
                            //width: screenWidth * .45,
                            width: screenWidth * .75,

                            child: Text("Selected District",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
                            //width: screenWidth * .45,
                            width: screenWidth * .75,
                            //height: 100,
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: 3, bottom: 3, left: 5, right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  //color: AppColors.kPrimaryColor,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x12000000),
                                      offset: Offset(0, 3),
                                      blurRadius: 10,
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
                                          //value: selectedDistrict,

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
                                              ? snapshot.data.result.map<
                                                      DropdownMenuItem<String>>(
                                                  (var value1) {
                                                  selectedCity =
                                                      value1.district;
                                                  return DropdownMenuItem<
                                                      String>(
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
                                              sel_town = null;
                                              selectedDistrict = value2;
                                              selecteTown = null;
                                              selectedSubTown = null;
                                              chosenTown = null;

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
                          padding: const EdgeInsets.only(top: 20.0, left: 5),
                          child: Container(
                            //width: screenWidth * .45,
                            width: screenWidth * .75,

                            child: Text("Selected Town",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
                            width: screenWidth * .75,
                            //height: 100,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 3, bottom: 3, left: 5, right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x12000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 10,
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Colors.white,
                                      ),
                                      child: DropdownButtonFormField(
                                        //value: selecteTown,

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

                                            //selectedTown = value;
                                            chosenSubTown = null;
                                            //_chosenValue_Town = null;
                                          });
                                          subtownsFuture = getSubTowns(value);
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
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: screenWidth * .75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, left: 5),
                              child: Text("Select Sub Town",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54)),
                            ),
                            Container(
                              width: screenWidth * .75,
                              padding: EdgeInsets.only(
                                  top: 3, bottom: 3, left: 5, right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x12000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: FutureBuilder<GetSubTownsModel>(
                                  future: subtownsFuture,
                                  builder: (context,
                                      AsyncSnapshot<GetSubTownsModel>
                                          snapshot) {
                                    //if (snapshot.hasData) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
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
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20),
                                            border: InputBorder.none),
                                        items: snapshot.hasData
                                            ? snapshot.data.result
                                                .map<DropdownMenuItem<String>>(
                                                    (value) {
                                                return DropdownMenuItem<String>(
                                                  value: value != null
                                                      ? value.stId
                                                      : null,
                                                  child: Text(
                                                    value.stSubTown,
                                                    style:
                                                        TextStyle(fontSize: 14),
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
                          ],
                        ),
                      ),
                    ),
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
                    Container(
                      width: screenWidth,
                      //height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Stores are displayed based on your selected town",
                                  style: TextStyle(
                                      letterSpacing: .25,
                                      fontWeight: FontWeight.w600,
                                      fontSize: MediaQuery.of(context)
                                              .textScaleFactor *
                                          12)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: () async {
                              if (selectedDistrict != null) {
                                if (selectedTown != null) {
                                  if (selectedSubTown != null) {
                                    updateLocation(
                                            state: "Kerala",
                                            district: selectedDistrict,
                                            town: chosenTown,
                                            subTown:
                                                selectedSubTown, //selectedSubTown,
                                            mobile:
                                                await userData().getMobileNo(),
                                            apikey: await userData().getApiKey)
                                        .then((value) => {
                                              if (value.result == 1)
                                                {
                                                  print(
                                                    dbHelper.updateTown(
                                                        usID,
                                                        selectedDistrict,
                                                        chosenTown,
                                                        selectedTown,
                                                        selectedSubTown),
                                                  ),
                                                  setState(() {
                                                    isload = false;
                                                  }),

                                                  //dbHelper.getAll(),
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MainHomePage()),
                                                  ),
                                                  // setState(() {
                                                  //   selectedDistrict = null;
                                                  //   selecteTown = null;
                                                  //   selectedSubTown = null;
                                                  // })
                                                }
                                              // else if (value.result == 1)
                                              //   {
                                              //     setState(() {
                                              //       isload = false;
                                              //     }),
                                              //     GeneralTools().createSnackBarFailed(
                                              //         "Location selection failed",
                                              //         context)
                                              //   }
                                            });
                                  } else {
                                    GeneralTools().createSnackBarFailed(
                                        "Please select Sub Town", context);
                                  }
                                } else {
                                  GeneralTools().createSnackBarFailed(
                                      "Please select Town", context);
                                }
                              } else {
                                GeneralTools().createSnackBarFailed(
                                    "Please select District", context);
                              }

                              //prefset(chosenValue_
                              //Town);
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
      ),
    );
  }

  getdistrict() {
    futergetDistrict = getDistrict("Kerala");
    futergetDistrict.then((value) => {
          value.result
                  .where((element) => element.disPkDistrict == sel_district)
                  .contains(sel_district)
              ? boolvalue = true
              : boolvalue = false,
          townFuture = getTowndata(userSelectedDistrict.disPkDistrict),
          townFuture.then((valueTown) => {
                setState(() {}),
                userSelectedTown = valueTown.result
                    .where((element) => element.pkTown == sel_town)
                    .first,
              }),
        });
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
        // print("${place.street}");
        // print("${place.locality}");
        // print("${place.administrativeArea}");
        // print("${place.subAdministrativeArea}");
      });
    } catch (e) {
      print(e);
    }
  }
}
