import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/Profile/ProfileViewModel.dart';

import 'package:matsapp/Network/ProfileviepgRest.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';
import 'package:matsapp/Pages/ProfilePages/Complaint_registeration.dart';

import 'package:matsapp/Pages/ProfilePages/CustomerProfileEdit.dart';
import 'package:matsapp/Pages/ProfilePages/PrivacyPolicy.dart';
import 'package:matsapp/Pages/ProfilePages/UserHistory.dart';
import 'package:matsapp/Pages/ProfilePages/helpAndGuide.dart';
import 'package:matsapp/Pages/Providers/ConnectivityServices.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/utilities/urls.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../feedBack.dart';

class ProfileViewpage extends StatefulWidget {
  final String mobile;
  ProfileViewpage(this.mobile);

  @override
  ProfileViewpgState createState() => ProfileViewpgState();
}

class ProfileViewpgState extends State<ProfileViewpage> {
  Future profileviewpg;

  var mobileNumber;

  ConnectivityStatus connectionStatus;
  bool networkStatus = false;
  @override
  void initState() {
    super.initState();

    DatabaseHelper dbHelper = new DatabaseHelper();
    dbHelper.getAll().then((value) => {
          setState(() {
            mobileNumber = value[0].mobilenumber;
            profileviewpg = fetchProfile(widget.mobile);
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    checkNetwork() {
      connectionStatus == ConnectivityStatus.Cellular ||
              connectionStatus == ConnectivityStatus.WiFi
          ? networkStatus = true
          : networkStatus = false;
    }

    connectionStatus = Provider.of<ConnectivityStatus>(context);
    checkNetwork();

    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey[800],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainHomePage()),
              );
            },
          ),
          title: Text('Profile'),
        ),
        body: Container(
          height: SizeConfig.screenheight,
          child: WillPopScope(
            onWillPop: () {
              return Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainHomePage()),
              );
            },
            child: FutureBuilder<ProfileViewModel>(
                future: profileviewpg,
                builder: (BuildContext context,
                    AsyncSnapshot<ProfileViewModel> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.result.length > 0) {
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.result.length,
                          physics: ScrollPhysics(),
                          //physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio:
                                MediaQuery.of(context).size.height / 1100,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        .30,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: Stack(
                                      children: [
                                        Card(
                                          elevation: 2,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(40),
                                                bottomRight:
                                                    Radius.circular(40)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // Container(
                                                  //   padding: EdgeInsets.all(10),
                                                  //   child: Column(children: [
                                                  //     Text('Wallet',
                                                  //         style: TextStyle(
                                                  //             color: Colors.red,
                                                  //             fontSize: 18)),
                                                  //     Row(
                                                  //       children: [
                                                  //         Image.asset(
                                                  //           "assets/images/rupee.png",
                                                  //           color:
                                                  //               Colors.blueAccent,
                                                  //           width: 20,
                                                  //           height: 20,
                                                  //         ),
                                                  //         Text(
                                                  //             snapshot
                                                  //                 .data
                                                  //                 .result[index]
                                                  //                 .walletAmount,
                                                  //             style: TextStyle(
                                                  //                 color:
                                                  //                     Colors.red,
                                                  //                 fontSize: 18)),
                                                  //       ],
                                                  //     )
                                                  //   ]),
                                                  // ),
                                                  snapshot.data.result[index]
                                                              .savingsAmount !=
                                                          "0"
                                                      ? OutlinedButton(
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          25),
                                                                  minimumSize:
                                                                      Size.square(
                                                                          70),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0),
                                                                  ),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white70,
                                                                  side: BorderSide(
                                                                      width: 2,
                                                                      color: Color(
                                                                          0xff20A73B))),
                                                          onPressed: () {},
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                  'Your Total Savings',
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .kSecondaryDarkColor,
                                                                      fontSize:
                                                                          15)),
                                                              Row(
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/images/rupee.png",
                                                                    color: AppColors
                                                                        .kSecondaryDarkColor,
                                                                    width: 18,
                                                                    height: 18,
                                                                  ),
                                                                  Text(
                                                                      snapshot
                                                                              .data
                                                                              .result[
                                                                                  index]
                                                                              .savingsAmount ??
                                                                          "0",
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .kSecondaryDarkColor,
                                                                          fontSize:
                                                                              26,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : Container(),

                                                  // OutlinedButton(
                                                  //   style:
                                                  //       OutlinedButton.styleFrom(
                                                  //     minimumSize:
                                                  //         Size.square(70),
                                                  //     shape:
                                                  //         RoundedRectangleBorder(
                                                  //       borderRadius:
                                                  //           BorderRadius.circular(
                                                  //               20.0),
                                                  //     ),
                                                  //     backgroundColor:
                                                  //         Colors.white70,
                                                  //     side: BorderSide(
                                                  //         width: 2,
                                                  //         color:
                                                  //             Color(0xffFFB517)),
                                                  //   ),
                                                  //   onPressed: () {},
                                                  //   child: Column(
                                                  //     children: [
                                                  //       Text('Referral Earnings',
                                                  //           style: TextStyle(
                                                  //               color: AppColors
                                                  //                   .kSecondaryDarkColor,
                                                  //               fontSize: 15)),
                                                  //       SizedBox(height: 5),
                                                  //       Row(
                                                  //         children: [
                                                  //           Image.asset(
                                                  //             "assets/images/rupee.png",
                                                  //             color: AppColors
                                                  //                 .kSecondaryDarkColor,
                                                  //             width: 18,
                                                  //             height: 18,
                                                  //           ),
                                                  //           Text(
                                                  //               snapshot
                                                  //                   .data
                                                  //                   .result[index]
                                                  //                   .referralAmount,
                                                  //               style: TextStyle(
                                                  //                   color: AppColors
                                                  //                       .kSecondaryDarkColor,
                                                  //                   fontSize: 26,
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .bold)),
                                                  //         ],
                                                  //       )
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          //height:MediaQuery.of(context).size.height / 4,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Card(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(40),
                                                    bottomRight:
                                                        Radius.circular(40)),
                                              ),
                                              child: Column(
                                                children: [
                                                  snapshot.data.result[index]
                                                          .imageUrl.isNotEmpty
                                                      ? CachedNetworkImage(
                                                          imageUrl: snapshot
                                                              .data
                                                              .result[index]
                                                              .imageUrl,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              profilepic(
                                                                context,
                                                                snapshot
                                                                    .data
                                                                    .result[
                                                                        index]
                                                                    .name,
                                                                snapshot
                                                                    .data
                                                                    .result[
                                                                        index]
                                                                    .email,
                                                                snapshot
                                                                    .data
                                                                    .result[
                                                                        index]
                                                                    .gender,
                                                                snapshot
                                                                    .data
                                                                    .result[
                                                                        index]
                                                                    .profession,
                                                                snapshot
                                                                    .data
                                                                    .result[
                                                                        index]
                                                                    .dob,
                                                                snapshot
                                                                    .data
                                                                    .result[
                                                                        index]
                                                                    .imageUrl,
                                                                snapshot
                                                                    .data
                                                                    .result[
                                                                        index]
                                                                    .district,
                                                              ),
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              CircleAvatar(
                                                                radius: 80,
                                                                backgroundImage:
                                                                    NetworkImage(snapshot
                                                                        .data
                                                                        .result[
                                                                            index]
                                                                        .imageUrl),
                                                                child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        bottom:
                                                                            10,
                                                                        right:
                                                                            5,
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              18,
                                                                          backgroundColor:
                                                                              Colors.white70,
                                                                          child:
                                                                              InkWell(
                                                                            child:
                                                                                Icon(
                                                                              Icons.camera_alt_outlined,
                                                                              color: Colors.blue,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              String name = snapshot.data.result[index].name;
                                                                              String emailid = snapshot.data.result[index].email;
                                                                              String gender = snapshot.data.result[index].gender;
                                                                              String profession = snapshot.data.result[index].profession;
                                                                              String dob = snapshot.data.result[index].dob;
                                                                              String image = snapshot.data.result[index].imageUrl;
                                                                              String district = snapshot.data.result[index].district;
                                                                              Navigator.pushReplacement(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => CustomerProfileEdit(
                                                                                            mobile: mobileNumber,
                                                                                            name: name,
                                                                                            emailID: emailid,
                                                                                            gender: gender,
                                                                                            profession: profession,
                                                                                            dOB: dob,
                                                                                            image: image,
                                                                                            hometown: district,
                                                                                          )));
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              ))
                                                      : SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .30,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .40,
                                                          child: Stack(
                                                            clipBehavior:
                                                                Clip.none,
                                                            fit:
                                                                StackFit.expand,
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 100,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        "assets/images/profile.png"),
                                                              ),
                                                              Positioned(
                                                                  bottom: 0,
                                                                  right: -25,
                                                                  child:
                                                                      RawMaterialButton(
                                                                    onPressed:
                                                                        () {
                                                                      String name = snapshot
                                                                          .data
                                                                          .result[
                                                                              index]
                                                                          .name;
                                                                      String emailid = snapshot
                                                                          .data
                                                                          .result[
                                                                              index]
                                                                          .email;
                                                                      String gender = snapshot
                                                                          .data
                                                                          .result[
                                                                              index]
                                                                          .gender;
                                                                      String profession = snapshot
                                                                          .data
                                                                          .result[
                                                                              index]
                                                                          .profession;
                                                                      String dob = snapshot
                                                                          .data
                                                                          .result[
                                                                              index]
                                                                          .dob;
                                                                      String image = snapshot
                                                                          .data
                                                                          .result[
                                                                              index]
                                                                          .imageUrl;
                                                                      String district = snapshot
                                                                          .data
                                                                          .result[
                                                                              index]
                                                                          .district;
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => CustomerProfileEdit(
                                                                                    mobile: mobileNumber,
                                                                                    name: name,
                                                                                    emailID: emailid,
                                                                                    gender: gender,
                                                                                    profession: profession,
                                                                                    dOB: dob,
                                                                                    image: image,
                                                                                    hometown: district,
                                                                                  )));
                                                                    },
                                                                    elevation:
                                                                        2.0,
                                                                    fillColor:
                                                                        Color(
                                                                            0xFFF5F6F9),
                                                                    child: Icon(
                                                                      Icons
                                                                          .camera_alt_outlined,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            15.0),
                                                                    shape:
                                                                        CircleBorder(),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    snapshot.data.result[index]
                                                            .name ??
                                                        "Hi User",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color: Colors.orange,
                                                      ),
                                                      Text(snapshot
                                                              .data
                                                              .result[index]
                                                              .district) ??
                                                          "",
                                                      Text(','),
                                                      Text(snapshot
                                                              .data
                                                              .result[index]
                                                              .state) ??
                                                          ""
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    child: ListView(
                                      physics: ScrollPhysics(),
                                      itemExtent: 50,
                                      shrinkWrap: true,
                                      children: [
                                        ListTile(
                                          title: Text("Privacy Policy",
                                              style:
                                                  AppTextStyle.profileFont()),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColors
                                                  .kSecondaryDarkColor),
                                          onTap: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PrivacyPolicy()),
                                            );
                                          },
                                        ),
                                        ListTile(
                                          title: Text("Feedback",
                                              style:
                                                  AppTextStyle.profileFont()),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColors
                                                  .kSecondaryDarkColor),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FeedBackPage()),
                                            );
                                          },
                                        ),
                                        ListTile(
                                          title: Text("Help & Guide",
                                              style:
                                                  AppTextStyle.profileFont()),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColors
                                                  .kSecondaryDarkColor),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HelpAndGuide()),
                                            );
                                          },
                                        ),
                                        ListTile(
                                          title: Text("Complaint",
                                              style:
                                                  AppTextStyle.profileFont()),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColors
                                                  .kSecondaryDarkColor),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ComplaintRegisteration()),
                                            );
                                          },
                                        ),
                                        ListTile(
                                          title: Text("Complaint History",
                                              style:
                                                  AppTextStyle.profileFont()),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColors
                                                  .kSecondaryDarkColor),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ComplaintHistory()),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Profession details hidden for now...
                                  /*Container(
                                    //height: MediaQuery.of(context).size.height / 700,
                                    width: MediaQuery.of(context).size.width,
                                    //color: Colors.black,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.mars,
                                                    color: Colors.orange,
                                                    size: 25,
                                                  ),
                                                  SizedBox(
                                                    width: 18,
                                                  ),
                                                  Text(
                                                      snapshot.data.result[index]
                                                              .gender ??
                                                          "",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                          height: 25,
                                          thickness: 2,
                                          indent: 15,
                                          endIndent: 15,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.date_range,
                                                color: Colors.orange,
                                                size: 25,
                                              ),
                                              SizedBox(
                                                width: 18,
                                              ),
                                              Text(
                                                  snapshot.data.result[index].dob ??
                                                      "",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18))
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                          height: 25,
                                          thickness: 2,
                                          indent: 15,
                                          endIndent: 15,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.shopping_bag,
                                                  color: Colors.orange, size: 25),
                                              SizedBox(
                                                width: 18,
                                              ),
                                              Text(
                                                  snapshot.data.result[index]
                                                          .profession ??
                                                      "",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18))
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                          height: 25,
                                          thickness: 2,
                                          indent: 15,
                                          endIndent: 15,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.email,
                                                color: Colors.orange,
                                                size: 25,
                                              ),
                                              SizedBox(
                                                width: 18,
                                              ),
                                              Text(
                                                  snapshot.data.result[index]
                                                          .email ??
                                                      "",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )*/
                                ],
                              ),
                            );
                          });
                    } else {
                      return Container();
                    }
                  } else if (snapshot.hasError) {
                    return OfflineWidget(context);
                    // return Center(child: Text('Something went wrong...'));
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Container();
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    //return Container();
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ));
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

  Widget profilepic(
    BuildContext context,
    String name,
    String email,
    String gender,
    String profession,
    String dob,
    String imageUrl,
    String district,
  ) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenwidth * .20,
      width: screenwidth * .30,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(
              "assets/images/profile.png",
            ),
          ),
          Positioned(
              bottom: 0,
              right: -25,
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerProfileEdit(
                                mobile: mobileNumber,
                                name: name,
                                emailID: email,
                                gender: gender,
                                profession: profession,
                                dOB: dob,
                                image: imageUrl,
                                hometown: district,
                              )));
                },
                elevation: 2.0,
                fillColor: Color(0xFFF5F6F9),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.blue,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              )),
        ],
      ),
    );
  }
}

Future<void> _launchURL() async {
  var usrId = await userData().getUserId();
  var mob = await userData().getMobileNo();
  var api_key = await userData().getApiKey;

  var _url = Urls.complaintRegistration +
      "?" +
      "UserID=" +
      "$usrId" +
      "&" +
      "Mobile=" +
      "$mob" +
      "&" +
      "Mobile=" +
      "$api_key";
  //"UserID"=user.getUserId()} & "Mobile"=&api_key=await userData().getApiKey};

  await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}
