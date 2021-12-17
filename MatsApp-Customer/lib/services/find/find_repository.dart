import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/coupon_generate/result_model.dart';
import 'package:matsapp/Modeles/find/find_category_model.dart';
import 'package:matsapp/Modeles/find/find_enquiry_model.dart';
import 'package:matsapp/Modeles/find/find_stores_model.dart';
import 'package:matsapp/utilities/app_json_parser.dart';

import '../base_service.dart';

class FindRepository extends BaseService {
  static FindRepository _instance = FindRepository._();

  FindRepository._() : super();

  factory FindRepository() {
    return _instance;
  }

  Future<void> getCategories({
    onSuccess<List<FindCategoryModel>> onSuccess,
    onFailure failure,
  }) async {
    int userId = await getUserId();
    var params = {"UserID": userId};

    getService(
        service: "GetCategoriesForFind",
        params: params,
        onException: failure,
        onSuccess: (response) {
          List<FindCategoryModel> notifications =
              AppJsonParser.goodList(response, "result")
                  .map((e) => FindCategoryModel.fromJson(e))
                  .toList();
          onSuccess(notifications);
        });
  }

  Future<void> getPreviousEnquiries({
    onSuccess<List<EnquiryModel>> onSuccess,
    onFailure failure,
  }) async {
    String mobileNo = await getMobileNo();
    //mobileNo = "8289845141";
    var params = {"mobile": mobileNo};

    getService(
        service: "getEnquiries",
        params: params,
        onException: failure,
        onSuccess: (response) {
          List<EnquiryModel> enquiries =
              AppJsonParser.goodList(response, "result")
                  .map((e) => EnquiryModel.fromJson(e))
                  .toList();
          onSuccess(enquiries);
        });
  }

  Future<void> getStores({
    @required EnquiryModel enquiry,
    onSuccess<List<FindStoresModel>> onSuccess,
    onFailure failure,
  }) async {
    String mobileNo = await getMobileNo();
    //mobileNo = "8289845141";
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    );

    var params = {
      "mobile": mobileNo,
      "FindID": enquiry.id,
      "UserLatitude": position?.latitude,
      "UserLongitude": position?.longitude,
    };

    getService(
        service: "getResponseInfo",
        params: params,
        onException: failure,
        onSuccess: (response) {
          List<FindStoresModel> enquiries =
              AppJsonParser.goodList(response, "Stores")
                  .map((e) => FindStoresModel.fromJson(e))
                  .toList();
          onSuccess(enquiries);
        });
  }

  Future<void> markStoreAsFavorite({
    bool isFavourite,
    onSuccess<ResultModel> onSuccess,
    onFailure failure,
    FindStoresModel shop,
  }) async {
    String mobileNo = await getMobileNo();

    var params;
    if (isFavourite)
      params = {
        "mobile": mobileNo,
        "wishListID": shop.wishListId,
      };
    else
      params = {
        "mobile": mobileNo,
        "category": "Business",
        "categoryid": "${shop.businessId}"
      };

    getService(
        service: isFavourite ? "RemovefromWishList" : "AddtoWishList",
        params: params,
        onException: failure,
        onSuccess: (response) {
          ResultModel result = ResultModel.fromJson(response);
          onSuccess(result);
        });
  }

  Future<void> saveEnquiry({
    FindCategoryModel category,
    onSuccess<ResultModel> onSuccess,
    onFailure failure,
    String scannedImage,
    String remarks,
  }) async {
    String mobileNo = await getMobileNo();
    String town = await getSelectedTown();
    String district = await getSelectedDistrict();
    String state = await getSelectedState();
    //mobileNo = "8289845141";
    var params = {
      "mobile": mobileNo,
      "Userdescription": remarks,
      "State": state,
      "District": district,
      'Town': town,
      'CategoryID': category.id,
    };

    uploadImage(
        service: "SaveFindInfo",
        path: scannedImage,
        params: params,
        onException: failure,
        onSuccess: (response) {
          ResultModel result = ResultModel.fromJson(response);

          onSuccess(result);
        });
  }
}
