import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:matsapp/Network/ProfileEditRepo.dart';
import 'package:matsapp/Network/UpdteProfilePicRepo.dart';
import 'package:matsapp/Pages/ProfilePages/ChangePassword.dart';

import 'package:matsapp/Pages/ProfilePages/ProfileViewpage.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:flutter/material.dart';

import 'package:wc_form_validators/wc_form_validators.dart';

class CustomerProfileEdit extends StatefulWidget {
  final String mobile, name, emailID, gender, profession, dOB, image, hometown;
  CustomerProfileEdit(
      {this.mobile,
      this.name,
      this.emailID,
      this.gender,
      this.profession,
      this.dOB,
      this.image,
      this.hometown});
  @override
  _CustomerEditState createState() => _CustomerEditState();
}

class _CustomerEditState extends State<CustomerProfileEdit> {
  TextEditingController nameController = TextEditingController();
  //TextEditingController hometownController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  //TextEditingController dateofbirthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  DateTime _selectedDate;
  final _form = GlobalKey<FormState>();
  final picker = ImagePicker();

  static MediaQueryData _mediaQueryData;
  static double screenheight = _mediaQueryData.size.height;
  static double screenwidth = _mediaQueryData.size.width;
  String dateofBirth;
  final formKey = new GlobalKey<FormState>();
  Future profilepage;
  bool isload = false;
  bool isload1 = false;

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  File _image;

  String imagepath;

  int status1;

