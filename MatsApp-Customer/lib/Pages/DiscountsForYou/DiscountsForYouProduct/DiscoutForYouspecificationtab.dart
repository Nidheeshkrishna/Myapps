import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:matsapp/Modeles/ProductListModel.dart';
import 'package:matsapp/Modeles/ProductModel.dart';
import 'package:matsapp/Network/ProductRepo.dart';

// ignore: camel_case_types
class DiscoutForYouspecificationtab extends StatefulWidget {
  final int productId;

  final String selectedtown;
  DiscoutForYouspecificationtab(this.productId, this.selectedtown);
  @override
  _specificationtabState createState() => _specificationtabState();
}

// ignore: camel_case_types
class _specificationtabState extends State<DiscoutForYouspecificationtab> {
  Future futureProduct;
  @override
  void initState() {
    super.initState();
    setState(() {
      futureProduct = fetchTopProduct(widget.productId, widget.selectedtown);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<ProductListModel>(
            future: futureProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String content = snapshot.data.result.first.specification.toString();
                String cleanText = content.replaceAll('nbsp;', ' ');
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Html(data: cleanText),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ));
              }
            }));
  }
}
