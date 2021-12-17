import 'package:flutter/material.dart';
import 'package:matsapp/widgets/Categorywidgets/CategoryProductListWidget.dart';

class CategoryPage extends StatelessWidget {
  static TextEditingController userNameController;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        title: Text(
          "Electricals and Electronics",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.filter_list),
              color: Colors.black,
              onPressed: () {
                // Navigator.pop(context, true);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            width: screenWidth,
            height: screenHeight,
            child: SingleChildScrollView(
              child: Wrap(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Container(
                      width: screenWidth,
                      height: 60,
                      child: Card(
                        shadowColor: Colors.orange,
                        borderOnForeground: true,
                        elevation: 5,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: TextFormField(
                            controller: userNameController,
                            decoration: const InputDecoration(
                              hintText: 'Search here...',
                              hintStyle: TextStyle(color: Colors.grey),
                              suffixIcon: Icon(Icons.search),

                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical:
                                      15), //Change this value to custom as you like
                              //isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth,
                    height: screenHeight * .1,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: screenWidth * .40,
                            height: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).accentColor,
                                    elevation: 10,
                                    onPrimary: Colors.blue,
                                    shadowColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        side: BorderSide(
                                          color: Theme.of(context).accentColor,
                                        ))),
                                onPressed: () {},
                                child: null,
                              ),
                            ),
                          );
                        }),
                  ),
                  // Container(
                  //   width: screenWidth,
                  //   height: screenHeight * .30,
                  //   child: CategoryWidgetAdd1(),
                  // ),
                  CategoryProductListWidget(),
                  // Container(
                  //   width: screenWidth,
                  //   height: screenHeight * .30,
                  //   child: CategoryWidgetAdd1(),
                  // ),
                ],
              ),
            )),
      ),
    );
  }
}