  String dropdownValue;

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  Widget showImage() {
    return Container(
      width: screenwidth * .99,
      height: screenheight * .25,
      child: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(),
        inAsyncCall: isload1,
        dismissible: false,
        opacity: 0,
        child: Center(
          child: Container(
            width: screenwidth,
            height: screenheight,
            child: _image != null
                ? SizedBox(
                    width: screenwidth,
                    height: screenheight * .50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.loose,
                          children: [
                            CircleAvatar(
                                radius: 90,
                                backgroundImage: FileImage(_image, scale: 1.0)),
                            Positioned(
                                bottom: 20,
                                right: -25,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    _showSelectionDialog(context)
                                        .then((value) => {
                                              updateProfilePic(
                                                      imagepath, widget.mobile)
                                                  .then((value) => {
                                                        setState(() {
                                                          isload1 = true;
                                                        }),
                                                        if (value.result == 1)
                                                          {
                                                            setState(() {
                                                              isload1 = false;
                                                            }),
                                                            GeneralTools()
                                                                .createSnackBarCommon(
                                                                    "Image Uploaded",
                                                                    context)
                                                          }
                                                        else
                                                          {
                                                            setState(() {
                                                              isload1 = false;
                                                            }),
                                                            GeneralTools()
                                                                .createSnackBarFailed(
                                                                    "Image Uploaded failed",
                                                                    context)
                                                          }
                                                      })
                                                  .timeout(
                                                      Duration(seconds: 10))
                                            });
                                    ;
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
                      ],
                    ),
                  )
                : Container(
                    width: screenwidth,
                    height: screenheight * 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.image == null
                            ? SizedBox(
                                height: screenheight * .30,
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
                                        bottom: 20,
                                        right: -25,
                                        child: RawMaterialButton(
                                          onPressed: () {
                                            _showSelectionDialog(context)
                                                .then((value) => {
                                                      updateProfilePic(
                                                              imagepath,
                                                              widget.mobile)
                                                          .then((value) => {
                                                                setState(() {
                                                                  isload1 =
                                                                      true;
                                                                }),
                                                                if (value
                                                                        .result ==
                                                                    1)
                                                                  {
                                                                    setState(
                                                                        () {
                                                                      isload1 =
                                                                          false;
                                                                    }),
                                                                    GeneralTools().createSnackBarCommon(
                                                                        "Image Uploaded",
                                                                        context)
                                                                  }
                                                                else
                                                                  {
                                                                    setState(
                                                                        () {
                                                                      isload1 =
                                                                          false;
                                                                    }),
                                                                    GeneralTools().createSnackBarFailed(
                                                                        "Image Uploaded failed",
                                                                        context)
                                                                  }
                                                              })
                                                          .timeout(Duration(
                                                              seconds: 10))
                                                    });
                                            ;
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
                              )
                            : CachedNetworkImage(
                                imageUrl: widget.image,
                                errorWidget: (context, url, error) => SizedBox(
                                      height: screenheight * .30,
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
                                              bottom: 20,
                                              right: -25,
                                              child: RawMaterialButton(
                                                onPressed: () {
                                                  _showSelectionDialog(context)
                                                      .then((value) => {
                                                            updateProfilePic(
                                                                    imagepath,
                                                                    widget
                                                                        .mobile)
                                                                .then(
                                                                    (value) => {
                                                                          setState(
                                                                              () {
                                                                            isload1 =
                                                                                true;
                                                                          }),
                                                                          if (value.result ==
                                                                              1)
                                                                            {
                                                                              setState(() {
                                                                                isload1 = false;
                                                                              }),
                                                                              GeneralTools().createSnackBarCommon("Image Uploaded", context)
                                                                            }
                                                                          else
                                                                            {
                                                                              setState(() {
                                                                                isload1 = false;
                                                                              }),
                                                                              GeneralTools().createSnackBarFailed("Image Uploaded failed", context)
                                                                            }
                                                                        })
                                                                .timeout(
                                                                    Duration(
                                                                        seconds:
                                                                            10))
                                                          });
                                                  ;
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
                                    ),
                                imageBuilder:
                                    (context, imageProvider) => CircleAvatar(
                                          radius: 90,
                                          backgroundImage:
                                              NetworkImage(widget.image),
                                          child: Stack(children: [
                                            Positioned(
                                              bottom: 0,
                                              right: 20,
                                              child: CircleAvatar(
                                                radius: 18,
                                                backgroundColor: Colors.white70,
                                                child: InkWell(
                                                  child: Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: Colors.blue,
                                                  ),
                                                  onTap: () {
                                                    _showSelectionDialog(
                                                            context)
                                                        .then((value) => {
                                                              updateProfilePic(
                                                                      imagepath,
                                                                      widget
                                                                          .mobile)
                                                                  .then(
                                                                      (value) =>
                                                                          {
                                                                            setState(() {
                                                                              isload1 = true;
                                                                            }),
                                                                            if (value.result ==
                                                                                1)
                                                                              {
                                                                                setState(() {
                                                                                  isload1 = false;
                                                                                }),
                                                                                GeneralTools().createSnackBarCommon("Image Uploaded", context)
                                                                              }
                                                                            else
                                                                              {
                                                                                setState(() {
                                                                                  isload1 = false;
                                                                                }),
                                                                                GeneralTools().createSnackBarFailed("Image Uploaded failed", context)
                                                                              }
                                                                          })
                                                                  .timeout(Duration(
                                                                      seconds:
                                                                          10))
                                                            });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ))
                      ],
                    )),
          ),
        ),
      ),
    );
  }

  // String dropdownValue = 'Male';
  String dropdownValueprof;
  bool user_status;

  @override
  void initState() {
    super.initState();

    setState(() {
      //hometownController.text = widget.hometown;
      nameController.text = widget.name;
      mobileController.text = widget.mobile;

      //dateofbirthController.text = widget.dOB;
      emailController.text = widget.emailID;
      dropdownValueprof = widget.profession;
      dropdownValue = widget.gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileViewpage(widget.mobile)));
      },
      child: ModalProgressHUD(
        progressIndicator:
            Center(child: SpinKitHourGlass(color: Color(0xffFFB517))),
        inAsyncCall: isload,
        dismissible: false,
        opacity: 0,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 5,
            automaticallyImplyLeading: true,
            backgroundColor: Colors.white,
            title: Text("Edit Profile", style: TextStyle(fontSize: 18)),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: Container(
            height: screenheight,
            width: screenwidth,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Form(
                key: _form,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   width: screenwidth * .98,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       // ElevatedButton(
                    //       //   style: ElevatedButton.styleFrom(
                    //       //       primary: Theme.of(context).accentColor,
                    //       //       elevation: 10,
                    //       //       onPrimary: Colors.blue,
                    //       //       shape: RoundedRectangleBorder(
                    //       //           borderRadius: BorderRadius.circular(7.0),
                    //       //           side: BorderSide(
                    //       //             color: Theme.of(context).accentColor,
                    //       //           ))),
                    //       //   child: Text("Update",
                    //       //       style: TextStyle(
                    //       //           fontWeight: FontWeight.bold,
                    //       //           color: Colors.white)),
                    //       //   onPressed: () {
                    //       //     if (_form.currentState.validate()) {
                    //       //       setState(() {
                    //       //         isload = true;
                    //       //       });
                    //       //       fetchProfilepage(
                    //       //               mobileController.text,
                    //       //               nameController.text,
                    //       //               emailController.text,
                    //       //               "",
                    //       //               "",
                    //       //               ""
                    //       //               //dropdownValue,
                    //       //               // dropdownValueprof,
                    //       //               //dateofBirth ??
                    //       //               // dateofbirthController.text.toString(),
                    //       //               )
                    //       //           .then((value) => {
                    //       //                 user_status = value.result,
                    //       //               })
                    //       //           .whenComplete(() async {
                    //       //         if (user_status == true) {
                    //       //           setState(() {
                    //       //             isload = false;
                    //       //           });
                    //       //           GeneralTools().createSnackBarSuccess(
                    //       //               "Profile Updated Successfully",
                    //       //               context);
                    //       //           await Future.delayed(Duration(seconds: 1));
                    //       //           Navigator.pushReplacement(
                    //       //               context,
                    //       //               MaterialPageRoute(
                    //       //                   builder: (context) =>
                    //       //                       ProfileViewpage()));
                    //       //         } else if (user_status = false) {
                    //       //           setState(() {
                    //       //             isload = false;
                    //       //           });
                    //       //           await Future.delayed(Duration(seconds: 1));
                    //       //           GeneralTools().createSnackBarFailed(
                    //       //               "Profile Updated failed", context);
                    //       //         }
                    //       //       });
                    //       //     }
                    //       //   },
                    //       // ),
                    //     ],
                    //   ),
                    // ),
                    // Expanded(
                    //     flex: 10,child:
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                          child: showImage(),
                          onTap: () {
                            // _showSelectionDialog(context);
                          }),
                      //)
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            //keyboardType: TextInputType.text,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            validator: Validators.compose([
                              Validators.required("Enter Your Name"),
                            ]),

                            // onSaved: (_) {},
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.black),
                              hintText: 'Name',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.yellow[700], width: 2),
                                  borderRadius: BorderRadius.circular(3)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.yellow[700], width: 2),
                                  borderRadius: BorderRadius.circular(3)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 2),
                                  borderRadius: BorderRadius.circular(3)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2),
                                  borderRadius: BorderRadius.circular(3)),
                            ),
                          ),
                          // SizedBox(
                          //   height: 20.0,
                          // ),
                          // TextFormField(
                          //   style: TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.bold),
                          //   controller: hometownController,
                          //   //keyboardType: TextInputType.text,
                          //   validator: Validators.compose([
                          //     Validators.required("Enter Your Home Town"),
                          //   ]),

                          //   onSaved: (_) {},
                          //   decoration: InputDecoration(
                          //     labelStyle: TextStyle(color: Colors.black),
                          //     hintText: 'Home Town',
                          //     enabledBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Colors.yellow[700], width: 2),
                          //         borderRadius: BorderRadius.circular(3)),
                          //     focusedBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Colors.yellow[700], width: 2),
                          //         borderRadius: BorderRadius.circular(3)),
                          //     focusedErrorBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Colors.orange, width: 2),
                          //         borderRadius: BorderRadius.circular(3)),
                          //     errorBorder: OutlineInputBorder(
                          //         borderSide:
                          //             BorderSide(color: Colors.red, width: 2),
                          //         borderRadius: BorderRadius.circular(3)),
                          //   ),
                          // ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            validator: Validators.compose([
                              Validators.required("Mobile Number required"),
                              Validators.maxLength(10, 'Max Length is 10'),
                              Validators.minLength(10, 'Minimum Length is 10')
                            ]),
                            onSaved: (_) {},
                            decoration: InputDecoration(
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              hintText: 'Mobile Number',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.yellow[700], width: 2),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.yellow[700], width: 2),
                                  borderRadius: BorderRadius.circular(3)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 2),
                                  borderRadius: BorderRadius.circular(3)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2),
                                  borderRadius: BorderRadius.circular(3)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Container(
                          //   width: screenwidth,
                          //   height: 60,
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //     children: [
                          //       Expanded(
                          //         child: Container(
                          //           height: 80,
                          //           child: TextFormField(
                          //             textAlign: TextAlign.center,
                          //             controller: dateofbirthController,
                          //             validator: Validators.compose([
                          //               Validators.required(
                          //                   "Date of birth required")
                          //             ]),
                          //             style: TextStyle(
                          //                 color: Colors.black,
                          //                 fontSize: 12,
                          //                 fontWeight: FontWeight.bold),
                          //             keyboardType: TextInputType.datetime,
                          //             readOnly: true,
                          //             decoration: InputDecoration(
                          //               contentPadding:
                          //                   EdgeInsets.symmetric(vertical: 10),
                          //               labelStyle:
                          //                   TextStyle(color: Colors.black),
                          //               labelText: 'DoB',
                          //               enabledBorder: OutlineInputBorder(
                          //                   borderSide: BorderSide(
                          //                       color: Colors.yellow[700],
                          //                       width: 2),
                          //                   borderRadius:
                          //                       BorderRadius.circular(3)),
                          //               focusedBorder: OutlineInputBorder(
                          //                   borderSide: BorderSide(
                          //                       color: Colors.yellow[700],
                          //                       width: 2),
                          //                   borderRadius:
                          //                       BorderRadius.circular(3)),
                          //               focusedErrorBorder: OutlineInputBorder(
                          //                   borderSide: BorderSide(
                          //                       color: Colors.orange, width: 2),
                          //                   borderRadius:
                          //                       BorderRadius.circular(3)),
                          //               errorBorder: OutlineInputBorder(
                          //                   borderSide: BorderSide(
                          //                       color: Colors.red, width: 2),
                          //                   borderRadius:
                          //                       BorderRadius.circular(3)),
                          //               suffixIcon: IconButton(
                          //                 color: Colors.blueGrey,
                          //                 icon: Icon(
                          //                     Icons.calendar_today_rounded),
                          //                 onPressed: () {
                          //                   _pickDateDialog(context);
                          //                 },
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       SizedBox(width: 15),
                          //       Expanded(
                          //         child: Container(
                          //           height: 90,
                          //           child: DropdownButtonFormField<String>(
                          //             //itemHeight: 70,

                          //             value: dropdownValue,

                          //             validator: (value) => value == null
                          //                 ? "Select your Gender"
                          //                 : null,
                          //             onChanged: (String newValue) {
                          //               setState(() {
                          //                 dropdownValue = newValue;
                          //               });
                          //             },
                          //             items: <String>['Male', 'Female']
                          //                 .map<DropdownMenuItem<String>>(
                          //                     (String value) {
                          //               return DropdownMenuItem<String>(
                          //                 value: value,
                          //                 child: Text(
                          //                   value,
                          //                   style: TextStyle(
                          //                       fontSize: 12,
                          //                       fontWeight: FontWeight.bold),
                          //                 ),
                          //               );
                          //             }).toList(),
                          //             decoration: InputDecoration(
                          //               contentPadding: EdgeInsets.all(5),
                          //               labelText: "Gender",
                          //               labelStyle:
                          //                   TextStyle(color: Colors.black),
                          //               enabledBorder: OutlineInputBorder(
                          //                   borderSide: BorderSide(
                          //                       color: Colors.yellow[700],
                          //                       width: 2),
                          //                   borderRadius:
                          //                       BorderRadius.circular(3)),
                          //               focusedBorder: OutlineInputBorder(
                          //                   borderSide: BorderSide(
                          //                       color: Colors.yellow[700],
                          //                       width: 2),
                          //                   borderRadius:
                          //                       BorderRadius.circular(3)),
                          //               focusedErrorBorder: OutlineInputBorder(
                          //                   borderSide: BorderSide(
                          //                       color: Colors.orange, width: 2),
                          //                   borderRadius:
                          //                       BorderRadius.circular(3)),
                          //               errorBorder: OutlineInputBorder(
                          //                   borderSide: BorderSide(
                          //                       color: Colors.red, width: 1),
                          //                   borderRadius:
                          //                       BorderRadius.circular(3)),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 5.0,
                          // ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            controller: emailController,
                            // autovalidateMode:
                            //     AutovalidateMode.onUserInteraction,
                            validator: Validators.compose([
                              Validators.email("Enter a valid email id"),
                              Validators.required("Email Id Required"),
                            ]),
                            onSaved: (_) {},
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.black),
                              hintText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.yellow[700], width: 2),
                                  borderRadius: BorderRadius.circular(3)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.yellow[700], width: 2),
                                  borderRadius: BorderRadius.circular(3)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 2),
                                  borderRadius: BorderRadius.circular(3)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2),
                                  borderRadius: BorderRadius.circular(3)),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).accentColor,
                                elevation: 10,
                                onPrimary: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    side: BorderSide(
                                      color: Theme.of(context).accentColor,
                                    ))),
                            child: Text("Update",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            onPressed: () {
                              if (_form.currentState.validate()) {
                                setState(() {
                                  isload = true;
                                });
                                fetchProfilepage(
                                        mobileController.text,
                                        nameController.text,
                                        emailController.text,
                                        null,
                                        null,
                                        null
                                        //dropdownValue,
                                        // dropdownValueprof,
                                        //dateofBirth ??
                                        // dateofbirthController.text.toString(),
                                        )
                                    .then((value) => {
                                          user_status = value.result,
                                        })
                                    .whenComplete(() async {
                                  if (user_status == true) {
                                    setState(() {
                                      isload = false;
                                    });
                                    GeneralTools().createSnackBarSuccess(
                                        "Profile Updated Successfully",
                                        context);
                                    await Future.delayed(Duration(seconds: 1));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileViewpage(
                                                    widget.mobile)));
                                  } else if (user_status = false) {
                                    setState(() {
                                      isload = false;
                                    });
                                    await Future.delayed(Duration(seconds: 1));
                                    GeneralTools().createSnackBarFailed(
                                        "Profile Updated failed", context);
                                  }
                                });
                              }
                            },
                          ),
                          // DropdownButtonFormField<String>(
                          //   style: TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.bold),
                          //   validator: (value) {
                          //     if (value == null) {
                          //       return 'Profession required';
                          //     }
                          //     return null;
                          //   },
                          //   value: dropdownValueprof,
                          //   onChanged: (String newValue) {
                          //     setState(() {
                          //       dropdownValueprof = newValue;
                          //     });
                          //   },
                          //   items: <String>[
                          //     'IT',
                          //     'Bussiness',
                          //     'Teaching',
                          //     'etc'
                          //   ].map<DropdownMenuItem<String>>((String value) {
                          //     return DropdownMenuItem<String>(
                          //       value: value,
                          //       child: Text(value),
                          //     );
                          //   }).toList(),
                          //   decoration: InputDecoration(
                          //     labelStyle: TextStyle(color: Colors.black),
                          //     labelText: 'Profession',
                          //     enabledBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Colors.yellow[700], width: 2),
                          //         borderRadius: BorderRadius.circular(3)),
                          //     focusedBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Colors.yellow[700], width: 2),
                          //         borderRadius: BorderRadius.circular(3)),
                          //     focusedErrorBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Colors.orange, width: 2),
                          //         borderRadius: BorderRadius.circular(3)),
                          //     errorBorder: OutlineInputBorder(
                          //         borderSide:
                          //             BorderSide(color: Colors.red, width: 2),
                          //         borderRadius: BorderRadius.circular(3)),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     InkWell(
                          //       child: Text(
                          //         'Change Password',
                          //         style: TextStyle(
                          //             color: Colors.blue[800],
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 16),
                          //       ),
                          //       onTap: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => ChangePassword()),
                          //         );
                          //       },
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Take photo from?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imagepath = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imagepath = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
    Navigator.of(context).pop();
  }

  //Method for showing the date picker
  void _pickDateDialog(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      /*setState(() {
        //for rebuilding the ui
        //
        //_selectedDate = pickedDate;
        /*dateofbirthController.text =
            DateFormat("dd/MM/yyyy").format(_selectedDate).toString();
        dateofBirth = DateFormat("yyyy/MM/dd").format(_selectedDate).toString();
        print("Dobssssssssssss$dateofBirth");*/
      });*/
    });
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  Widget profileForm(BuildContext context) {
    return Container(
        child: Column(
      children: [],
    ));
  }

  Widget profilepic(BuildContext context, [String imagepath]
      // String name,
      // String email,
      // String gender,
      // String profession,
      // String dob,
      // String imageUrl,
      // String district,
      ) {
    return SizedBox(
      height: screenheight * .30,
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
              bottom: 20,
              right: -25,
              child: RawMaterialButton(
                onPressed: () {
                  _showSelectionDialog(context).then((value) => {
                        updateProfilePic(imagepath, widget.mobile)
                            .then((value) => {
                                  setState(() {
                                    isload1 = true;
                                  }),
                                  if (value.result == 1)
                                    {
                                      setState(() {
                                        isload1 = false;
                                      }),
                                      GeneralTools().createSnackBarCommon(
                                          "Image Uploaded", context)
                                    }
                                  else
                                    {
                                      setState(() {
                                        isload1 = false;
                                      }),
                                      GeneralTools().createSnackBarFailed(
                                          "Image Uploaded failed", context)
                                    }
                                })
                            .timeout(Duration(seconds: 10))
                      });
                  ;
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
