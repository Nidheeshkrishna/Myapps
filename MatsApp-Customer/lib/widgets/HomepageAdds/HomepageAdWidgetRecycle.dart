import 'package:flutter/material.dart';

class HomepageAdWidgetRecycle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recycle Outlet In Your Area",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 10,
                    onPrimary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    )),
                child: Text("View All",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[600])),
                onPressed: () {},
              )
            ],
          ),
          Stack(
            children: [
              Card(
                  elevation: 10,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.asset(
                    "assets/PRODUCT/add3.jpg",
                    fit: BoxFit.fill,
                  )),
              // Positioned(
              //   top: 110,
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.height * .10,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         Text(
              //           "Lorem Ipsum Dolor",
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 20),
              //         ),
              //         FloatingActionButton(
              //           backgroundColor: Colors.white,
              //           foregroundColor: Colors.black,
              //           child: Icon(
              //             Icons.keyboard_arrow_right,
              //             size: 40,
              //           ),
              //           onPressed: () {},
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ],
      ),
    ));
  }
}
