import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matsapp/Modeles/AllcategoryModel.dart';
import 'package:matsapp/Network/CategoryAllpagerest.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/widgets/Categorywidgets/GetStorebyCategory.dart';

class CategoryAllpage extends StatefulWidget {
  @override
  CategoryAllpageState createState() => CategoryAllpageState();
}

class CategoryAllpageState extends State<CategoryAllpage> {
  Future categories;

  String mobileNumber;
  String apiKey;

  var townSelectedStore;
  @override
  void initState() {
    super.initState();

    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
            mobileNumber = value[0].mobilenumber;
            apiKey = value[0].apitoken;
            categories =
                fetchAllCategories(mobileNumber, apiKey, townSelectedStore);
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          title: Text(
            "Categories",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(6),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Categories",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              FutureBuilder<AllcategoryModel>(
                  future: categories,
                  builder: (BuildContext context,
                      AsyncSnapshot<AllcategoryModel> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.result.length > 0) {
                        return Container(
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.result.length,
                              physics: ClampingScrollPhysics(),
                              //physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 1 / 1.35
                                      // MediaQuery.of(context).size.height /
                                      //     MediaQuery.of(context).size.width /
                                      //     2.5,
                                      ),
                              itemBuilder: (BuildContext context, int index) {
                                var item = snapshot.data.result[index];
                                return InkWell(
                                  child: Container(
                                    child: Column(children: [
                                      Card(
                                        elevation: 2,

                                        //clipBehavior: Clip.antiAliasWithSaveLayer,
                                        child: Container(
                                          height:
                                              SizeConfig.widthMultiplier * 30,
                                          child: Stack(
                                            children: <Widget>[
                                              Positioned.fill(
                                                top: 5,
                                                bottom: 5,
                                                left: 5,
                                                right: 5,
                                                child: (item.categoryImage
                                                        .endsWith(".svg"))
                                                    ? SvgPicture.network(
                                                        item.categoryImage,
                                                        alignment:
                                                            Alignment.center,
                                                        fit: BoxFit.contain,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .24,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .24,
                                                      )
                                                    : CachedNetworkImage(
                                                        alignment:
                                                            Alignment.center,
                                                        imageUrl:
                                                            item.categoryImage,
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                        fit: BoxFit.contain,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .24,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .24,
                                                      ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: CircleAvatar(
                                                    radius: 18,
                                                    child: ClipOval(
                                                      child: CachedNetworkImage(
                                                        imageUrl: item
                                                            .categoryPartnerLogo,
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.image),
                                                        fit: BoxFit.fill,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .50,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item.categoryName,
                                                softWrap: true,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .heightMultiplier *
                                                        2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GetStorebyCategory(
                                                  item.id, item.categoryName)),
                                    );
                                  },
                                );
                              }),
                        );
                      } else {
                        return Container(
                          width: screenwidth,
                          height: screenhight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: SvgPicture.asset(
                                      "assets/vectors/empty_vector.svg")),
                              Text(
                                "OOPs..!",
                                style: TextStyle(color: AppColors.kAccentColor),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("No Stores To show",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong...'));
                    } else {
                      return Container();
                    }
                  })
            ]),
          ),
        ));
  }
}
