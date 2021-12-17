import 'package:flutter/foundation.dart';
import 'package:matsapp/Modeles/GetStoredetailesModel.dart';
import 'package:matsapp/Modeles/ProductListModel.dart';

import 'package:matsapp/Modeles/homePageModels/HomePageWithOffersModel.dart';
import 'package:matsapp/Network/GetStoreDetailesRest.dart';
import 'package:matsapp/Network/HomeScreenServices/homeScreenRepo.dart';
import 'package:matsapp/Network/HomeScreenServices/homeScreenRepoWithOffers.dart';

class HomePageDataProvider with ChangeNotifier {
  HomePageWithOffersModel post = HomePageWithOffersModel();
  GetStoredetailesModel StoresData = GetStoredetailesModel();
  ProductListModel exclusivePost = ProductListModel();
  bool loading = false;
  bool storeloading = false;
  // fetchStordetailes
  String errorMessages;

  getPostData(context, bool refreshFlag) async {
    loading = true;
    post = await fetchHomeDataOffers(refreshFlag).catchError((e) {
      //String errorMessage=e.toString();
      print("exception catche$e");
      e
          .toString()
          .contains("Error During Communication:  : No Internet connection");

      {
        errorMessages = e.toString();
      }
    }).whenComplete(() => {loading = false, notifyListeners()});
  }

  getStoreData(context, int businessid) async {
    storeloading = true;
    StoresData = await fetchStordetailes(businessid).catchError((e) {
      //String errorMessage=e.toString();
      print("exception catche$e");
      e
          .toString()
          .contains("Error During Communication:  : No Internet connection");

      {
        errorMessages = e.toString();
      }
    }).whenComplete(() => {storeloading = false, notifyListeners()});
  }
}
