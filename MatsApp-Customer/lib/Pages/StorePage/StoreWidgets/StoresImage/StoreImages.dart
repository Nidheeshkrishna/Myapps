import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/GetStoredetailesModel.dart';
import 'package:matsapp/Network/GetStoreDetailesRest.dart';
import 'package:matsapp/Pages/StorePage/StoreWidgets/StoresImage/ImageZoomPage.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';

class StoreImages extends StatefulWidget {
  final int businessId;
  StoreImages(this.businessId);
  @override
  _StoreImagesState createState() => _StoreImagesState();
}

class _StoreImagesState extends State<StoreImages> {
  Future<GetStoredetailesModel> futurestoreDetailes;

  String townSelectedStore;

  String mobileNumber;

  String apikey;

  @override
  void initState() {
    super.initState();
    DatabaseHelper dbHelper = new DatabaseHelper();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
            mobileNumber = value[0].mobilenumber;
            apikey = value[0].apitoken;
            futurestoreDetailes = fetchStordetailes(widget.businessId);
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          FutureBuilder<GetStoredetailesModel>(
              future: futurestoreDetailes,
              builder: (BuildContext context,
                  AsyncSnapshot<GetStoredetailesModel> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.images.length > 0) {
                    return Container(
                      width: screenWidth,
                      height: screenHeight * .42,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Images",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            height: screenHeight * .30,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                //physics: ScrollPhysics(),
                                itemCount: snapshot.data.images.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      //color: Colors.blueAccent,
                                      elevation: 5,
                                      clipBehavior: Clip.hardEdge,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: InkWell(
                                        child: CachedNetworkImage(
                                            imageUrl: snapshot
                                                .data.images[index].imgUrl,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.image, size: 50),
                                            fit: BoxFit.fill,
                                            width: screenWidth * .50,
                                            height: screenHeight * .25),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageZommPage(
                                                          snapshot
                                                              .data
                                                              .images[index]
                                                              .imgUrl,
                                                          snapshot
                                                              .data
                                                              .images[index]
                                                              .imgName)));
                                        },
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
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
    );
  }
}
