import 'package:flutter/cupertino.dart';
import 'package:matsapp/Modeles/coupon_generate/result_model.dart';
import 'package:matsapp/Modeles/find/find_category_model.dart';
import 'package:matsapp/Modeles/find/find_enquiry_model.dart';
import 'package:matsapp/Modeles/find/find_stores_model.dart';
import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/models/loading_status.dart';
import 'package:matsapp/services/find/find_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class ScannedImageChangeAction {
  final String file;

  ScannedImageChangeAction(this.file);
}

class SelectedFindCategoryAction {
  final FindCategoryModel category;
  final bool isSelected;

  SelectedFindCategoryAction(this.category, this.isSelected);
}

class FindCategoriesFetchedAction {
  final List<FindCategoryModel> categories;

  FindCategoriesFetchedAction(this.categories);
}

class EnquiriesFetchedAction {
  final List<EnquiryModel> enquiries;

  EnquiriesFetchedAction(this.enquiries);
}

class StoresFetchedAction {
  final List<FindStoresModel> stores;
  final EnquiryModel enquiry;

  StoresFetchedAction(this.stores, this.enquiry);
}

class ShopMarkedFavouriteAction {
  final ResultModel result;
  final bool wasFav;
  final FindStoresModel shop;

  ShopMarkedFavouriteAction(this.result, this.wasFav, this.shop);
}

class EnquirySavedAction {
  final ResultModel result;

  EnquirySavedAction(this.result);
}

ThunkAction fetchFindCategoriesAction() {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
          status: LoadingStatus.loading,
          message: "Getting Coupons",
          type: "Find"));

      FindRepository().getCategories(onSuccess: (result) {
        store.dispatch(FindCategoriesFetchedAction(result));
      }, failure: (exception) {
        store.dispatch(LoadingAction(
          status: LoadingStatus.error,
          message: exception.toString(),
          type: "Find",
        ));
      });
    });
  };
}

ThunkAction fetchPreviousEnquiries() {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
          status: LoadingStatus.loading,
          message: "Getting Coupons",
          type: "Enquiry"));

      FindRepository().getPreviousEnquiries(onSuccess: (result) {
        store.dispatch(EnquiriesFetchedAction(result));
      }, failure: (exception) {
        store.dispatch(LoadingAction(
          status: LoadingStatus.error,
          message: exception.toString(),
          type: "Enquiry",
        ));
      });
    });
  };
}

ThunkAction fetchLocalStores({@required EnquiryModel enquiry}) {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
          status: LoadingStatus.loading,
          message: "Getting Stores",
          type: "Find"));

      FindRepository().getStores(
        enquiry: enquiry,
        onSuccess: (result) {
          store.dispatch(StoresFetchedAction(result, enquiry));
        },
        failure: (exception) {
          store.dispatch(LoadingAction(
            status: LoadingStatus.error,
            message: exception.toString(),
            type: "Find",
          ));
        },
      );
    });
  };
}

ThunkAction markStoreAsFavoriteAction(bool wasFav, FindStoresModel shop) {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
          status: LoadingStatus.loading, message: "", type: "Find"));

      FindRepository().markStoreAsFavorite(
          isFavourite: wasFav,
          shop: shop,
          onSuccess: (result) {
            store.dispatch(ShopMarkedFavouriteAction(result, wasFav, shop));
          },
          failure: (exception) {
            store.dispatch(LoadingAction(
              status: LoadingStatus.error,
              message: exception.toString(),
              type: "Find",
            ));
          });
    });
  };
}

ThunkAction saveEnquiryAction(
    String scannedImage, String remarks, FindCategoryModel category) {
  return (Store store) async {
    Future(() async {
      store.dispatch(LoadingAction(
          status: LoadingStatus.loading,
          message: "Save Enquiry",
          type: "Find"));

      FindRepository().saveEnquiry(
          category: category,
          scannedImage: scannedImage,
          remarks: remarks,
          onSuccess: (result) {
            store.dispatch(EnquirySavedAction(result));
          },
          failure: (exception) {
            store.dispatch(LoadingAction(
              status: LoadingStatus.error,
              message: exception.toString(),
              type: "Find",
            ));
          });
    });
  };
}
