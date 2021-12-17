import 'package:flutter/foundation.dart';
import 'package:matsapp/Modeles/GetStoredetailesModel.dart';
import 'package:matsapp/Modeles/ProductListModel.dart';
import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
import 'package:matsapp/Network/GetStoreDetailesRest.dart';
import 'package:matsapp/Network/HomeScreenServices/homeScreenRepo.dart';

class PostDataProvider with ChangeNotifier {
  HomePageModel post = HomePageModel();
  GetStoredetailesModel StoresData = GetStoredetailesModel();
  ProductListModel exclusivePost = ProductListModel();
  bool loading = false;
  bool storeloading = false;
  // fetchStordetailes
  String errorMessages = "";

  getPostData(context) async {
    loading = true;
    await fetchHomeData().catchError((e) async {
      print("exception catche$e");
      if (e
          .toString()
          .contains("Error During Communication:  : No Internet connection")) {
        errorMessages = e.toString();
        loading = true;
      } else {
        post = await fetchHomeData();
        loading = false;
        notifyListeners();
        //post= await fetchHomeData();
      }
    }).then((value) => {
          errorMessages = "success",
          post = value,
          loading = false,
          notifyListeners(),
        });
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
