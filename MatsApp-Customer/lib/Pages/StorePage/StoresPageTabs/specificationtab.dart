import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:matsapp/Modeles/ProductListModel.dart';
import 'package:matsapp/Modeles/ProductModel.dart';
import 'package:matsapp/Network/ProductListRepo.dart';
import 'package:matsapp/Network/ProductRepo.dart';

// ignore: camel_case_types
class speciicationtab extends StatefulWidget {
  final int productId;

  final String selectedtown;
  speciicationtab(this.productId, this.selectedtown);
  @override
  _specificationtabState createState() => _specificationtabState();
}

// ignore: camel_case_types
class _specificationtabState extends State<speciicationtab> {
  Future futureProduct;
  @override
  void initState() {
    super.initState();
    setState(() {
      futureProduct =
          fetchTopProductList(widget.productId, widget.selectedtown);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 5),
        child: FutureBuilder<ProductListModel>(
            future: futureProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String content =
                    snapshot.data.result.first.specification.toString();
                //String cleanText = content.replaceAll('&nbsp;', ' ');
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Center(
                          child: Html(
                            data: content,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
